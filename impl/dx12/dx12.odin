package imgui_impl_dx12


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

safe_release :: #force_inline proc ($T : typeid) {
    if res != nil {
        res->Release()
    }
    res = nil
}

render_draw_data :: proc(draw_data: ^imgui.Draw_Data, ctx : ^d3d12.IGraphicsCommandList) {
    // Avoid rendering when minimized
    if draw_data->display_size.x <= 0.0 || draw_data->display_size.y <= 0.0 {
        return
    }

    // FIXME: I'm assuming that this only gets called once per frame!
    // If not, we can't just re-allocate the IB or VB, we'll have to do a proper allocator.
    bd := get_backend_data();
    bd.frame_index = bd.frame_index + 1;
    fr := &bd.frame_resources[bd.frame_index % bd.num_frames_in_flight];

    // Create and grow vertex/index buffers if needed
    if fr.vertex_buffer == nil || fr->vertex_buffer_size < draw_data->total_vtx_count {
        safe_release(fr.vertex_buffer)
        fr.vertex_buffer_size = draw_data->total_vtx_count + 5000
        props : d3d12.HEAP_PROPERTIES
        props.Type = d3d12.HEAP_TYPE.UPLOAD
        props.CPUPageProperty = d3d12.CPU_PAGE_PROPERTY.UNKNOWN
        props.MemoryPoolPreference = d31d2.MEMORY_POOL.UNKNOWN
        desc : d3d12.RESOURCE_DESC
        desc.Dimension = d31d2.RESOURCE_DIMENSION.BUFFER
        desc.Width = fr->vertex_buffer_size * size_of(imgui.Draw_Vert);
        desc.Height = 1
        desc.DepthOrArraySize = 1
        desc.MipLevels = 1
        desc.Format = dxgi.FORMAT.UNKNOWN
        desc.SampleDesc.Count = 1
        desc.Layout = d3d12.TEXTURE_LAYOUT.ROW_MAJOR
        desc.Flags = d3d12.RESOURCE_FLAG.NONE
        if bd.d3d12_device->CreateCommittedResource(&props, d31d2.HEAP_FLAG.NONE, &desc, d3d12.RESOURCE_STATE.GENERIC_READ, nil, IID_PPV_ARGS(&fr->VertexBuffer)) < 0)
            return;
    }
    if (fr->IndexBuffer == nullptr || fr->IndexBufferSize < draw_data->TotalIdxCount)
    {
        SafeRelease(fr->IndexBuffer);
        fr->IndexBufferSize = draw_data->TotalIdxCount + 10000;
        D3D12_HEAP_PROPERTIES props;
        memset(&props, 0, sizeof(D3D12_HEAP_PROPERTIES));
        props.Type = D3D12_HEAP_TYPE_UPLOAD;
        props.CPUPageProperty = D3D12_CPU_PAGE_PROPERTY_UNKNOWN;
        props.MemoryPoolPreference = D3D12_MEMORY_POOL_UNKNOWN;
        D3D12_RESOURCE_DESC desc;
        memset(&desc, 0, sizeof(D3D12_RESOURCE_DESC));
        desc.Dimension = D3D12_RESOURCE_DIMENSION_BUFFER;
        desc.Width = fr->IndexBufferSize * sizeof(ImDrawIdx);
        desc.Height = 1;
        desc.DepthOrArraySize = 1;
        desc.MipLevels = 1;
        desc.Format = DXGI_FORMAT_UNKNOWN;
        desc.SampleDesc.Count = 1;
        desc.Layout = D3D12_TEXTURE_LAYOUT_ROW_MAJOR;
        desc.Flags = D3D12_RESOURCE_FLAG_NONE;
        if (bd->pd3dDevice->CreateCommittedResource(&props, D3D12_HEAP_FLAG_NONE, &desc, D3D12_RESOURCE_STATE_GENERIC_READ, nullptr, IID_PPV_ARGS(&fr->IndexBuffer)) < 0)
            return;
    }

    // Upload vertex/index data into a single contiguous GPU buffer
    void* vtx_resource, *idx_resource;
    D3D12_RANGE range;
    memset(&range, 0, sizeof(D3D12_RANGE));
    if (fr->VertexBuffer->Map(0, &range, &vtx_resource) != S_OK)
        return;
    if (fr->IndexBuffer->Map(0, &range, &idx_resource) != S_OK)
        return;
    ImDrawVert* vtx_dst = (ImDrawVert*)vtx_resource;
    ImDrawIdx* idx_dst = (ImDrawIdx*)idx_resource;
    for (int n = 0; n < draw_data->CmdListsCount; n++)
    {
        const ImDrawList* cmd_list = draw_data->CmdLists[n];
        memcpy(vtx_dst, cmd_list->VtxBuffer.Data, cmd_list->VtxBuffer.Size * sizeof(ImDrawVert));
        memcpy(idx_dst, cmd_list->IdxBuffer.Data, cmd_list->IdxBuffer.Size * sizeof(ImDrawIdx));
        vtx_dst += cmd_list->VtxBuffer.Size;
        idx_dst += cmd_list->IdxBuffer.Size;
    }
    fr->VertexBuffer->Unmap(0, &range);
    fr->IndexBuffer->Unmap(0, &range);

    // Setup desired DX state
    ImGui_ImplDX12_SetupRenderState(draw_data, ctx, fr);

    // Render command lists
    // (Because we merged all buffers into a single one, we maintain our own offset into them)
    int global_vtx_offset = 0;
    int global_idx_offset = 0;
    ImVec2 clip_off = draw_data->DisplayPos;
    for (int n = 0; n < draw_data->CmdListsCount; n++)
    {
        const ImDrawList* cmd_list = draw_data->CmdLists[n];
        for (int cmd_i = 0; cmd_i < cmd_list->CmdBuffer.Size; cmd_i++)
        {
            const ImDrawCmd* pcmd = &cmd_list->CmdBuffer[cmd_i];
            if (pcmd->UserCallback != nullptr)
            {
                // User callback, registered via ImDrawList::AddCallback()
                // (ImDrawCallback_ResetRenderState is a special callback value used by the user to request the renderer to reset render state.)
                if (pcmd->UserCallback == ImDrawCallback_ResetRenderState)
                    ImGui_ImplDX12_SetupRenderState(draw_data, ctx, fr);
                else
                    pcmd->UserCallback(cmd_list, pcmd);
            }
            else
            {
                // Project scissor/clipping rectangles into framebuffer space
                ImVec2 clip_min(pcmd->ClipRect.x - clip_off.x, pcmd->ClipRect.y - clip_off.y);
                ImVec2 clip_max(pcmd->ClipRect.z - clip_off.x, pcmd->ClipRect.w - clip_off.y);
                if (clip_max.x <= clip_min.x || clip_max.y <= clip_min.y)
                    continue;

                // Apply Scissor/clipping rectangle, Bind texture, Draw
                const D3D12_RECT r = { (LONG)clip_min.x, (LONG)clip_min.y, (LONG)clip_max.x, (LONG)clip_max.y };
                D3D12_GPU_DESCRIPTOR_HANDLE texture_handle = {};
                texture_handle.ptr = (UINT64)pcmd->GetTexID();
                ctx->SetGraphicsRootDescriptorTable(1, texture_handle);
                ctx->RSSetScissorRects(1, &r);
                ctx->DrawIndexedInstanced(pcmd->ElemCount, 1, pcmd->IdxOffset + global_idx_offset, pcmd->VtxOffset + global_vtx_offset, 0);
            }
        }
        global_idx_offset += cmd_list->IdxBuffer.Size;
        global_vtx_offset += cmd_list->VtxBuffer.Size;
    }
}
