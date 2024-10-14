package predefined;

////////////////////////////
// Predefined Types
@output_copy ImID :: distinct u32;
@output_copy Draw_Idx :: distinct u16; 
@output_copy Wchar :: distinct u16; 
@output_copy Wchar16 :: distinct u16; 
@output_copy Wchar32 :: distinct u32; 
@output_copy Texture_ID :: distinct rawptr; 
@output_copy File_Handle :: distinct uintptr; 
@output_copy Selection_User_Data :: distinct i64;
@output_copy Key_Chord :: distinct i32;

@output_copy Alloc_Func :: #type proc "c" (size: i64, user_data: rawptr) -> rawptr;
@output_copy Free_Func :: #type proc "c" (ptr: rawptr, user_data: rawptr);
@output_copy Mem_Alloc_Func :: #type proc "c" (size: i64, user_data: rawptr) -> rawptr;
@output_copy Mem_Free_Func :: #type proc "c" (ptr: rawptr, user_data: rawptr);
@output_copy Items_Getter_Proc :: #type proc "c" (data: rawptr, idx: i32, out_text: ^cstring) -> bool;
@output_copy Value_Getter_Proc :: #type proc "c" (data: rawptr, idx: i32) -> f32;
@output_copy Draw_Callback :: #type proc "c" (parent_list: ^Draw_List, cmd: ^Draw_Cmd);
@output_copy Input_Text_Callback :: #type proc "c" (data: ^Input_Text_Callback_Data) -> int;
@output_copy Size_Callback :: #type proc "c" (data: ^Size_Callback_Data);
@output_copy Draw_Callback_ResetRenderState :: #type proc "c" (parent_list: ^Draw_List, cmd: ^Draw_Cmd);

// ///////////////////////////
// // Predefined structs

@output_copy
Draw_List_Shared_Data :: struct {};
@output_copy
Context :: struct {};
@output_copy
Font_Builder_Io :: struct {};

@output_copy
Im_Vector :: struct(T : typeid) {
    size:     i32, 
    capacity: i32,
    data:     ^T,
}

@(struct_overwrite="ImGuiStyleMod") 
Style_Mod :: struct {
    var_idx: Style_Var,
    using _: struct #raw_union {
        backup_int: [2]i32,
        backup_float: [2]f32,
    },
}

@(struct_overwrite="ImGuiSettingsHandler") 
Settings_Handler :: struct {
    type_name:    cstring,
    type_hash:    ImID,
    read_open_fn: proc(ctx: ^Context, handler: ^Settings_Handler, name: cstring) -> rawptr,
    read_line_fn: proc(ctx: ^Context, handler: ^Settings_Handler, entry: rawptr, line: cstring),
    write_all_fn: proc(ctx: ^Context, handler: ^Settings_Handler, out_buf: ^Text_Buffer),
    user_data:    rawptr,
}

@(struct_overwrite="ImGuiStoragePair") 
Storage_Pair :: struct {
    key: ImID,
    using _: struct #raw_union { 
        val_i: i32, 
        val_f: f32, 
        val_p: rawptr,
    },
}

@(struct_overwrite="ImGuiStorage")
Storage :: struct {
    data: Im_Vector( Storage_Pair ),
};

@(struct_overwrite="ImGuiSelectionBasicStorage")
Selection_Basic_Storage :: struct {
    size : i32,
    preserve_order: bool,
    user_data: rawptr,
    adapter_index_to_storage_id: proc(self: ^Selection_Basic_Storage, idx: i32 ) -> ImID,
    _selection_order: i32,
    _storage: Storage
}

@(struct_overwrite="ImGuiSelectionExternalStorage")
Selection_External_Storage :: struct {
    user_data: rawptr,
    adapter_set_item_selected: proc(self: ^Selection_External_Storage, idx: i32, selected: bool)
}

@(struct_overwrite="ImGuiPlatformIO")
Platform_Io :: struct {
   platform_get_clipboard_text_fn: proc(ctx: ^Context),
   platform_set_clipboard_text_fn: proc(ctx: ^Context, text: cstring),
   platform_clipboard_user_data: proc(),
   platform_open_in_shell_fn: proc(ctx: ^Context, path: cstring),
   platform_open_in_shell_user_data: proc(),
   platform_set_ime_data_fn: proc(ctx: ^Context, viewport: ^Viewport, data : ^Platform_Ime_Data),
   platform_ime_user_data: proc(),
   platform_locale_decimal_point: Wchar,
}

///////////////////////////
// Overwriting foreign declerations
@(foreign_overwrite="igSetAllocatorFunctions")
igSetAllocatorFunctions :: proc(alloc_func: Alloc_Func, free_func: Free_Func) ---;
@(foreign_overwrite="igPlotEx")
igPlotEx :: proc(plot_type: Plot_Type, label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, frame_size: Vec2) -> i32 ---;
@(foreign_overwrite="igPlotHistogram_FnFloatPtr")
igPlotHistogram_FnFloatPtr :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2) ---;
@(foreign_overwrite="igPlotLines_FnFloatPtr")
igPlotLines_FnFloatPtr :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2) ---;
@(foreign_overwrite="igListBox_FnBoolPtr")
igListBox_FnBoolPtr :: proc(label: cstring, current_item: ^i32, items_getter: Items_Getter_Proc, data: rawptr, items_count: i32, height_in_items: i32) -> bool ---;
@(foreign_overwrite="igCombo_FnBoolPtr")
igCombo_FnBoolPtr :: proc(label: cstring, current_item: ^i32, items_getter: Items_Getter_Proc, data: rawptr, items_count: i32, popup_max_height_in_items: i32) -> bool ---;
@(foreign_overwrite="igCombo_Str_arr")
igCombo_Str_arr :: proc(label: cstring, current_item: ^i32, items: ^cstring, items_count: i32, popup_max_height_in_items: i32) -> bool ---;


///////////////////////////
// Predefined wrappers
@(wrapper="igInputText")
wrapper_input_text :: #force_inline proc(label: string, buf: []u8, flags := Input_Text_Flags(0), callback : Input_Text_Callback = nil, user_data : rawptr = nil) -> bool {
    l := strings.clone_to_cstring(label, context.temp_allocator);
    return igInputText(l, cstring(&buf[0]), uint(len(buf)), flags, callback, user_data);
}

@(wrapper="igGetWindowPos")
wrapper_get_window_pos :: proc() -> Vec2 {
    res := Vec2{};
    igGetWindowPos(&res);
    return res;
}

@(wrapper="igGetWindowSize")
wrapper_get_window_size :: proc() -> Vec2 {
    res := Vec2{};
    igGetWindowSize(&res);
    return res;
}

@(wrapper="igSetAllocatorFunctions")
wrapper_set_allocator_functions :: #force_inline proc(alloc_func: Alloc_Func, free_func: Free_Func) {
    igSetAllocatorFunctions(alloc_func, free_func);
}

@(wrapper="igPlotEx")
wrapper_plot_ex :: proc(plot_type: Plot_Type, 
                        label: string, 
                        values_getter: Value_Getter_Proc, 
                        data: rawptr, 
                        values_count: i32, 
                        values_offset: i32, 
                        overlay_text: string, 
                        scale_min: f32, 
                        scale_max: f32, 
                        frame_size: Vec2) -> i32 {
    l := strings.clone_to_cstring(label, context.temp_allocator);
    overlay := strings.clone_to_cstring(overlay_text, context.temp_allocator);
    return igPlotEx(plot_type, l, values_getter, data, values_count, values_offset, overlay, scale_min, scale_max, frame_size);
}

@(wrapper="igPlotHistogram_FnFloatPtr")
wrapper_plot_histogram_fn_float_ptr :: proc(label: string,
                                      values_getter: Value_Getter_Proc,
                                      data: rawptr,
                                      values_count: i32,
                                      values_offset: i32,
                                      overlay_text: string,
                                      scale_min: f32,
                                      scale_max: f32,
                                      graph_size: Vec2) {
    l := strings.clone_to_cstring(label, context.temp_allocator);
    overlay := strings.clone_to_cstring(overlay_text, context.temp_allocator);
    igPlotHistogram_FnFloatPtr(l, values_getter, data, values_count, values_offset, overlay, scale_min, scale_max, graph_size);
}

@(wrapper="igPlotLines_FnFloatPtr")
wrapper_plot_lines_fn_float_ptr :: proc(label: string, 
                                  values_getter: Value_Getter_Proc, 
                                  data: rawptr, 
                                  values_count: i32, 
                                  values_offset: i32, 
                                  overlay_text: string, 
                                  scale_min: f32, 
                                  scale_max: f32, 
                                  graph_size: Vec2) {
    l := strings.clone_to_cstring(label, context.temp_allocator);
    overlay := strings.clone_to_cstring(overlay_text, context.temp_allocator);
    igPlotLines_FnFloatPtr(l, values_getter, data, values_count, values_offset, overlay, scale_min, scale_max, graph_size);
}

@(wrapper="igListBox_FnBoolPtr")
wrapper_list_box_fn_bool_ptr :: proc(label: string, current_item: ^i32, items_getter: Items_Getter_Proc, data: rawptr, items_count: i32, height_in_items := i32(0))-> bool {
    l := strings.clone_to_cstring(label, context.temp_allocator);
    return igListBox_FnBoolPtr(l, current_item, items_getter, data, items_count, height_in_items);
}

@(wrapper="igCombo_FnBoolPtr")
wrapper_combo_fn_bool_ptr :: proc(label: string, current_item: ^i32, items_getter: Items_Getter_Proc, data: rawptr, items_count: i32, popup_max_height_in_items := i32(0)) -> bool {
    l := strings.clone_to_cstring(label, context.temp_allocator);
    return igCombo_FnBoolPtr(l, current_item, items_getter, data, items_count, popup_max_height_in_items);
}

@(wrapper="igCombo_Str_arr")
wrapper_combo_str_arr :: proc(label: string, current_item: ^i32, items: []string, popup_max_height_in_items := i32(0)) -> bool {
    l := strings.clone_to_cstring(label, context.temp_allocator);

    data := make([]cstring, len(items), context.temp_allocator);
    for item, idx in items {
        data[idx] = strings.clone_to_cstring(item, context.temp_allocator);
    }

    return igCombo_Str_arr(l, current_item, &data[0], i32(len(items)), popup_max_height_in_items);
}

@(wrapper="igTextWrapped") 
wrapper_text_wrapped :: proc(fmt_: string, args: ..any) {
    fmt_str := fmt.tprintf("{}\x00", fmt_);
    str := transmute([]byte)fmt.tprintf(fmt_str, ..args);
    igTextWrapped(cstring(&str[0]), nil);
}

@(wrapper="igTextColored") 
wrapper_text_colored :: proc(col: Vec4, fmt_: string, args: ..any) {
    fmt_str := fmt.tprintf("{}\x00", fmt_);
    str := transmute([]byte)fmt.tprintf(fmt_str, ..args);
    igTextColored(col, cstring(&str[0]), nil);
}

@(wrapper="igTextDisabled") 
wrapper_text_disabled :: proc(fmt_: string, args: ..any) {
    fmt_str := fmt.tprintf("{}\x00", fmt_);
    str := transmute([]byte)fmt.tprintf(fmt_str, ..args);
    igTextDisabled(cstring(&str[0]), nil);
}

@(wrapper="igTextUnformatted") 
wrapper_unformatted_text :: proc(text: string) {
    t := strings.clone_to_cstring(text, context.temp_allocator);
    ptr := transmute(^u8)t;
    end_ptr := mem.ptr_offset(ptr, len(t));
    igTextUnformatted(cstring(ptr), cstring(end_ptr));
}

@(wrapper="igText") 
wrapper_text :: proc(fmt_: string, args: ..any) {
    fmt_str := fmt.tprintf("{}\x00", fmt_);
    str := transmute([]byte)fmt.tprintf(fmt_str, ..args);
    igTextUnformatted(cstring(&str[0]), cstring(&str[len(str)-1]));
}
