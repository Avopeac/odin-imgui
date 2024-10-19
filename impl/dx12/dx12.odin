package imgui_impl_dx12

import "core:dynlib"
import "core:mem"
import "core:sys/windows"
import "vendor:directx/d3d12"
import "vendor:directx/dxgi"
import "vendor:directx/d3d_compiler"

import imgui "../.."

DX12_Data :: struct {
	d3d12_device:               ^d3d12.IDevice,
	root_signature:             ^d3d12.IRootSignature,
	pipeline_state:             ^d3d12.IPipelineState,
	rtv_format:                 dxgi.FORMAT,
	font_texture_resource:      ^d3d12.IResource,
	h_font_srv_cpu_desc_handle: d3d12.CPU_DESCRIPTOR_HANDLE,
	h_font_srv_gpu_desc_handle: d3d12.GPU_DESCRIPTOR_HANDLE,
	d3d_src_desc_heap:          ^d3d12.IDescriptorHeap,
	num_frames_in_flight:       u32,
	frame_resources:            []DX12_RenderBuffers,
	frame_index:                u32,
}

DX12_RenderBuffers :: struct {
	index_buffer:       ^d3d12.IResource,
	vertex_buffer:      ^d3d12.IResource,
	index_buffer_size:  i32,
	vertex_buffer_size: i32,
}

@(private = "file")
get_backend_data :: proc() -> ^DX12_Data {
	ctx := imgui.get_current_context()
	if ctx != nil {
		return cast(^DX12_Data)(imgui.get_io().backend_renderer_user_data)
	}

	return nil
}

VERTEX_CONSTANT_BUFFER_DX12 :: struct {
	mvp: matrix[4, 4]f32,
}

setup_render_state :: proc(
	draw_data: ^imgui.Draw_Data,
	ctx: ^d3d12.IGraphicsCommandList,
	fr: ^DX12_RenderBuffers,
) {
	bd := get_backend_data()

	// Setup orthographic projection matrix into our constant buffer
	// Our visible imgui space lies from draw_data->display_pos (top left) to draw_data->display_pos+data_data->display_size (bottom right).
	vertex_constant_buffer: VERTEX_CONSTANT_BUFFER_DX12
	{
		L := draw_data.display_pos.x
		R := draw_data.display_pos.x + draw_data.display_size.x
		T := draw_data.display_pos.y
		B := draw_data.display_pos.y + draw_data.display_size.y
		vertex_constant_buffer.mvp = {
			2.0 / (R - L),
			0.0,
			0.0,
			0.0,
			0.0,
			2.0 / (T - B),
			0.0,
			0.0,
			0.0,
			0.0,
			0.5,
			0.0,
			(R + L) / (L - R),
			(T + B) / (B - T),
			0.5,
			1.0,
		}
	}

	// Setup viewport
	vp: d3d12.VIEWPORT
	vp.Width = draw_data.display_size.x
	vp.Height = draw_data.display_size.y
	vp.MinDepth = 0.0
	vp.MaxDepth = 1.0
	vp.TopLeftX = 0.0
	vp.TopLeftY = 0.0
	ctx->RSSetViewports(1, &vp)

	// Bind shader and vertex buffers
	stride: u32 = u32(size_of(imgui.Draw_Vert))
	offset: u32 = 0
	vbv: d3d12.VERTEX_BUFFER_VIEW
	vbv.BufferLocation = fr.vertex_buffer->GetGPUVirtualAddress() + u64(offset)
	vbv.SizeInBytes = u32(fr.vertex_buffer_size) * stride
	vbv.StrideInBytes = stride
	ctx->IASetVertexBuffers(0, 1, &vbv)
	ibv: d3d12.INDEX_BUFFER_VIEW
	ibv.BufferLocation = fr.index_buffer->GetGPUVirtualAddress()
	ibv.SizeInBytes = u32(fr.index_buffer_size) * size_of(imgui.Draw_Idx)
	ibv.Format = size_of(imgui.Draw_Idx) == 2 ? dxgi.FORMAT.R16_UINT : dxgi.FORMAT.R32_UINT
	ctx->IASetIndexBuffer(&ibv)
	ctx->IASetPrimitiveTopology(d3d12.PRIMITIVE_TOPOLOGY.TRIANGLELIST)
	ctx->SetPipelineState(bd.pipeline_state)
	ctx->SetGraphicsRootSignature(bd.root_signature)
	ctx->SetGraphicsRoot32BitConstants(0, 16, &vertex_constant_buffer, 0)

	// Setup blend factor
	blend_factor: [4]f32 = {0.0, 0.0, 0.0, 0.0}
	ctx->OMSetBlendFactor(&blend_factor)
}

render_draw_data :: proc(draw_data: ^imgui.Draw_Data, ctx : ^d3d12.IGraphicsCommandList) {
    // Avoid rendering when minimized
    if draw_data.display_size.x <= 0.0 || draw_data.display_size.y <= 0.0 {
        return
    }

    // FIXME: I'm assuming that this only gets called once per frame!
    // If not, we can't just re-allocate the IB or VB, we'll have to do a proper allocator.
    bd := get_backend_data();
    bd.frame_index = bd.frame_index + 1
    fr := &bd.frame_resources[ bd.frame_index % bd.num_frames_in_flight ]

    // Create and grow vertex/index buffers if needed
    if fr.vertex_buffer == nil || fr.vertex_buffer_size < draw_data.total_vtx_count {
        if fr.vertex_buffer != nil {
            fr.vertex_buffer->Release()
            fr.vertex_buffer = nil
        }
        fr.vertex_buffer_size = draw_data.total_vtx_count + 5000
        props : d3d12.HEAP_PROPERTIES
        props.Type = d3d12.HEAP_TYPE.UPLOAD
        props.CPUPageProperty = d3d12.CPU_PAGE_PROPERTY.UNKNOWN
        props.MemoryPoolPreference = d3d12.MEMORY_POOL.UNKNOWN
        desc : d3d12.RESOURCE_DESC
        desc.Dimension = d3d12.RESOURCE_DIMENSION.BUFFER
        desc.Width = u64(fr.vertex_buffer_size) * size_of(imgui.Draw_Vert)
        desc.Height = 1
        desc.DepthOrArraySize = 1
        desc.MipLevels = 1
        desc.Format = dxgi.FORMAT.UNKNOWN
        desc.SampleDesc.Count = 1
        desc.Layout = d3d12.TEXTURE_LAYOUT.ROW_MAJOR
        desc.Flags = nil
        if bd.d3d12_device->CreateCommittedResource(&props, nil, &desc, d3d12.RESOURCE_STATE_GENERIC_READ, nil, d3d12.IResource_UUID, cast(^rawptr)(&fr.vertex_buffer)) < 0 {
            return
        }
    }
    if fr.index_buffer == nil || fr.index_buffer_size < draw_data.total_idx_count {
        if fr.index_buffer != nil {
            fr.index_buffer->Release()
            fr.index_buffer = nil
        }
        fr.index_buffer_size = draw_data.total_idx_count + 10000;
        props : d3d12.HEAP_PROPERTIES
        props.Type = d3d12.HEAP_TYPE.UPLOAD
        props.CPUPageProperty = d3d12.CPU_PAGE_PROPERTY.UNKNOWN
        props.MemoryPoolPreference = d3d12.MEMORY_POOL.UNKNOWN
        desc : d3d12.RESOURCE_DESC
        desc.Dimension = d3d12.RESOURCE_DIMENSION.BUFFER
        desc.Width = u64(fr.index_buffer_size) * size_of(imgui.Draw_Idx)
        desc.Height = 1
        desc.DepthOrArraySize = 1
        desc.MipLevels = 1
        desc.Format = dxgi.FORMAT.UNKNOWN
        desc.SampleDesc.Count = 1
        desc.Layout = d3d12.TEXTURE_LAYOUT.ROW_MAJOR
        desc.Flags = nil
        if bd.d3d12_device->CreateCommittedResource(&props, nil, &desc, d3d12.RESOURCE_STATE_GENERIC_READ, nil, d3d12.IResource_UUID, cast(^rawptr)(&fr.index_buffer)) < 0 {
            return
        }
    }

    // Upload vertex/index data into a single contiguous GPU buffer
    vtx_resource, idx_resource : rawptr
    range : d3d12.RANGE
    if fr.vertex_buffer->Map(0, &range, &vtx_resource) != windows.S_OK {
        return
    }
    if fr->index_buffer->Map(0, &range, &idx_resource) != windows.S_OK {
        return
    }
    vtx_dst := cast(^imgui.Draw_Vert)vtx_resource
    idx_dst := cast(^imgui.Draw_Vert)idx_resource

    cmd_lists := mem.slice_ptr(draw_data.cmd_lists.data, int(draw_data.cmd_lists.size))
    for cmd_list in cmd_lists {
        mem.copy(vtx_dst, cmd_list.vtx_buffer.data, int(cmd_list.vtx_buffer.size) * size_of(imgui.Draw_Vert))
        mem.copy(idx_dst, cmd_list.idx_buffer.data, int(cmd_list.idx_buffer.size) * size_of(imgui.Draw_Idx))
        vtx_dst = mem.ptr_offset(vtx_dst, cmd_list.vtx_buffer.size)
        idx_dst = mem.ptr_offset(idx_dst, cmd_list.idx_buffer.size)
    }

    fr.vertex_buffer->Unmap(0, &range);
    fr.index_buffer->Unmap(0, &range);

    // Setup desired DX state
    setup_render_state(draw_data, ctx, fr)

    // Render command lists
    // (Because we merged all buffers into a single one, we maintain our own offset into them)
    global_vtx_offset := 0
    global_idx_offset := 0
    clip_off := draw_data.display_pos
    for cmd_list in cmd_lists {
        cmds := mem.slice_ptr(cmd_list.cmd_buffer.data, int(cmd_list.cmd_buffer.size))
        for &cmd in cmds {
            if cmd.user_callback != nil {
                if type_of( cmd.user_callback ) == imgui.Draw_Callback_ResetRenderState {
                    setup_render_state(draw_data, ctx, fr);
                } else {
                    cmd.user_callback(cmd_list, &cmd);
                }
            } else {
                // Project scissor/clipping rectangles into framebuffer space
                clip_min : imgui.Vec2 = { cmd.clip_rect.x - clip_off.x, cmd.clip_rect.y - clip_off.y }
                clip_max : imgui.Vec2 = { cmd.clip_rect.z - clip_off.x, cmd.clip_rect.w - clip_off.y }
                if clip_max.x <= clip_min.x || clip_max.y <= clip_min.y {
                    continue;
                }

                // Apply Scissor/clipping rectangle, Bind texture, Draw
                r : d3d12.RECT = { cast(windows.LONG)clip_min.x, cast(windows.LONG)clip_min.y, cast(windows.LONG)clip_max.x, cast(windows.LONG)clip_max.y}
                texture_handle : d3d12.GPU_DESCRIPTOR_HANDLE;
                texture_handle.ptr = u64(uintptr(imgui.ImDrawCmd_GetTexID(&cmd)))
                ctx->SetGraphicsRootDescriptorTable(1, texture_handle)
                ctx->RSSetScissorRects(1, &r)
                ctx->DrawIndexedInstanced(cmd.elem_count, 1, cmd.idx_offset + u32(global_idx_offset), i32(cmd.vtx_offset) + i32(global_vtx_offset), 0)
            }
        }
        global_idx_offset += int(cmd_list.idx_buffer.size)
        global_vtx_offset += int(cmd_list.vtx_buffer.size)
    }
}

@(private="file")
encode_shader_component_mapping :: #force_inline proc(src0, src1, src2, src3 : int) -> u32 {
    mapping_mask :: 0x7
    mapping_shift :: 3
    always_set_bit_avoiding_zeromem_mistakes :: 1 << (mapping_shift * 4)
    return u32( ( src0 & mapping_mask ) | 
                ( ( src1 & mapping_mask ) << mapping_shift ) |
                ( ( src2 & mapping_mask ) << ( mapping_shift * 2 ) ) |
                ( ( src3 & mapping_mask ) << ( mapping_shift * 3 ) ) |
                always_set_bit_avoiding_zeromem_mistakes )
}

@(private="file")
default_shader_4_component_mapping :: #force_inline proc() -> u32 {
    return encode_shader_component_mapping(0, 1, 2, 3)
}

create_fonts_texture:: proc() {
    // Build texture atlas
    io := imgui.get_io()
    bd := get_backend_data()

    pixels : ^u8
    width, height, bpp : i32
    imgui.ImFontAtlas_GetTexDataAsRGBA32(io.fonts, &pixels, &width, &height, &bpp )

    // Upload texture to graphics system
    {
        props : d3d12.HEAP_PROPERTIES
        props.Type = d3d12.HEAP_TYPE.DEFAULT
        props.CPUPageProperty = d3d12.CPU_PAGE_PROPERTY.UNKNOWN
        props.MemoryPoolPreference = d3d12.MEMORY_POOL.UNKNOWN

        desc : d3d12.RESOURCE_DESC
        desc.Dimension = d3d12.RESOURCE_DIMENSION.TEXTURE2D
        desc.Alignment = 0
        desc.Width = u64(width)
        desc.Height = u32(height)
        desc.DepthOrArraySize = 1
        desc.MipLevels = 1
        desc.Format = dxgi.FORMAT.R8G8B8A8_UNORM
        desc.SampleDesc.Count = 1;
        desc.SampleDesc.Quality = 0;
        desc.Layout = d3d12.TEXTURE_LAYOUT.UNKNOWN
        desc.Flags = nil

        texture : ^d3d12.IResource
        bd->d3d12_device->CreateCommittedResource(&props, nil, &desc,
            { d3d12.RESOURCE_STATE.COPY_DEST }, nil, d3d12.IResource_UUID, cast(^rawptr)(&texture))

        upload_pitch := u32(width * 4 + d3d12.TEXTURE_DATA_PITCH_ALIGNMENT - 1) & ~u32(d3d12.TEXTURE_DATA_PITCH_ALIGNMENT - 1)
        upload_size := u32(height) * upload_pitch
        desc.Dimension = d3d12.RESOURCE_DIMENSION.BUFFER
        desc.Alignment = 0
        desc.Width = u64(upload_size)
        desc.Height = 1
        desc.DepthOrArraySize = 1
        desc.MipLevels = 1
        desc.Format = dxgi.FORMAT.UNKNOWN
        desc.SampleDesc.Count = 1
        desc.SampleDesc.Quality = 0
        desc.Layout = d3d12.TEXTURE_LAYOUT.ROW_MAJOR
        desc.Flags = nil;

        props.Type = d3d12.HEAP_TYPE.UPLOAD
        props.CPUPageProperty = d3d12.CPU_PAGE_PROPERTY.UNKNOWN
        props.MemoryPoolPreference = d3d12.MEMORY_POOL.UNKNOWN

        upload_buffer : ^d3d12.IResource
        hr := bd->d3d12_device->CreateCommittedResource(&props, nil, &desc,
            d3d12.RESOURCE_STATE_GENERIC_READ, nil, d3d12.IResource_UUID, cast(^rawptr)&upload_buffer)            
        assert(windows.SUCCEEDED(hr))
    
        mapped : rawptr
        range : d3d12.RANGE = { 0, uint(upload_size) }
        hr = upload_buffer->Map(0, &range, &mapped)
        assert(windows.SUCCEEDED(hr))
        for y : i32 = 0; y < height; y += 1 {
            src := mem.ptr_offset(pixels, y * width * 4)
            dst := rawptr( uintptr(mapped) + uintptr(y) * uintptr(upload_pitch))
            mem.copy(dst, src, int(width) * 4)
        }
        upload_buffer->Unmap(0, &range);
    
        src_location : d3d12.TEXTURE_COPY_LOCATION
        src_location.pResource = upload_buffer
        src_location.Type = d3d12.TEXTURE_COPY_TYPE.PLACED_FOOTPRINT
        src_location.PlacedFootprint.Footprint.Format = dxgi.FORMAT.R8G8B8A8_UNORM
        src_location.PlacedFootprint.Footprint.Width = u32(width)
        src_location.PlacedFootprint.Footprint.Height = u32(height)
        src_location.PlacedFootprint.Footprint.Depth = 1
        src_location.PlacedFootprint.Footprint.RowPitch = upload_pitch

        dst_location : d3d12.TEXTURE_COPY_LOCATION
        dst_location.pResource = texture;
        dst_location.Type = d3d12.TEXTURE_COPY_TYPE.SUBRESOURCE_INDEX
        dst_location.SubresourceIndex = 0

        barrier : d3d12.RESOURCE_BARRIER
        barrier.Type = d3d12.RESOURCE_BARRIER_TYPE.TRANSITION
        barrier.Flags = nil
        barrier.Transition.pResource   = texture
        barrier.Transition.Subresource = d3d12.RESOURCE_BARRIER_ALL_SUBRESOURCES
        barrier.Transition.StateBefore = { d3d12.RESOURCE_STATE.COPY_DEST }
        barrier.Transition.StateAfter  = { d3d12.RESOURCE_STATE.PIXEL_SHADER_RESOURCE }

        fence : ^d3d12.IFence
        hr = bd.d3d12_device->CreateFence(0, nil, d3d12.IFence_UUID, cast(^rawptr)&fence)
        assert(windows.SUCCEEDED(hr))

        event := windows.CreateEventW(nil, false, false, nil)
        assert(event != nil)
    
        queue_desc : d3d12.COMMAND_QUEUE_DESC
        queue_desc.Type     = d3d12.COMMAND_LIST_TYPE.DIRECT
        queue_desc.Flags    = nil
        queue_desc.NodeMask = 1

        cmd_queue : ^d3d12.ICommandQueue
        hr = bd.d3d12_device->CreateCommandQueue(&queue_desc, d3d12.ICommandQueue_UUID, cast(^rawptr)&cmd_queue)
        assert(windows.SUCCEEDED(hr))

        cmd_alloc : ^d3d12.ICommandAllocator
        hr = bd.d3d12_device->CreateCommandAllocator(d3d12.COMMAND_LIST_TYPE.DIRECT, d3d12.ICommandAllocator_UUID, cast(^rawptr)&cmd_alloc)
        assert(windows.SUCCEEDED(hr))

        cmd_list : ^d3d12.IGraphicsCommandList
        hr = bd.d3d12_device->CreateCommandList(0, d3d12.COMMAND_LIST_TYPE.DIRECT, cmd_alloc, nil, d3d12.IGraphicsCommandList1_UUID, cast(^rawptr)&cmd_list)
        assert(windows.SUCCEEDED(hr))

        cmd_list->CopyTextureRegion(&dst_location, 0, 0, 0, &src_location, nil)
        cmd_list->ResourceBarrier(1, &barrier)

        hr = cmd_list->Close()
        assert(windows.SUCCEEDED(hr))

        cmd_queue->ExecuteCommandLists(1, cast(^^d3d12.ICommandList)&cmd_list)
        hr = cmd_queue->Signal(fence, 1)
        assert(windows.SUCCEEDED(hr))

        fence->SetEventOnCompletion(1, event)
        windows.WaitForSingleObject(event, windows.INFINITE)

        cmd_list->Release()
        cmd_alloc->Release()
        cmd_queue->Release()
        windows.CloseHandle(event)
        fence->Release()
        upload_buffer->Release()
    
        // Create texture view
        srv_desc : d3d12.SHADER_RESOURCE_VIEW_DESC
        srv_desc.Format = dxgi.FORMAT.R8G8B8A8_UNORM
        srv_desc.ViewDimension = d3d12.SRV_DIMENSION.TEXTURE2D
        srv_desc.Texture2D.MipLevels = u32(desc.MipLevels)
        srv_desc.Texture2D.MostDetailedMip = 0
        srv_desc.Shader4ComponentMapping = default_shader_4_component_mapping()
        bd.d3d12_device->CreateShaderResourceView(texture, &srv_desc, bd.h_font_srv_cpu_desc_handle)
        if bd.font_texture_resource != nil {
            bd.font_texture_resource->Release()
            bd.font_texture_resource = nil
        } 
        bd.font_texture_resource = texture
    }
    // Can't pack descriptor handle into TexID, 32-bit not supported yet.
    #assert(size_of(imgui.Texture_ID) >= size_of(bd.h_font_srv_gpu_desc_handle.ptr))
    imgui.ImFontAtlas_SetTexID(io.fonts, cast(imgui.Texture_ID)(uintptr(bd.h_font_srv_gpu_desc_handle.ptr)))
}

create_device_object :: proc() -> bool {
    bd := get_backend_data()
    if bd == nil || bd.d3d12_device == nil {
        return false
    }

    if bd.pipeline_state != nil {
        invalidate_device_objects()
    }

    // Create the root signature
    {
        desc_range : d3d12.DESCRIPTOR_RANGE
        desc_range.RangeType = d3d12.DESCRIPTOR_RANGE_TYPE.SRV
        desc_range.NumDescriptors = 1
        desc_range.BaseShaderRegister = 0
        desc_range.RegisterSpace = 0
        desc_range.OffsetInDescriptorsFromTableStart = 0

        param : [2]d3d12.ROOT_PARAMETER

        param[0].ParameterType = d3d12.ROOT_PARAMETER_TYPE._32BIT_CONSTANTS
        param[0].Constants.ShaderRegister = 0
        param[0].Constants.RegisterSpace = 0
        param[0].Constants.Num32BitValues = 16
        param[0].ShaderVisibility = d3d12.SHADER_VISIBILITY.VERTEX

        param[1].ParameterType = d3d12.ROOT_PARAMETER_TYPE.DESCRIPTOR_TABLE
        param[1].DescriptorTable.NumDescriptorRanges = 1
        param[1].DescriptorTable.pDescriptorRanges = &desc_range
        param[1].ShaderVisibility = d3d12.SHADER_VISIBILITY.PIXEL

        // Bilinear sampling is required by default. Set 'io.Fonts->Flags |= ImFontAtlasFlags_NoBakedLines' or 'style.AntiAliasedLinesUseTex = false' to allow point/nearest sampling.
        static_sampler : d3d12.STATIC_SAMPLER_DESC
        static_sampler.Filter = d3d12.FILTER.MIN_MAG_MIP_LINEAR
        static_sampler.AddressU = d3d12.TEXTURE_ADDRESS_MODE.WRAP
        static_sampler.AddressV = d3d12.TEXTURE_ADDRESS_MODE.WRAP
        static_sampler.AddressW = d3d12.TEXTURE_ADDRESS_MODE.WRAP
        static_sampler.MipLODBias = 0.0
        static_sampler.MaxAnisotropy = 0
        static_sampler.ComparisonFunc = d3d12.COMPARISON_FUNC.ALWAYS
        static_sampler.BorderColor = d3d12.STATIC_BORDER_COLOR.TRANSPARENT_BLACK
        static_sampler.MinLOD = 0.0
        static_sampler.MaxLOD = 0.0
        static_sampler.ShaderRegister = 0
        static_sampler.RegisterSpace = 0
        static_sampler.ShaderVisibility = d3d12.SHADER_VISIBILITY.PIXEL

        desc : d3d12.ROOT_SIGNATURE_DESC
        desc.NumParameters = len(param)
        desc.pParameters = raw_data(param[:])
        desc.NumStaticSamplers = 1
        desc.pStaticSamplers = &static_sampler
        desc.Flags = { 
            d3d12.ROOT_SIGNATURE_FLAG.ALLOW_INPUT_ASSEMBLER_INPUT_LAYOUT, 
            d3d12.ROOT_SIGNATURE_FLAG.DENY_HULL_SHADER_ROOT_ACCESS,
            d3d12.ROOT_SIGNATURE_FLAG.DENY_DOMAIN_SHADER_ROOT_ACCESS,
            d3d12.ROOT_SIGNATURE_FLAG.DENY_GEOMETRY_SHADER_ROOT_ACCESS,
        }

        d3d12_dll, _ := dynlib.load_library("d3d12.dll")
        assert(d3d12_dll != nil, "Could not load d3d12.dll")
        if d3d12_dll == nil {
            return false
        }

        serialize_root_signature_fn := cast(type_of(d3d12.SerializeRootSignature))dynlib.symbol_address(d3d12_dll, "D3D12SerializeRootSignature") or_return

        blob : ^d3d12.IBlob
        if serialize_root_signature_fn(&desc, d3d12.ROOT_SIGNATURE_VERSION._1, &blob, nil) != windows.S_OK {
            return false
        }

        bd.d3d12_device->CreateRootSignature(0, blob->GetBufferPointer(), blob->GetBufferSize(), d3d12.IRootSignature_UUID, cast(^rawptr)&bd.root_signature)
        blob->Release();
    }

    pso_desc : d3d12.GRAPHICS_PIPELINE_STATE_DESC
    pso_desc.NodeMask = 1
    pso_desc.PrimitiveTopologyType = d3d12.PRIMITIVE_TOPOLOGY_TYPE.TRIANGLE
    pso_desc.pRootSignature = bd.root_signature
    pso_desc.SampleMask = ~u32(0)
    pso_desc.NumRenderTargets = 1
    pso_desc.RTVFormats[0] = bd.rtv_format
    pso_desc.SampleDesc.Count = 1
    pso_desc.Flags = nil

    vertex_shader_blob, pixel_shader_blob : ^d3d12.IBlob

    // Create the vertex shader
    {
        vertex_shader ::
            "cbuffer vertexBuffer : register(b0)\n" +
            "{\n" +
            "  float4x4 ProjectionMatrix;\n" +
            "};\n" +
            "struct VS_INPUT\n" +
            "{\n" +
            "  float2 pos : POSITION;\n" +
            "  float4 col : COLOR0;\n" +
            "  float2 uv  : TEXCOORD0;\n" +
            "};\n" +
            "\n" +
            "struct PS_INPUT\n" +
            "{\n" +
            "  float4 pos : SV_POSITION;\n" +
            "  float4 col : COLOR0;\n" +
            "  float2 uv  : TEXCOORD0;\n" +
            "};\n" +
            "\n" +
            "PS_INPUT main(VS_INPUT input)\n" +
            "{\n" +
            "  PS_INPUT output;\n" +
            "  output.pos = mul( ProjectionMatrix, float4(input.pos.xy, 0.f, 1.f));\n" +
            "  output.col = input.col;\n" +
            "  output.uv  = input.uv;\n" +
            "  return output;\n" +
            "}"

        if windows.FAILED(d3d_compiler.Compile( raw_data(string(vertex_shader)), len(vertex_shader), nil, nil, nil, "main", "vs_5_0", 0, 0, &vertex_shader_blob, nil)) {
            return false
        }
        pso_desc.VS = { vertex_shader_blob->GetBufferPointer(), vertex_shader_blob->GetBufferSize() }

        // Create the input layout
        @(static) local_layout : []d3d12.INPUT_ELEMENT_DESC =
        {
            { "POSITION", 0, dxgi.FORMAT.R32G32_FLOAT,   0, u32(offset_of(imgui.Draw_Vert, pos)), d3d12.INPUT_CLASSIFICATION.PER_VERTEX_DATA, 0 },
            { "TEXCOORD", 0, dxgi.FORMAT.R32G32_FLOAT,   0, u32(offset_of(imgui.Draw_Vert, uv)),  d3d12.INPUT_CLASSIFICATION.PER_VERTEX_DATA, 0 },
            { "COLOR",    0, dxgi.FORMAT.R8G8B8A8_UNORM, 0, u32(offset_of(imgui.Draw_Vert, col)), d3d12.INPUT_CLASSIFICATION.PER_VERTEX_DATA, 0 },
        };
        pso_desc.InputLayout = { raw_data(local_layout[:]), 3 };
    }

    // Create the pixel shader
    {
        pixel_shader ::
            "struct PS_INPUT\n" +
            "{\n" +
            "  float4 pos : SV_POSITION;\n" +
            "  float4 col : COLOR0;\n" +
            "  float2 uv  : TEXCOORD0;\n" +
            "};\n" +
            "SamplerState sampler0 : register(s0);\n" +
            "Texture2D texture0 : register(t0);\n" +
            "\n" +
            "float4 main(PS_INPUT input) : SV_Target\n" +
            "{\n" +
            "  float4 out_col = input.col * texture0.Sample(sampler0, input.uv);\n" +
            "  return out_col;\n" +
            "}"

        if windows.FAILED(d3d_compiler.Compile(raw_data(string(pixel_shader)), len(pixel_shader), nil, nil, nil, "main", "ps_5_0", 0, 0, &pixel_shader_blob, nil)) {
            vertex_shader_blob->Release()
            return false
        }
        pso_desc.PS = { pixel_shader_blob->GetBufferPointer(), pixel_shader_blob->GetBufferSize() };
    }

    // Create the blending setup
    {
        desc := &pso_desc.BlendState
        desc.AlphaToCoverageEnable = false
        desc.RenderTarget[0].BlendEnable = true
        desc.RenderTarget[0].SrcBlend = d3d12.BLEND.SRC_ALPHA
        desc.RenderTarget[0].DestBlend = d3d12.BLEND.INV_SRC_ALPHA
        desc.RenderTarget[0].BlendOp = d3d12.BLEND_OP.ADD
        desc.RenderTarget[0].SrcBlendAlpha = d3d12.BLEND.ONE
        desc.RenderTarget[0].DestBlendAlpha = d3d12.BLEND.INV_SRC_ALPHA
        desc.RenderTarget[0].BlendOpAlpha = d3d12.BLEND_OP.ADD
        desc.RenderTarget[0].RenderTargetWriteMask = u8(d3d12.COLOR_WRITE_ENABLE_ALL)
    }

    // Create the rasterizer state
    {
        desc := &pso_desc.RasterizerState
        desc.FillMode = d3d12.FILL_MODE.SOLID
        desc.CullMode = d3d12.CULL_MODE.NONE
        desc.FrontCounterClockwise = false
        desc.DepthBias = d3d12.DEFAULT_DEPTH_BIAS
        desc.DepthBiasClamp = d3d12.DEFAULT_DEPTH_BIAS_CLAMP
        desc.SlopeScaledDepthBias = d3d12.DEFAULT_SLOPE_SCALED_DEPTH_BIAS
        desc.DepthClipEnable = true
        desc.MultisampleEnable = false
        desc.AntialiasedLineEnable = false
        desc.ForcedSampleCount = 0
        desc.ConservativeRaster = d3d12.CONSERVATIVE_RASTERIZATION_MODE.OFF
    }

    // Create depth-stencil State
    {
        desc := &pso_desc.DepthStencilState
        desc.DepthEnable = false
        desc.DepthWriteMask = d3d12.DEPTH_WRITE_MASK.ALL
        desc.DepthFunc = d3d12.COMPARISON_FUNC.ALWAYS
        desc.StencilEnable = false
        desc.FrontFace.StencilFailOp = d3d12.STENCIL_OP.KEEP
        desc.FrontFace.StencilDepthFailOp = d3d12.STENCIL_OP.KEEP
        desc.FrontFace.StencilPassOp = d3d12.STENCIL_OP.KEEP
        desc.FrontFace.StencilFunc = d3d12.COMPARISON_FUNC.ALWAYS
        desc.BackFace = desc.FrontFace
    }

    result_pipeline_state := bd.d3d12_device->CreateGraphicsPipelineState(&pso_desc, d3d12.IPipelineState_UUID, cast(^rawptr)&bd.pipeline_state)
    vertex_shader_blob->Release()
    pixel_shader_blob->Release()
    if result_pipeline_state != windows.S_OK {
        return false
    }

    create_fonts_texture()

    return true
}

invalidate_device_objects ::proc() {
    bd := get_backend_data()
    if bd == nil || bd.d3d12_device == nil {
        return
    }

    io := imgui.get_io()
    if bd.root_signature != nil {
        bd.root_signature->Release()
        bd.root_signature = nil
    }
    if bd.pipeline_state != nil {
        bd.pipeline_state->Release()
        bd.pipeline_state = nil
    }
    if bd.font_texture_resource != nil {
        bd.font_texture_resource->Release()
        bd.font_texture_resource = nil
    }
    imgui.ImFontAtlas_SetTexID(io.fonts, nil)

    for &fr in bd.frame_resources {
        if fr.index_buffer != nil {
            fr.index_buffer->Release()
            fr.index_buffer = nil
        }
        if fr.vertex_buffer != nil {
            fr.vertex_buffer->Release()
            fr.vertex_buffer = nil
        }
    }
}

init ::proc(device: ^d3d12.IDevice, num_frames_in_flight: int, rtv_format : dxgi.FORMAT, cbv_srv_heap: ^d3d12.IDescriptorHeap, 
    font_srv_cpu_desc_handle: d3d12.CPU_DESCRIPTOR_HANDLE, font_srv_gpu_desc_handle: d3d12.GPU_DESCRIPTOR_HANDLE ) -> bool {

    io := imgui.get_io()    
    imgui.igDebugCheckVersionAndDataLayout( imgui.get_version(), size_of(imgui.IO), size_of(imgui.Style), 
        size_of(imgui.Vec2), size_of(imgui.Vec4), size_of(imgui.Draw_Vert), size_of(imgui.Draw_Idx))
    assert(io.backend_renderer_user_data == nil, "Already initialized a renderer backend!")

    // Setup backend capabilities flags
    bd := new(DX12_Data)
    io.backend_language_user_data = rawptr(bd)
    io.backend_renderer_name = "imgui_impl_dx12"
    io.backend_flags |= imgui.Backend_Flags.RendererHasVtxOffset  // We can honor the ImDrawCmd::VtxOffset field, allowing for large meshes.

    bd.d3d12_device = device
    bd.rtv_format = rtv_format
    bd.h_font_srv_cpu_desc_handle = font_srv_cpu_desc_handle
    bd.h_font_srv_gpu_desc_handle = font_srv_gpu_desc_handle
    bd.frame_resources = make([dynamic]DX12_RenderBuffers, num_frames_in_flight)[:]
    bd.num_frames_in_flight = u32(num_frames_in_flight)
    bd.d3d_src_desc_heap = cbv_srv_heap
    bd.frame_index = ~u32(0)

    // Create buffers with a default size (they will later be grown as needed)
    for &fr in bd.frame_resources {
        fr.index_buffer = nil
        fr.vertex_buffer = nil
        fr.index_buffer_size = 10000
        fr.vertex_buffer_size = 5000
    }

    return true
}

shutdown ::proc() {
    bd := get_backend_data()
    assert(bd != nil, "No renderer backend to shutdown, or already shutdown?")
    io := imgui.get_io()

    // Clean up windows and device objects
    invalidate_device_objects()
    delete(bd.frame_resources)
    io.backend_renderer_name = nil
    io.backend_renderer_user_data = nil
    io.backend_flags &~= imgui.Backend_Flags.RendererHasVtxOffset
    free(bd)
}