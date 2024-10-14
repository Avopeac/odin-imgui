package imgui_impl_dx12

import "core:mem"
import "core:sys/windows"
import "vendor:directx/d3d12"
import "vendor:directx/dxgi"

import imgui "../.."

DX12_Data :: struct {
	d3d12_device:               ^d3d12.IDevice,
	root_signature:             ^d3d12.IRootSignature,
	pipeline_state:             ^d3d12.IPipelineState,
	rtv_format:                 dxgi.FORMAT,
	font_texture_resource:      ^d3d12.IResource,
	h_font_srv_cpu_desc_handle: d3d12.CPU_DESCRIPTOR_HANDLE,
	h_font_srv_gpu_desc_handle: d3d12.CPU_DESCRIPTOR_HANDLE,
	d3d_src_desc_heap:          ^d3d12.IDescriptorHeap,
	num_frames_in_flight:       u32,
	frame_resources:            ^DX12_RenderBuffers,
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
		return cast(^DX12_Data)(imgui.get_io().backend_platform_user_data)
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
	stride: u32 = cast(u32)size_of(imgui.Draw_Vert)
	offset: u32 = 0
	vbv: d3d12.VERTEX_BUFFER_VIEW
	vbv.BufferLocation = fr.vertex_buffer->GetGPUVirtualAddress() + cast(u64)offset
	vbv.SizeInBytes = cast(u32)fr.vertex_buffer_size * stride
	vbv.StrideInBytes = stride
	ctx->IASetVertexBuffers(0, 1, &vbv)
	ibv: d3d12.INDEX_BUFFER_VIEW
	ibv.BufferLocation = fr.index_buffer->GetGPUVirtualAddress()
	ibv.SizeInBytes = cast(u32)fr.index_buffer_size * size_of(imgui.Draw_Idx)
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
    fr := mem.ptr_offset( bd.frame_resources, bd.frame_index % bd.num_frames_in_flight )

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
        desc.Width = cast(u64)fr.vertex_buffer_size * size_of(imgui.Draw_Vert)
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
        desc.Width = cast(u64)fr.index_buffer_size * size_of(imgui.Draw_Idx)
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
        mem.copy(vtx_dst, cmd_list.vtx_buffer.data, cast(int)cmd_list.vtx_buffer.size * size_of(imgui.Draw_Vert))
        mem.copy(idx_dst, cmd_list.idx_buffer.data, cast(int)cmd_list.idx_buffer.size * size_of(imgui.Draw_Idx))
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
        cmds := mem.slice_ptr(cmd_list.cmd_buffer.data, cast(int)cmd_list.cmd_buffer.size)
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
                texture_handle.ptr = cast(u64)(cast(uintptr)imgui.ImDrawCmd_GetTexID(&cmd))
                ctx->SetGraphicsRootDescriptorTable(1, texture_handle)
                ctx->RSSetScissorRects(1, &r)
                ctx->DrawIndexedInstanced(cmd.elem_count, 1, cmd.idx_offset + cast(u32)global_idx_offset, cast(i32)cmd.vtx_offset + cast(i32)global_vtx_offset, 0)
            }
        }
        global_idx_offset += cast(int)cmd_list.idx_buffer.size
        global_vtx_offset += cast(int)cmd_list.vtx_buffer.size
    }
}
