package imgui;

list_clipper_begin :: #force_inline proc(self: ^List_Clipper, items_count: i32, items_height := f32(-1.0)) { ImGuiListClipper_Begin(self, items_count, items_height); }

font_grow_index :: #force_inline proc(self: ^ImFont, new_size: i32) { ImFont_GrowIndex(self, new_size); }

set_next_window_pos       :: #force_inline proc(pos: Vec2, cond := Cond(0), pivot := Vec2(Vec2 {0,0})) { igSetNextWindowPos(pos, cond, pivot); }

is_key_chord_pressed :: proc {
	is_key_chord_pressed_nil,
};
is_key_chord_pressed_nil  :: #force_inline proc(key_chord: Key_Chord) -> bool       { return igIsKeyChordPressed_Nil(key_chord); }

is_item_toggled_selection :: #force_inline proc() -> bool                           { return igIsItemToggledSelection(); }
font_atlas_clear_fonts    :: #force_inline proc(self: ^Font_Atlas)                  { ImFontAtlas_ClearFonts(self); }

show_font_selector :: #force_inline proc(label: string)                                { swr_igShowFontSelector(label); }
set_state_storage  :: #force_inline proc(storage: ^Storage)                            { igSetStateStorage(storage); }
color_set_hsv      :: #force_inline proc(self: ^Color, h: f32, s: f32, v: f32, a := f32(1.0)) { ImColor_SetHSV(self, h, s, v, a); }


get_foreground_draw_list :: proc {
	get_foreground_draw_list_nil,
};
get_foreground_draw_list_nil   :: #force_inline proc() -> ^Draw_List                                                                                                                                                    { return igGetForegroundDrawList_Nil(); }

push_text_wrap_pos             :: #force_inline proc(wrap_local_pos_x := f32(0.0))                                                                                                                                      { igPushTextWrapPos(wrap_local_pos_x); }
drag_int_range2                :: #force_inline proc(label: string, v_current_min: ^i32, v_current_max: ^i32, v_speed := f32(1.0), v_min := i32(0), v_max := i32(0), format := "%d", format_max := "", flags := Slider_Flags(0)) -> bool { return swr_igDragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags); }
table_setup_column             :: #force_inline proc(label: string, flags := Table_Column_Flags(0), init_width_or_weight := f32(0.0), user_id := ImID(0))                                                               { swr_igTableSetupColumn(label, flags, init_width_or_weight, user_id); }
get_tree_node_to_label_spacing :: #force_inline proc() -> f32                                                                                                                                                           { return igGetTreeNodeToLabelSpacing(); }
log_finish                     :: #force_inline proc()                                                                                                                                                                  { igLogFinish(); }
draw_list_path_stroke          :: #force_inline proc(self: ^Draw_List, col: u32, flags := Draw_Flags(0), thickness := f32(1.0))                                                                                         { ImDrawList_PathStroke(self, col, flags, thickness); }


is_rect_visible :: proc {
	is_rect_visible_nil,
	is_rect_visible_vec2,
};
is_rect_visible_nil               :: #force_inline proc(size: Vec2) -> bool                     { return igIsRectVisible_Nil(size); }
is_rect_visible_vec2              :: #force_inline proc(rect_min: Vec2, rect_max: Vec2) -> bool { return igIsRectVisible_Vec2(rect_min, rect_max); }

is_item_edited                    :: #force_inline proc() -> bool                               { return igIsItemEdited(); }
list_clipper_seek_cursor_for_item :: #force_inline proc(self: ^List_Clipper, item_index: i32)   { ImGuiListClipper_SeekCursorForItem(self, item_index); }


is_key_down :: proc {
	is_key_down_nil,
};
is_key_down_nil        :: #force_inline proc(key: Key) -> bool { return igIsKeyDown_Nil(key); }

font_clear_output_data :: #force_inline proc(self: ^ImFont)    { ImFont_ClearOutputData(self); }

is_item_active              :: #force_inline proc() -> bool                      { return igIsItemActive(); }
draw_list_get_clip_rect_min :: #force_inline proc(pOut: ^Vec2, self: ^Draw_List) { ImDrawList_GetClipRectMin(pOut, self); }

get_style_color_vec4                :: #force_inline proc(idx: Col) -> ^Vec4                                                                                                                    { return igGetStyleColorVec4(idx); }
font_atlas_add_font_from_memory_ttf :: #force_inline proc(self: ^Font_Atlas, font_data: rawptr, font_data_size: i32, size_pixels: f32, font_cfg : ^Font_Config = nil, glyph_ranges : ^Wchar = nil) -> ^ImFont { return ImFontAtlas_AddFontFromMemoryTTF(self, font_data, font_data_size, size_pixels, font_cfg, glyph_ranges); }

table_next_row            :: #force_inline proc(row_flags := Table_Row_Flags(0), min_row_height := f32(0.0))                 { igTableNextRow(row_flags, min_row_height); }
is_item_visible           :: #force_inline proc() -> bool                                                                    { return igIsItemVisible(); }

menu_item :: proc {
	menu_item_bool,
	menu_item_bool_ptr,
};
menu_item_bool            :: #force_inline proc(label: string, shortcut := "", selected := bool(false), enabled := bool(true)) -> bool { return swr_igMenuItem_Bool(label, shortcut, selected, enabled); }
menu_item_bool_ptr        :: #force_inline proc(label: string, shortcut: string, p_selected: ^bool, enabled := bool(true)) -> bool { return swr_igMenuItem_BoolPtr(label, shortcut, p_selected, enabled); }


get_color_u32 :: proc {
	get_color_u32_col,
	get_color_u32_vec4,
	get_color_u32_u32,
};
get_color_u32_col         :: #force_inline proc(idx: Col, alpha_mul := f32(1.0)) -> u32                                      { return igGetColorU32_Col(idx, alpha_mul); }
get_color_u32_vec4        :: #force_inline proc(col: Vec4) -> u32                                                            { return igGetColorU32_Vec4(col); }
get_color_u32_u32         :: #force_inline proc(col: u32, alpha_mul := f32(1.0)) -> u32                                      { return igGetColorU32_U32(col, alpha_mul); }

storage_build_sort_by_key :: #force_inline proc(self: ^Storage)                                                              { ImGuiStorage_BuildSortByKey(self); }

io_add_input_character_utf16 :: #force_inline proc(self: ^IO, c: Wchar16) { ImGuiIO_AddInputCharacterUTF16(self, c); }


is_mouse_double_clicked :: proc {
	is_mouse_double_clicked_nil,
};
is_mouse_double_clicked_nil :: #force_inline proc(button: Mouse_Button) -> bool                       { return igIsMouseDoubleClicked_Nil(button); }


get_id :: proc {
	get_id_str,
	get_id_str_str,
	get_id_ptr,
	get_id_int,
};
get_id_str                  :: #force_inline proc(str_id: string) -> ImID                             { return swr_igGetID_Str(str_id); }
get_id_str_str              :: #force_inline proc(str_id_begin: string, str_id_end: string) -> ImID   { return swr_igGetID_StrStr(str_id_begin, str_id_end); }
get_id_ptr                  :: #force_inline proc(ptr_id: rawptr) -> ImID                             { return igGetID_Ptr(ptr_id); }
get_id_int                  :: #force_inline proc(int_id: i32) -> ImID                                { return igGetID_Int(int_id); }

checkbox                    :: #force_inline proc(label: string, v: ^bool) -> bool                    { return swr_igCheckbox(label, v); }
push_item_flag              :: #force_inline proc(option: Item_Flags, enabled: bool)                  { igPushItemFlag(option, enabled); }
payload_is_data_type        :: #force_inline proc(self: ^Payload, type: string) -> bool               { return swr_ImGuiPayload_IsDataType(self, type); }

font_atlas_clear_tex_data :: #force_inline proc(self: ^Font_Atlas) { ImFontAtlas_ClearTexData(self); }

input_text_callback_data_delete_chars :: #force_inline proc(self: ^Input_Text_Callback_Data, pos: i32, bytes_count: i32) { ImGuiInputTextCallbackData_DeleteChars(self, pos, bytes_count); }


get_background_draw_list :: proc {
	get_background_draw_list_nil,
};
get_background_draw_list_nil        :: #force_inline proc() -> ^Draw_List                                                                                                               { return igGetBackgroundDrawList_Nil(); }

set_next_item_storage_id            :: #force_inline proc(storage_id: ImID)                                                                                                             { igSetNextItemStorageID(storage_id); }
get_item_id                         :: #force_inline proc() -> ImID                                                                                                                     { return igGetItemID(); }
debug_check_version_and_data_layout :: #force_inline proc(version_str: string, sz_io: uint, sz_style: uint, sz_vec2: uint, sz_vec4: uint, sz_drawvert: uint, sz_drawidx: uint) -> bool  { return swr_igDebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx); }
debug_start_item_picker             :: #force_inline proc()                                                                                                                             { igDebugStartItemPicker(); }
font_atlas_custom_rect_is_packed    :: #force_inline proc(self: ^Font_Atlas_Custom_Rect) -> bool                                                                                        { return ImFontAtlasCustomRect_IsPacked(self); }

begin_popup_context_window                :: #force_inline proc(str_id := "", popup_flags := Popup_Flags(1)) -> bool      { return swr_igBeginPopupContextWindow(str_id, popup_flags); }
selection_basic_storage_set_item_selected :: #force_inline proc(self: ^Selection_Basic_Storage, id: ImID, selected: bool) { ImGuiSelectionBasicStorage_SetItemSelected(self, id, selected); }

end_tooltip                              :: #force_inline proc()                                     { igEndTooltip(); }
new_line                                 :: #force_inline proc()                                     { igNewLine(); }
draw_list_calc_circle_auto_segment_count :: #force_inline proc(self: ^Draw_List, radius: f32) -> i32 { return ImDrawList__CalcCircleAutoSegmentCount(self, radius); }

list_clipper_include_item_by_index :: #force_inline proc(self: ^List_Clipper, item_index: i32) { ImGuiListClipper_IncludeItemByIndex(self, item_index); }

font_atlas_add_font_from_memory_compressed_ttf :: #force_inline proc(self: ^Font_Atlas, compressed_font_data: rawptr, compressed_font_data_size: i32, size_pixels: f32, font_cfg : ^Font_Config = nil, glyph_ranges : ^Wchar = nil) -> ^ImFont { return ImFontAtlas_AddFontFromMemoryCompressedTTF(self, compressed_font_data, compressed_font_data_size, size_pixels, font_cfg, glyph_ranges); }
font_atlas_get_glyph_ranges_korean             :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar                                                                                                                                { return ImFontAtlas_GetGlyphRangesKorean(self); }

is_item_deactivated       :: #force_inline proc() -> bool                                                                                                      { return igIsItemDeactivated(); }
drag_float4               :: #force_inline proc(label: string, v: [4]f32, v_speed := f32(1.0), v_min := f32(0.0), v_max := f32(0.0), format := "%.3f", flags := Slider_Flags(0)) -> bool { return swr_igDragFloat4(label, v, v_speed, v_min, v_max, format, flags); }
end_tab_bar               :: #force_inline proc()                                                                                                              { igEndTabBar(); }
set_next_window_focus     :: #force_inline proc()                                                                                                              { igSetNextWindowFocus(); }
show_id_stack_tool_window :: #force_inline proc(p_open : ^bool = nil)                                                                                          { igShowIDStackToolWindow(p_open); }
begin_tab_item            :: #force_inline proc(label: string, p_open : ^bool = nil, flags := Tab_Item_Flags(0)) -> bool                                       { return swr_igBeginTabItem(label, p_open, flags); }
storage_set_bool          :: #force_inline proc(self: ^Storage, key: ImID, val: bool)                                                                          { ImGuiStorage_SetBool(self, key, val); }

font_atlas_is_built :: #force_inline proc(self: ^Font_Atlas) -> bool { return ImFontAtlas_IsBuilt(self); }

show_style_selector        :: #force_inline proc(label: string) -> bool                                                           { return swr_igShowStyleSelector(label); }
same_line                  :: #force_inline proc(offset_from_start_x := f32(0.0), spacing := f32(-1.0))                           { igSameLine(offset_from_start_x, spacing); }
show_demo_window           :: #force_inline proc(p_open : ^bool = nil)                                                            { igShowDemoWindow(p_open); }
get_platform_io            :: #force_inline proc() -> ^Platform_Io                                                                { return igGetPlatformIO(); }
draw_list_path_arc_to_fast :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, a_min_of_12: i32, a_max_of_12: i32) { ImDrawList_PathArcToFast(self, center, radius, a_min_of_12, a_max_of_12); }

calc_item_width                        :: #force_inline proc() -> f32                                                                 { return igCalcItemWidth(); }
end_menu_bar                           :: #force_inline proc()                                                                        { igEndMenuBar(); }
set_allocator_functions                :: #force_inline proc(alloc_func: Alloc_Func, free_func: Free_Func)                            { wrapper_set_allocator_functions(alloc_func, free_func); }

is_key_pressed :: proc {
	is_key_pressed_bool,
};
is_key_pressed_bool                    :: #force_inline proc(key: Key, repeat := bool(true)) -> bool                                  { return igIsKeyPressed_Bool(key, repeat); }

get_current_context                    :: #force_inline proc() -> ^Context                                                            { return igGetCurrentContext(); }

set_window_size :: proc {
	set_window_size_vec2,
	set_window_size_str,
};
set_window_size_vec2                   :: #force_inline proc(size: Vec2, cond := Cond(0))                                             { igSetWindowSize_Vec2(size, cond); }
set_window_size_str                    :: #force_inline proc(name: string, size: Vec2, cond := Cond(0))                               { swr_igSetWindowSize_Str(name, size, cond); }

get_clipboard_text                     :: #force_inline proc() -> cstring                                                             { return igGetClipboardText(); }
font_atlas_get_glyph_ranges_vietnamese :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar                                             { return ImFontAtlas_GetGlyphRangesVietnamese(self); }

color_edit3                       :: #force_inline proc(label: string, col: [3]f32, flags := Color_Edit_Flags(0)) -> bool                                      { return swr_igColorEdit3(label, col, flags); }
image                             :: #force_inline proc(user_texture_id: Texture_ID, image_size: Vec2, uv0 := Vec2(Vec2 {0,0}), uv1 := Vec2(Vec2 {1,1}), tint_col := Vec4(Vec4 {1,1,1,1}), border_col := Vec4(Vec4 {0,0,0,0})) { igImage(user_texture_id, image_size, uv0, uv1, tint_col, border_col); }
log_to_file                       :: #force_inline proc(auto_open_depth := i32(-1), filename := "")                                                            { swr_igLogToFile(auto_open_depth, filename); }
font_glyph_ranges_builder_get_bit :: #force_inline proc(self: ^Font_Glyph_Ranges_Builder, n: uint) -> bool                                                     { return ImFontGlyphRangesBuilder_GetBit(self, n); }

font_build_lookup_table :: #force_inline proc(self: ^ImFont) { ImFont_BuildLookupTable(self); }

table_headers_row :: #force_inline proc()                                                                                 { igTableHeadersRow(); }
begin_list_box    :: #force_inline proc(label: string, size := Vec2(Vec2 {0,0})) -> bool                                  { return swr_igBeginListBox(label, size); }
push_clip_rect    :: #force_inline proc(clip_rect_min: Vec2, clip_rect_max: Vec2, intersect_with_current_clip_rect: bool) { igPushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect); }
button            :: #force_inline proc(label: string, size := Vec2(Vec2 {0,0})) -> bool                                  { return swr_igButton(label, size); }
font_is_loaded    :: #force_inline proc(self: ^ImFont) -> bool                                                            { return ImFont_IsLoaded(self); }

draw_list_on_changed_clip_rect :: #force_inline proc(self: ^Draw_List) { ImDrawList__OnChangedClipRect(self); }

next_column          :: #force_inline proc()                                                                                              { igNextColumn(); }
push_item_width      :: #force_inline proc(item_width: f32)                                                                               { igPushItemWidth(item_width); }
slider_int           :: #force_inline proc(label: string, v: ^i32, v_min: i32, v_max: i32, format := "%d", flags := Slider_Flags(0)) -> bool { return swr_igSliderInt(label, v, v_min, v_max, format, flags); }
mem_alloc            :: #force_inline proc(size: uint) -> rawptr                                                                          { return igMemAlloc(size); }
storage_set_void_ptr :: #force_inline proc(self: ^Storage, key: ImID, val: rawptr)                                                        { ImGuiStorage_SetVoidPtr(self, key, val); }

set_scroll_here_y             :: #force_inline proc(center_y_ratio := f32(0.5))                { igSetScrollHereY(center_y_ratio); }
open_popup_on_item_click      :: #force_inline proc(str_id := "", popup_flags := Popup_Flags(1)) { swr_igOpenPopupOnItemClick(str_id, popup_flags); }
pop_style_color               :: #force_inline proc(count := i32(1))                           { igPopStyleColor(count); }
get_scroll_max_y              :: #force_inline proc() -> f32                                   { return igGetScrollMaxY(); }
draw_list_set_texture_id      :: #force_inline proc(self: ^Draw_List, texture_id: Texture_ID)  { ImDrawList__SetTextureID(self, texture_id); }
draw_list_pop_unused_draw_cmd :: #force_inline proc(self: ^Draw_List)                          { ImDrawList__PopUnusedDrawCmd(self); }

input_text_callback_data_clear_selection :: #force_inline proc(self: ^Input_Text_Callback_Data) { ImGuiInputTextCallbackData_ClearSelection(self); }

text_filter_draw :: #force_inline proc(self: ^Text_Filter, label := "Filter(inc,-exc)", width := f32(0.0)) -> bool { return swr_ImGuiTextFilter_Draw(self, label, width); }

get_drag_drop_payload          :: #force_inline proc() -> ^Payload                                                                           { return igGetDragDropPayload(); }
get_font                       :: #force_inline proc() -> ^ImFont                                                                            { return igGetFont(); }
font_atlas_calc_custom_rect_uv :: #force_inline proc(self: ^Font_Atlas, rect: ^Font_Atlas_Custom_Rect, out_uv_min: ^Vec2, out_uv_max: ^Vec2) { ImFontAtlas_CalcCustomRectUV(self, rect, out_uv_min, out_uv_max); }

get_style_color_name     :: #force_inline proc(idx: Col) -> cstring                  { return igGetStyleColorName(idx); }
get_cursor_start_pos     :: #force_inline proc(pOut: ^Vec2)                          { igGetCursorStartPos(pOut); }
set_tooltip              :: #force_inline proc(fmt_: string, args: ..any)            { swr_igSetTooltip(fmt_, args); }
table_set_column_enabled :: #force_inline proc(column_n: i32, v: bool)               { igTableSetColumnEnabled(column_n, v); }
draw_list_pop_clip_rect  :: #force_inline proc(self: ^Draw_List)                     { ImDrawList_PopClipRect(self); }

debug_text_encoding   :: #force_inline proc(text: string)                                                                                        { swr_igDebugTextEncoding(text); }
draw_list_add_ellipse :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: Vec2, col: u32, rot := f32(0.0), num_segments := i32(0), thickness := f32(1.0)) { ImDrawList_AddEllipse(self, center, radius, col, rot, num_segments, thickness); }


collapsing_header :: proc {
	collapsing_header_tree_node_flags,
	collapsing_header_bool_ptr,
};
collapsing_header_tree_node_flags :: #force_inline proc(label: string, flags := Tree_Node_Flags(0)) -> bool                                          { return swr_igCollapsingHeader_TreeNodeFlags(label, flags); }
collapsing_header_bool_ptr        :: #force_inline proc(label: string, p_visible: ^bool, flags := Tree_Node_Flags(0)) -> bool                        { return swr_igCollapsingHeader_BoolPtr(label, p_visible, flags); }

tab_item_button                   :: #force_inline proc(label: string, flags := Tab_Item_Flags(0)) -> bool                                           { return swr_igTabItemButton(label, flags); }
is_item_clicked                   :: #force_inline proc(mouse_button := Mouse_Button(0)) -> bool                                                     { return igIsItemClicked(mouse_button); }
draw_list_get_clip_rect_max       :: #force_inline proc(pOut: ^Vec2, self: ^Draw_List)                                                               { ImDrawList_GetClipRectMax(pOut, self); }
draw_list_add_bezier_quadratic    :: #force_inline proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32, thickness: f32, num_segments := i32(0)) { ImDrawList_AddBezierQuadratic(self, p1, p2, p3, col, thickness, num_segments); }

selection_basic_storage_get_next_selected_item :: #force_inline proc(self: ^Selection_Basic_Storage, opaque_it: ^rawptr, out_id: ^ImID) -> bool { return ImGuiSelectionBasicStorage_GetNextSelectedItem(self, opaque_it, out_id); }

pop_text_wrap_pos      :: #force_inline proc()                                                                            { igPopTextWrapPos(); }
is_mouse_pos_valid     :: #force_inline proc(mouse_pos : ^Vec2 = nil) -> bool                                             { return igIsMousePosValid(mouse_pos); }
input_float3           :: #force_inline proc(label: string, v: [3]f32, format := "%.3f", flags := Input_Text_Flags(0)) -> bool { return swr_igInputFloat3(label, v, format, flags); }
reset_mouse_drag_delta :: #force_inline proc(button := Mouse_Button(0))                                                   { igResetMouseDragDelta(button); }
payload_is_delivery    :: #force_inline proc(self: ^Payload) -> bool                                                      { return ImGuiPayload_IsDelivery(self); }

table_set_bg_color :: #force_inline proc(target: Table_Bg_Target, color: u32, column_n := i32(-1))                                                      { igTableSetBgColor(target, color, column_n); }
drag_int3          :: #force_inline proc(label: string, v: [3]i32, v_speed := f32(1.0), v_min := i32(0), v_max := i32(0), format := "%d", flags := Slider_Flags(0)) -> bool { return swr_igDragInt3(label, v, v_speed, v_min, v_max, format, flags); }
storage_get_float  :: #force_inline proc(self: ^Storage, key: ImID, default_val := f32(0.0)) -> f32                                                     { return ImGuiStorage_GetFloat(self, key, default_val); }

payload_clear :: #force_inline proc(self: ^Payload) { ImGuiPayload_Clear(self); }

pop_font             :: #force_inline proc()                                                   { igPopFont(); }
set_next_window_size :: #force_inline proc(size: Vec2, cond := Cond(0))                        { igSetNextWindowSize(size, cond); }
get_version          :: #force_inline proc() -> cstring                                        { return igGetVersion(); }
storage_get_int      :: #force_inline proc(self: ^Storage, key: ImID, default_val := i32(0)) -> i32 { return ImGuiStorage_GetInt(self, key, default_val); }

draw_list_add_polyline :: #force_inline proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32, flags: Draw_Flags, thickness: f32)                 { ImDrawList_AddPolyline(self, points, num_points, col, flags, thickness); }
draw_list_add_image    :: #force_inline proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: Vec2, p_max: Vec2, uv_min := Vec2(Vec2 {0,0}), uv_max := Vec2(Vec2 {1,1}), col := u32(4294967295)) { ImDrawList_AddImage(self, user_texture_id, p_min, p_max, uv_min, uv_max, col); }

color_button                        :: #force_inline proc(desc_id: string, col: Vec4, flags := Color_Edit_Flags(0), size := Vec2(Vec2 {0,0})) -> bool { return swr_igColorButton(desc_id, col, flags, size); }
font_atlas_get_custom_rect_by_index :: #force_inline proc(self: ^Font_Atlas, index: i32) -> ^Font_Atlas_Custom_Rect                 { return ImFontAtlas_GetCustomRectByIndex(self, index); }

selection_basic_storage_swap :: #force_inline proc(self: ^Selection_Basic_Storage, r: ^Selection_Basic_Storage) { ImGuiSelectionBasicStorage_Swap(self, r); }

font_glyph_ranges_builder_add_text :: #force_inline proc(self: ^Font_Glyph_Ranges_Builder, text: string, text_end := "")     { swr_ImFontGlyphRangesBuilder_AddText(self, text, text_end); }

font_get_debug_name :: #force_inline proc(self: ^ImFont) -> cstring { return ImFont_GetDebugName(self); }

draw_list_path_arc_to_n :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) { ImDrawList__PathArcToN(self, center, radius, a_min, a_max, num_segments); }

indent                            :: #force_inline proc(indent_w := f32(0.0))                                                                                            { igIndent(indent_w); }
is_item_deactivated_after_edit    :: #force_inline proc() -> bool                                                                                                        { return igIsItemDeactivatedAfterEdit(); }
font_atlas_add_font_from_file_ttf :: #force_inline proc(self: ^Font_Atlas, filename: string, size_pixels: f32, font_cfg : ^Font_Config = nil, glyph_ranges : ^Wchar = nil) -> ^ImFont { return swr_ImFontAtlas_AddFontFromFileTTF(self, filename, size_pixels, font_cfg, glyph_ranges); }

io_add_input_character :: #force_inline proc(self: ^IO, c: u32) { ImGuiIO_AddInputCharacter(self, c); }


add_text :: proc {
	draw_list_add_text_vec2,
	draw_list_add_text_font_ptr,
};
draw_list_add_text_vec2     :: #force_inline proc(self: ^Draw_List, pos: Vec2, col: u32, text_begin: string, text_end := "")                                                                                { swr_ImDrawList_AddText_Vec2(self, pos, col, text_begin, text_end); }
draw_list_add_text_font_ptr :: #force_inline proc(self: ^Draw_List, font: ^ImFont, font_size: f32, pos: Vec2, col: u32, text_begin: string, text_end := "", wrap_width := f32(0.0), cpu_fine_clip_rect : ^Vec4 = nil) { swr_ImDrawList_AddText_FontPtr(self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect); }



push_style_var :: proc {
	push_style_var_float,
	push_style_var_vec2,
};
push_style_var_float           :: #force_inline proc(idx: Style_Var, val: f32)  { igPushStyleVar_Float(idx, val); }
push_style_var_vec2            :: #force_inline proc(idx: Style_Var, val: Vec2) { igPushStyleVar_Vec2(idx, val); }

set_next_item_open             :: #force_inline proc(is_open: bool, cond := Cond(0)) { igSetNextItemOpen(is_open, cond); }
draw_list_channels_set_current :: #force_inline proc(self: ^Draw_List, n: i32)  { ImDrawList_ChannelsSetCurrent(self, n); }

text_wrapped                :: #force_inline proc(fmt_: string, args: ..any)                        { wrapper_text_wrapped(fmt_, ..args); }
load_ini_settings_from_disk :: #force_inline proc(ini_filename: string)                             { swr_igLoadIniSettingsFromDisk(ini_filename); }
begin_group                 :: #force_inline proc()                                                 { igBeginGroup(); }
draw_list_add_draw_cmd      :: #force_inline proc(self: ^Draw_List)                                 { ImDrawList_AddDrawCmd(self); }
draw_list_prim_reserve      :: #force_inline proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) { ImDrawList_PrimReserve(self, idx_count, vtx_count); }

io_add_input_characters_utf8 :: #force_inline proc(self: ^IO, str: string)  { swr_ImGuiIO_AddInputCharactersUTF8(self, str); }


set_item_key_owner :: proc {
	set_item_key_owner_nil,
};
set_item_key_owner_nil       :: #force_inline proc(key: Key)                                                                            { igSetItemKeyOwner_Nil(key); }

draw_list_add_ellipse_filled :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: Vec2, col: u32, rot := f32(0.0), num_segments := i32(0)) { ImDrawList_AddEllipseFilled(self, center, radius, col, rot, num_segments); }

separator                                         :: #force_inline proc()                                                 { igSeparator(); }
selection_basic_storage_get_storage_id_from_index :: #force_inline proc(self: ^Selection_Basic_Storage, idx: i32) -> ImID { return ImGuiSelectionBasicStorage_GetStorageIdFromIndex(self, idx); }


is_mouse_down :: proc {
	is_mouse_down_nil,
};
is_mouse_down_nil     :: #force_inline proc(button: Mouse_Button) -> bool                                                                                                        { return igIsMouseDown_Nil(button); }

font_calc_text_size_a :: #force_inline proc(pOut: ^Vec2, self: ^ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: string, text_end := "", remaining : ^cstring = nil) { swr_ImFont_CalcTextSizeA(pOut, self, size, max_width, wrap_width, text_begin, text_end, remaining); }

input_float                       :: #force_inline proc(label: string, v: ^f32, step := f32(0.0), step_fast := f32(0.0), format := "%.3f", flags := Input_Text_Flags(0)) -> bool { return swr_igInputFloat(label, v, step, step_fast, format, flags); }
set_next_frame_want_capture_mouse :: #force_inline proc(want_capture_mouse: bool)                                                                             { igSetNextFrameWantCaptureMouse(want_capture_mouse); }
begin_menu                        :: #force_inline proc(label: string, enabled := bool(true)) -> bool                                                         { return swr_igBeginMenu(label, enabled); }
draw_list_add_ngon                :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32, thickness := f32(1.0))      { ImDrawList_AddNgon(self, center, radius, col, num_segments, thickness); }

begin_table           :: #force_inline proc(str_id: string, columns: i32, flags := Table_Flags(0), outer_size := Vec2(Vec2 {0.0,0.0}), inner_width := f32(0.0)) -> bool { return swr_igBeginTable(str_id, columns, flags, outer_size, inner_width); }
pop_clip_rect         :: #force_inline proc()                                                                                              { igPopClipRect(); }
draw_list_path_arc_to :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, a_min: f32, a_max: f32, num_segments := i32(0))   { ImDrawList_PathArcTo(self, center, radius, a_min, a_max, num_segments); }

unindent            :: #force_inline proc(indent_w := f32(0.0))                                                                                                                                            { igUnindent(indent_w); }
drag_scalar_n       :: #force_inline proc(label: string, data_type: Data_Type, p_data: rawptr, components: i32, v_speed := f32(1.0), p_min : rawptr = nil, p_max : rawptr = nil, format := "", flags := Slider_Flags(0)) -> bool { return swr_igDragScalarN(label, data_type, p_data, components, v_speed, p_min, p_max, format, flags); }
text_buffer_appendf :: #force_inline proc(self: ^Text_Buffer, fmt_: string, args: ..any)                                                                                                                   { swr_ImGuiTextBuffer_appendf(self, fmt_, args); }

input_double       :: #force_inline proc(label: string, v: ^f64, step := f64(0.0), step_fast := f64(0.0), format := "%.6f", flags := Input_Text_Flags(0)) -> bool { return swr_igInputDouble(label, v, step, step_fast, format, flags); }
style_colors_light :: #force_inline proc(dst : ^Style = nil)                                                                                   { igStyleColorsLight(dst); }
list_clipper_step  :: #force_inline proc(self: ^List_Clipper) -> bool                                                                          { return ImGuiListClipper_Step(self); }

slider_int4                       :: #force_inline proc(label: string, v: [4]i32, v_min: i32, v_max: i32, format := "%d", flags := Slider_Flags(0)) -> bool { return swr_igSliderInt4(label, v, v_min, v_max, format, flags); }
draw_list_add_concave_poly_filled :: #force_inline proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32)                                      { ImDrawList_AddConcavePolyFilled(self, points, num_points, col); }

selection_basic_storage_apply_requests :: #force_inline proc(self: ^Selection_Basic_Storage, ms_io: ^Multi_Select_Io) { ImGuiSelectionBasicStorage_ApplyRequests(self, ms_io); }

color_convert_hs_vto_rgb :: #force_inline proc(h: f32, s: f32, v: f32, out_r: ^f32, out_g: ^f32, out_b: ^f32) { igColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b); }
table_get_column_count   :: #force_inline proc() -> i32                                                       { return igTableGetColumnCount(); }
set_next_item_shortcut   :: #force_inline proc(key_chord: Key_Chord, flags := Input_Flags(0))                 { igSetNextItemShortcut(key_chord, flags); }
text_filter_clear        :: #force_inline proc(self: ^Text_Filter)                                            { ImGuiTextFilter_Clear(self); }

draw_list_prim_write_vtx :: #force_inline proc(self: ^Draw_List, pos: Vec2, uv: Vec2, col: u32) { ImDrawList_PrimWriteVtx(self, pos, uv, col); }


radio_button :: proc {
	radio_button_bool,
	radio_button_int_ptr,
};
radio_button_bool                 :: #force_inline proc(label: string, active: bool) -> bool                                                                                                         { return swr_igRadioButton_Bool(label, active); }
radio_button_int_ptr              :: #force_inline proc(label: string, v: ^i32, v_button: i32) -> bool                                                                                               { return swr_igRadioButton_IntPtr(label, v, v_button); }


push_style_color :: proc {
	push_style_color_u32,
	push_style_color_vec4,
};
push_style_color_u32              :: #force_inline proc(idx: Col, col: u32)                                                                                                                          { igPushStyleColor_U32(idx, col); }
push_style_color_vec4             :: #force_inline proc(idx: Col, col: Vec4)                                                                                                                         { igPushStyleColor_Vec4(idx, col); }

set_column_offset                 :: #force_inline proc(column_index: i32, offset_x: f32)                                                                                                            { igSetColumnOffset(column_index, offset_x); }
slider_float                      :: #force_inline proc(label: string, v: ^f32, v_min: f32, v_max: f32, format := "%.3f", flags := Slider_Flags(0)) -> bool                                          { return swr_igSliderFloat(label, v, v_min, v_max, format, flags); }
input_text_multiline              :: #force_inline proc(label: string, buf: string, buf_size: uint, size := Vec2(Vec2 {0,0}), flags := Input_Text_Flags(0), callback : Input_Text_Callback = nil, user_data : rawptr = nil) -> bool { return swr_igInputTextMultiline(label, buf, buf_size, size, flags, callback, user_data); }
set_cursor_pos_x                  :: #force_inline proc(local_x: f32)                                                                                                                                { igSetCursorPosX(local_x); }
input_text                        :: #force_inline proc(label: string, buf: []u8, flags := Input_Text_Flags(0), callback : Input_Text_Callback = nil, user_data : rawptr = nil) -> bool              { return wrapper_input_text(label, buf, flags, callback, user_data); }
font_atlas_get_tex_data_as_alpha8 :: #force_inline proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel : ^i32 = nil)                                    { ImFontAtlas_GetTexDataAsAlpha8(self, out_pixels, out_width, out_height, out_bytes_per_pixel); }


set_scroll_y :: proc {
	set_scroll_y_float,
};
set_scroll_y_float              :: #force_inline proc(scroll_y: f32)                                                                                                     { igSetScrollY_Float(scroll_y); }

get_mouse_cursor                :: #force_inline proc() -> Mouse_Cursor                                                                                                  { return igGetMouseCursor(); }
style_colors_classic            :: #force_inline proc(dst : ^Style = nil)                                                                                                { igStyleColorsClassic(dst); }
slider_angle                    :: #force_inline proc(label: string, v_rad: ^f32, v_degrees_min := f32(-360.0), v_degrees_max := f32(+360.0), format := "%.0f deg", flags := Slider_Flags(0)) -> bool { return swr_igSliderAngle(label, v_rad, v_degrees_min, v_degrees_max, format, flags); }
end_menu                        :: #force_inline proc()                                                                                                                  { igEndMenu(); }
draw_list_on_changed_vtx_offset :: #force_inline proc(self: ^Draw_List)                                                                                                  { ImDrawList__OnChangedVtxOffset(self); }

show_debug_log_window         :: #force_inline proc(p_open : ^bool = nil)                                { igShowDebugLogWindow(p_open); }
get_window_draw_list          :: #force_inline proc() -> ^Draw_List                                      { return igGetWindowDrawList(); }

push_id :: proc {
	push_id_str,
	push_id_str_str,
	push_id_ptr,
	push_id_int,
};
push_id_str                   :: #force_inline proc(str_id: string)                                      { swr_igPushID_Str(str_id); }
push_id_str_str               :: #force_inline proc(str_id_begin: string, str_id_end: string)            { swr_igPushID_StrStr(str_id_begin, str_id_end); }
push_id_ptr                   :: #force_inline proc(ptr_id: rawptr)                                      { igPushID_Ptr(ptr_id); }
push_id_int                   :: #force_inline proc(int_id: i32)                                         { igPushID_Int(int_id); }

begin_popup_context_item      :: #force_inline proc(str_id := "", popup_flags := Popup_Flags(1)) -> bool { return swr_igBeginPopupContextItem(str_id, popup_flags); }
get_window_width              :: #force_inline proc() -> f32                                             { return igGetWindowWidth(); }
load_ini_settings_from_memory :: #force_inline proc(ini_data: string, ini_size := uint(0))               { swr_igLoadIniSettingsFromMemory(ini_data, ini_size); }
storage_get_int_ref           :: #force_inline proc(self: ^Storage, key: ImID, default_val := i32(0)) -> ^i32 { return ImGuiStorage_GetIntRef(self, key, default_val); }

get_scroll_y         :: #force_inline proc() -> f32                                                                                  { return igGetScrollY(); }
bullet_text          :: #force_inline proc(fmt_: string, args: ..any)                                                                { swr_igBulletText(fmt_, args); }
end_multi_select     :: #force_inline proc() -> ^Multi_Select_Io                                                                     { return igEndMultiSelect(); }
text_link            :: #force_inline proc(label: string) -> bool                                                                    { return swr_igTextLink(label); }
draw_list_add_circle :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments := i32(0), thickness := f32(1.0)) { ImDrawList_AddCircle(self, center, radius, col, num_segments, thickness); }

render          :: #force_inline proc()                                                                                                                                               { igRender(); }
drag_scalar     :: #force_inline proc(label: string, data_type: Data_Type, p_data: rawptr, v_speed := f32(1.0), p_min : rawptr = nil, p_max : rawptr = nil, format := "", flags := Slider_Flags(0)) -> bool { return swr_igDragScalar(label, data_type, p_data, v_speed, p_min, p_max, format, flags); }
font_find_glyph :: #force_inline proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph                                                                                                         { return ImFont_FindGlyph(self, c); }

text_range_split :: #force_inline proc(self: ^Text_Range, separator: i8, out: ^Im_Vector(Text_Range)) { ImGuiTextRange_split(self, separator, out); }

draw_list_prim_unreserve :: #force_inline proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) { ImDrawList_PrimUnreserve(self, idx_count, vtx_count); }

begin_combo                        :: #force_inline proc(label: string, preview_value: string, flags := Combo_Flags(0)) -> bool { return swr_igBeginCombo(label, preview_value, flags); }
get_font_tex_uv_white_pixel        :: #force_inline proc(pOut: ^Vec2)                                                        { igGetFontTexUvWhitePixel(pOut); }
end_drag_drop_source               :: #force_inline proc()                                                                   { igEndDragDropSource(); }
font_glyph_ranges_builder_add_char :: #force_inline proc(self: ^Font_Glyph_Ranges_Builder, c: Wchar)                         { ImFontGlyphRangesBuilder_AddChar(self, c); }

color_convert_rg_bto_hsv :: #force_inline proc(r: f32, g: f32, b: f32, out_h: ^f32, out_s: ^f32, out_v: ^f32) { igColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v); }
draw_data_add_draw_list  :: #force_inline proc(self: ^Draw_Data, draw_list: ^Draw_List)                       { ImDrawData_AddDrawList(self, draw_list); }

input_scalar_n                :: #force_inline proc(label: string, data_type: Data_Type, p_data: rawptr, components: i32, p_step : rawptr = nil, p_step_fast : rawptr = nil, format := "", flags := Input_Text_Flags(0)) -> bool { return swr_igInputScalarN(label, data_type, p_data, components, p_step, p_step_fast, format, flags); }
get_item_rect_min             :: #force_inline proc(pOut: ^Vec2)                                                                                                                                                  { igGetItemRectMin(pOut); }
set_scroll_here_x             :: #force_inline proc(center_x_ratio := f32(0.5))                                                                                                                                   { igSetScrollHereX(center_x_ratio); }
draw_list_try_merge_draw_cmds :: #force_inline proc(self: ^Draw_List)                                                                                                                                             { ImDrawList__TryMergeDrawCmds(self); }


list_box :: proc {
	list_box_str_arr,
	list_box_fn_str_ptr,
};
list_box_str_arr          :: #force_inline proc(label: string, current_item: ^i32, items: string, items_count: i32, height_in_items := i32(-1)) -> bool                   { return swr_igListBox_Str_arr(label, current_item, items, items_count, height_in_items); }
list_box_fn_str_ptr       :: #force_inline proc(label: string, current_item: ^i32, getter: ^^cstring, user_data: rawptr, items_count: i32, height_in_items := i32(-1)) -> bool { return swr_igListBox_FnStrPtr(label, current_item, getter, user_data, items_count, height_in_items); }

get_scroll_max_x          :: #force_inline proc() -> f32                                                                                                                  { return igGetScrollMaxX(); }

set_window_collapsed :: proc {
	set_window_collapsed_bool,
	set_window_collapsed_str,
};
set_window_collapsed_bool :: #force_inline proc(collapsed: bool, cond := Cond(0))                                                                                         { igSetWindowCollapsed_Bool(collapsed, cond); }
set_window_collapsed_str  :: #force_inline proc(name: string, collapsed: bool, cond := Cond(0))                                                                           { swr_igSetWindowCollapsed_Str(name, collapsed, cond); }

is_window_focused         :: #force_inline proc(flags := Focused_Flags(0)) -> bool                                                                                        { return igIsWindowFocused(flags); }
set_color_edit_options    :: #force_inline proc(flags: Color_Edit_Flags)                                                                                                  { igSetColorEditOptions(flags); }
get_key_name              :: #force_inline proc(key: Key) -> cstring                                                                                                      { return igGetKeyName(key); }
end_drag_drop_target      :: #force_inline proc()                                                                                                                         { igEndDragDropTarget(); }
separator_text            :: #force_inline proc(label: string)                                                                                                            { swr_igSeparatorText(label); }
set_next_window_bg_alpha  :: #force_inline proc(alpha: f32)                                                                                                               { igSetNextWindowBgAlpha(alpha); }
io_add_key_event          :: #force_inline proc(self: ^IO, key: Key, down: bool)                                                                                          { ImGuiIO_AddKeyEvent(self, key, down); }

set_column_width                  :: #force_inline proc(column_index: i32, width: f32)                                                                     { igSetColumnWidth(column_index, width); }

checkbox_flags :: proc {
	checkbox_flags_int_ptr,
	checkbox_flags_uint_ptr,
};
checkbox_flags_int_ptr            :: #force_inline proc(label: string, flags: ^i32, flags_value: i32) -> bool                                              { return swr_igCheckboxFlags_IntPtr(label, flags, flags_value); }
checkbox_flags_uint_ptr           :: #force_inline proc(label: string, flags: ^u32, flags_value: u32) -> bool                                              { return swr_igCheckboxFlags_UintPtr(label, flags, flags_value); }

get_cursor_screen_pos             :: #force_inline proc(pOut: ^Vec2)                                                                                       { igGetCursorScreenPos(pOut); }
begin_tooltip                     :: #force_inline proc() -> bool                                                                                          { return igBeginTooltip(); }
is_item_focused                   :: #force_inline proc() -> bool                                                                                          { return igIsItemFocused(); }
pop_style_var                     :: #force_inline proc(count := i32(1))                                                                                   { igPopStyleVar(count); }
font_atlas_get_tex_data_as_rgba32 :: #force_inline proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel : ^i32 = nil) { ImFontAtlas_GetTexDataAsRGBA32(self, out_pixels, out_width, out_height, out_bytes_per_pixel); }
font_atlas_set_tex_id             :: #force_inline proc(self: ^Font_Atlas, id: Texture_ID)                                                                 { ImFontAtlas_SetTexID(self, id); }

io_add_focus_event :: #force_inline proc(self: ^IO, focused: bool) { ImGuiIO_AddFocusEvent(self, focused); }

font_atlas_add_custom_rect_font_glyph :: #force_inline proc(self: ^Font_Atlas, font: ^ImFont, id: Wchar, width: i32, height: i32, advance_x: f32, offset := Vec2(Vec2 {0,0})) -> i32 { return ImFontAtlas_AddCustomRectFontGlyph(self, font, id, width, height, advance_x, offset); }

set_next_item_selection_user_data                    :: #force_inline proc(selection_user_data: Selection_User_Data)                                                                                           { igSetNextItemSelectionUserData(selection_user_data); }
drag_int                                             :: #force_inline proc(label: string, v: ^i32, v_speed := f32(1.0), v_min := i32(0), v_max := i32(0), format := "%d", flags := Slider_Flags(0)) -> bool    { return swr_igDragInt(label, v, v_speed, v_min, v_max, format, flags); }
font_atlas_add_font_from_memory_compressed_base85ttf :: #force_inline proc(self: ^Font_Atlas, compressed_font_data_base85: string, size_pixels: f32, font_cfg : ^Font_Config = nil, glyph_ranges : ^Wchar = nil) -> ^ImFont { return swr_ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self, compressed_font_data_base85, size_pixels, font_cfg, glyph_ranges); }

draw_list_add_image_quad :: #force_inline proc(self: ^Draw_List, user_texture_id: Texture_ID, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, uv1 := Vec2(Vec2 {0,0}), uv2 := Vec2(Vec2 {1,0}), uv3 := Vec2(Vec2 {1,1}), uv4 := Vec2(Vec2 {0,1}), col := u32(4294967295)) { ImDrawList_AddImageQuad(self, user_texture_id, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col); }

is_item_activated   :: #force_inline proc() -> bool                                                                                                                                     { return igIsItemActivated(); }
v_slider_scalar     :: #force_inline proc(label: string, size: Vec2, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format := "", flags := Slider_Flags(0)) -> bool { return swr_igVSliderScalar(label, size, data_type, p_data, p_min, p_max, format, flags); }
begin_popup_modal   :: #force_inline proc(name: string, p_open : ^bool = nil, flags := Window_Flags(0)) -> bool                                                                         { return swr_igBeginPopupModal(name, p_open, flags); }
font_add_remap_char :: #force_inline proc(self: ^ImFont, dst: Wchar, src: Wchar, overwrite_dst := bool(true))                                                                           { ImFont_AddRemapChar(self, dst, src, overwrite_dst); }

draw_list_path_elliptical_arc_to :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: Vec2, rot: f32, a_min: f32, a_max: f32, num_segments := i32(0)) { ImDrawList_PathEllipticalArcTo(self, center, radius, rot, a_min, a_max, num_segments); }

drag_int2         :: #force_inline proc(label: string, v: [2]i32, v_speed := f32(1.0), v_min := i32(0), v_max := i32(0), format := "%d", flags := Slider_Flags(0)) -> bool { return swr_igDragInt2(label, v, v_speed, v_min, v_max, format, flags); }
get_main_viewport :: #force_inline proc() -> ^Viewport                                                                                                 { return igGetMainViewport(); }
text_buffer_end   :: #force_inline proc(self: ^Text_Buffer) -> cstring                                                                                 { return ImGuiTextBuffer_end(self); }

end_group                   :: #force_inline proc()                                                                                                                                                { igEndGroup(); }
new_frame                   :: #force_inline proc()                                                                                                                                                { igNewFrame(); }
draw_list_add_image_rounded :: #force_inline proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: Vec2, p_max: Vec2, uv_min: Vec2, uv_max: Vec2, col: u32, rounding: f32, flags := Draw_Flags(0)) { ImDrawList_AddImageRounded(self, user_texture_id, p_min, p_max, uv_min, uv_max, col, rounding, flags); }

begin_menu_bar       :: #force_inline proc() -> bool                                                                              { return igBeginMenuBar(); }

tree_node_ex :: proc {
	tree_node_ex_str,
	tree_node_ex_str_str,
	tree_node_ex_ptr,
};
tree_node_ex_str     :: #force_inline proc(label: string, flags := Tree_Node_Flags(0)) -> bool                                    { return swr_igTreeNodeEx_Str(label, flags); }
tree_node_ex_str_str :: #force_inline proc(str_id: string, flags: Tree_Node_Flags, fmt_: string, args: ..any) -> bool             { return swr_igTreeNodeEx_StrStr(str_id, flags, fmt_, args); }
tree_node_ex_ptr     :: #force_inline proc(ptr_id: rawptr, flags: Tree_Node_Flags, fmt_: string, args: ..any) -> bool             { return swr_igTreeNodeEx_Ptr(ptr_id, flags, fmt_, args); }

get_cursor_pos       :: #force_inline proc(pOut: ^Vec2)                                                                           { igGetCursorPos(pOut); }
end_frame            :: #force_inline proc()                                                                                      { igEndFrame(); }
draw_list_add_quad   :: #force_inline proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32, thickness := f32(1.0)) { ImDrawList_AddQuad(self, p1, p2, p3, p4, col, thickness); }

get_cursor_pos_x        :: #force_inline proc() -> f32                                 { return igGetCursorPosX(); }
show_metrics_window     :: #force_inline proc(p_open : ^bool = nil)                    { igShowMetricsWindow(p_open); }
io_add_key_analog_event :: #force_inline proc(self: ^IO, key: Key, down: bool, v: f32) { ImGuiIO_AddKeyAnalogEvent(self, key, down, v); }

begin_popup                   :: #force_inline proc(str_id: string, flags := Window_Flags(0)) -> bool                                               { return swr_igBeginPopup(str_id, flags); }
end_table                     :: #force_inline proc()                                                                                               { igEndTable(); }
draw_list_path_arc_to_fast_ex :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, a_min_sample: i32, a_max_sample: i32, a_step: i32) { ImDrawList__PathArcToFastEx(self, center, radius, a_min_sample, a_max_sample, a_step); }

set_keyboard_focus_here :: #force_inline proc(offset := i32(0))                    { igSetKeyboardFocusHere(offset); }
storage_set_int         :: #force_inline proc(self: ^Storage, key: ImID, val: i32) { ImGuiStorage_SetInt(self, key, val); }

begin_popup_context_void :: #force_inline proc(str_id := "", popup_flags := Popup_Flags(1)) -> bool                                                                                         { return swr_igBeginPopupContextVoid(str_id, popup_flags); }
input_scalar             :: #force_inline proc(label: string, data_type: Data_Type, p_data: rawptr, p_step : rawptr = nil, p_step_fast : rawptr = nil, format := "", flags := Input_Text_Flags(0)) -> bool { return swr_igInputScalar(label, data_type, p_data, p_step, p_step_fast, format, flags); }
font_atlas_clear         :: #force_inline proc(self: ^Font_Atlas)                                                                                                                           { ImFontAtlas_Clear(self); }

draw_data_clear :: #force_inline proc(self: ^Draw_Data) { ImDrawData_Clear(self); }

list_clipper_end :: #force_inline proc(self: ^List_Clipper) { ImGuiListClipper_End(self); }

set_item_default_focus     :: #force_inline proc()                                                     { igSetItemDefaultFocus(); }
color_convert_float4to_u32 :: #force_inline proc(in_: Vec4) -> u32                                     { return igColorConvertFloat4ToU32(in_); }
is_item_hovered            :: #force_inline proc(flags := Hovered_Flags(0)) -> bool                    { return igIsItemHovered(flags); }
font_atlas_add_font        :: #force_inline proc(self: ^Font_Atlas, font_cfg: ^Font_Config) -> ^ImFont { return ImFontAtlas_AddFont(self, font_cfg); }

set_cursor_pos   :: #force_inline proc(local_pos: Vec2)           { igSetCursorPos(local_pos); }
text_range_empty :: #force_inline proc(self: ^Text_Range) -> bool { return ImGuiTextRange_empty(self); }

push_style_var_x                          :: #force_inline proc(idx: Style_Var, val_x: f32)                                 { igPushStyleVarX(idx, val_x); }
show_about_window                         :: #force_inline proc(p_open : ^bool = nil)                                       { igShowAboutWindow(p_open); }

value :: proc {
	value_bool,
	value_int,
	value_uint,
	value_float,
};
value_bool                                :: #force_inline proc(prefix: string, b: bool)                                    { swr_igValue_Bool(prefix, b); }
value_int                                 :: #force_inline proc(prefix: string, v: i32)                                     { swr_igValue_Int(prefix, v); }
value_uint                                :: #force_inline proc(prefix: string, v: u32)                                     { swr_igValue_Uint(prefix, v); }
value_float                               :: #force_inline proc(prefix: string, v: f32, float_format := "")                 { swr_igValue_Float(prefix, v, float_format); }

selection_external_storage_apply_requests :: #force_inline proc(self: ^Selection_External_Storage, ms_io: ^Multi_Select_Io) { ImGuiSelectionExternalStorage_ApplyRequests(self, ms_io); }

payload_is_preview :: #force_inline proc(self: ^Payload) -> bool { return ImGuiPayload_IsPreview(self); }

io_add_mouse_source_event :: #force_inline proc(self: ^IO, source: Mouse_Source) { ImGuiIO_AddMouseSourceEvent(self, source); }

slider_scalar            :: #force_inline proc(label: string, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format := "", flags := Slider_Flags(0)) -> bool { return swr_igSliderScalar(label, data_type, p_data, p_min, p_max, format, flags); }
calc_text_size           :: #force_inline proc(pOut: ^Vec2, text: string, text_end := "", hide_text_after_double_hash := bool(false), wrap_width := f32(-1.0))                   { swr_igCalcTextSize(pOut, text, text_end, hide_text_after_double_hash, wrap_width); }
table_get_hovered_column :: #force_inline proc() -> i32                                                                                                                          { return igTableGetHoveredColumn(); }
text_buffer_begin        :: #force_inline proc(self: ^Text_Buffer) -> cstring                                                                                                    { return ImGuiTextBuffer_begin(self); }

font_calc_word_wrap_position_a :: #force_inline proc(self: ^ImFont, scale: f32, text: string, text_end: string, wrap_width: f32) -> cstring   { return swr_ImFont_CalcWordWrapPositionA(self, scale, text, text_end, wrap_width); }

columns                       :: #force_inline proc(count := i32(1), id := "", borders := bool(true)) { swr_igColumns(count, id, borders); }
is_item_toggled_open          :: #force_inline proc() -> bool                               { return igIsItemToggledOpen(); }
log_to_tty                    :: #force_inline proc(auto_open_depth := i32(-1))             { igLogToTTY(auto_open_depth); }
get_item_rect_max             :: #force_inline proc(pOut: ^Vec2)                            { igGetItemRectMax(pOut); }
draw_list_reset_for_new_frame :: #force_inline proc(self: ^Draw_List)                       { ImDrawList__ResetForNewFrame(self); }

spacing                              :: #force_inline proc()                            { igSpacing(); }
font_atlas_get_glyph_ranges_cyrillic :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar { return ImFontAtlas_GetGlyphRangesCyrillic(self); }

set_cursor_pos_y             :: #force_inline proc(local_y: f32)                                                                             { igSetCursorPosY(local_y); }
io_set_key_event_native_data :: #force_inline proc(self: ^IO, key: Key, native_keycode: i32, native_scancode: i32, native_legacy_index := i32(-1)) { ImGuiIO_SetKeyEventNativeData(self, key, native_keycode, native_scancode, native_legacy_index); }

text_filter_pass_filter :: #force_inline proc(self: ^Text_Filter, text: string, text_end := "") -> bool     { return swr_ImGuiTextFilter_PassFilter(self, text, text_end); }

draw_list_splitter_set_current_channel :: #force_inline proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, channel_idx: i32) { ImDrawListSplitter_SetCurrentChannel(self, draw_list, channel_idx); }

get_text_line_height_with_spacing :: #force_inline proc() -> f32                                                        { return igGetTextLineHeightWithSpacing(); }

set_scroll_x :: proc {
	set_scroll_x_float,
};
set_scroll_x_float                :: #force_inline proc(scroll_x: f32)                                                  { igSetScrollX_Float(scroll_x); }

draw_list_add_line                :: #force_inline proc(self: ^Draw_List, p1: Vec2, p2: Vec2, col: u32, thickness := f32(1.0)) { ImDrawList_AddLine(self, p1, p2, col, thickness); }

get_allocator_functions             :: #force_inline proc(p_alloc_func: ^Mem_Alloc_Func, p_free_func: ^Mem_Free_Func, p_user_data: ^rawptr) { igGetAllocatorFunctions(p_alloc_func, p_free_func, p_user_data); }
get_mouse_clicked_count             :: #force_inline proc(button: Mouse_Button) -> i32                                                      { return igGetMouseClickedCount(button); }

is_mouse_clicked :: proc {
	is_mouse_clicked_bool,
};
is_mouse_clicked_bool               :: #force_inline proc(button: Mouse_Button, repeat := bool(false)) -> bool                              { return igIsMouseClicked_Bool(button, repeat); }

input_text_callback_data_select_all :: #force_inline proc(self: ^Input_Text_Callback_Data)                                                  { ImGuiInputTextCallbackData_SelectAll(self); }

end_main_menu_bar      :: #force_inline proc()                                              { igEndMainMenuBar(); }
begin_tab_bar          :: #force_inline proc(str_id: string, flags := Tab_Bar_Flags(0)) -> bool { return swr_igBeginTabBar(str_id, flags); }
draw_list_path_line_to :: #force_inline proc(self: ^Draw_List, pos: Vec2)                   { ImDrawList_PathLineTo(self, pos); }

end_combo                            :: #force_inline proc()                                                                                                { igEndCombo(); }
slider_float4                        :: #force_inline proc(label: string, v: [4]f32, v_min: f32, v_max: f32, format := "%.3f", flags := Slider_Flags(0)) -> bool { return swr_igSliderFloat4(label, v, v_min, v_max, format, flags); }
draw_list_splitter_clear_free_memory :: #force_inline proc(self: ^Draw_List_Splitter)                                                                       { ImDrawListSplitter_ClearFreeMemory(self); }

draw_list_prim_quad_uv :: #force_inline proc(self: ^Draw_List, a: Vec2, b: Vec2, c: Vec2, d: Vec2, uv_a: Vec2, uv_b: Vec2, uv_c: Vec2, uv_d: Vec2, col: u32) { ImDrawList_PrimQuadUV(self, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col); }

debug_flash_style_color :: #force_inline proc(idx: Col)                        { igDebugFlashStyleColor(idx); }
style_scale_all_sizes   :: #force_inline proc(self: ^Style, scale_factor: f32) { ImGuiStyle_ScaleAllSizes(self, scale_factor); }

get_text_line_height      :: #force_inline proc() -> f32                                             { return igGetTextLineHeight(); }
get_scroll_x              :: #force_inline proc() -> f32                                             { return igGetScrollX(); }
get_column_offset         :: #force_inline proc(column_index := i32(-1)) -> f32                      { return igGetColumnOffset(column_index); }
table_setup_scroll_freeze :: #force_inline proc(cols: i32, rows: i32)                                { igTableSetupScrollFreeze(cols, rows); }
get_columns_count         :: #force_inline proc() -> i32                                             { return igGetColumnsCount(); }
storage_get_float_ref     :: #force_inline proc(self: ^Storage, key: ImID, default_val := f32(0.0)) -> ^f32 { return ImGuiStorage_GetFloatRef(self, key, default_val); }

draw_data_de_index_all_buffers :: #force_inline proc(self: ^Draw_Data) { ImDrawData_DeIndexAllBuffers(self); }

input_float4               :: #force_inline proc(label: string, v: [4]f32, format := "%.3f", flags := Input_Text_Flags(0)) -> bool { return swr_igInputFloat4(label, v, format, flags); }
draw_list_path_clear       :: #force_inline proc(self: ^Draw_List)                                                            { ImDrawList_PathClear(self); }
draw_list_path_fill_convex :: #force_inline proc(self: ^Draw_List, col: u32)                                                  { ImDrawList_PathFillConvex(self, col); }

push_font                           :: #force_inline proc(font: ^ImFont)               { igPushFont(font); }
log_buttons                         :: #force_inline proc()                            { igLogButtons(); }
font_atlas_get_glyph_ranges_default :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar { return ImFontAtlas_GetGlyphRangesDefault(self); }

draw_list_path_line_to_merge_duplicate :: #force_inline proc(self: ^Draw_List, pos: Vec2) { ImDrawList_PathLineToMergeDuplicate(self, pos); }

is_window_hovered  :: #force_inline proc(flags := Hovered_Flags(0)) -> bool                                                                      { return igIsWindowHovered(flags); }
draw_list_add_rect :: #force_inline proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col: u32, rounding := f32(0.0), flags := Draw_Flags(0), thickness := f32(1.0)) { ImDrawList_AddRect(self, p_min, p_max, col, rounding, flags, thickness); }

input_int4                 :: #force_inline proc(label: string, v: [4]i32, flags := Input_Text_Flags(0)) -> bool { return swr_igInputInt4(label, v, flags); }
draw_data_scale_clip_rects :: #force_inline proc(self: ^Draw_Data, fb_scale: Vec2)                           { ImDrawData_ScaleClipRects(self, fb_scale); }

align_text_to_frame_padding :: #force_inline proc()               { igAlignTextToFramePadding(); }
storage_clear               :: #force_inline proc(self: ^Storage) { ImGuiStorage_Clear(self); }

draw_list_push_texture_id :: #force_inline proc(self: ^Draw_List, texture_id: Texture_ID) { ImDrawList_PushTextureID(self, texture_id); }

get_window_height           :: #force_inline proc() -> f32                           { return igGetWindowHeight(); }

set_scroll_from_pos_y :: proc {
	set_scroll_from_pos_y_float,
};
set_scroll_from_pos_y_float :: #force_inline proc(local_y: f32, center_y_ratio := f32(0.5)) { igSetScrollFromPosY_Float(local_y, center_y_ratio); }

draw_list_path_fill_concave :: #force_inline proc(self: ^Draw_List, col: u32)        { ImDrawList_PathFillConcave(self, col); }

get_frame_count                       :: #force_inline proc() -> i32                                                                     { return igGetFrameCount(); }
input_text_callback_data_insert_chars :: #force_inline proc(self: ^Input_Text_Callback_Data, pos: i32, text: string, text_end := "")     { swr_ImGuiInputTextCallbackData_InsertChars(self, pos, text, text_end); }

image_button :: #force_inline proc(str_id: string, user_texture_id: Texture_ID, image_size: Vec2, uv0 := Vec2(Vec2 {0,0}), uv1 := Vec2(Vec2 {1,1}), bg_col := Vec4(Vec4 {0,0,0,0}), tint_col := Vec4(Vec4 {1,1,1,1})) -> bool { return swr_igImageButton(str_id, user_texture_id, image_size, uv0, uv1, bg_col, tint_col); }
color_hsv    :: #force_inline proc(pOut: ^Color, h: f32, s: f32, v: f32, a := f32(1.0))                                                                        { ImColor_HSV(pOut, h, s, v, a); }

v_slider_int                :: #force_inline proc(label: string, size: Vec2, v: ^i32, v_min: i32, v_max: i32, format := "%d", flags := Slider_Flags(0)) -> bool                                                        { return swr_igVSliderInt(label, size, v, v_min, v_max, format, flags); }
table_get_sort_specs        :: #force_inline proc() -> ^Table_Sort_Specs                                                                                                                                               { return igTableGetSortSpecs(); }
begin_item_tooltip          :: #force_inline proc() -> bool                                                                                                                                                            { return igBeginItemTooltip(); }
input_int                   :: #force_inline proc(label: string, v: ^i32, step := i32(1), step_fast := i32(100), flags := Input_Text_Flags(0)) -> bool                                                                 { return swr_igInputInt(label, v, step, step_fast, flags); }
set_next_item_allow_overlap :: #force_inline proc()                                                                                                                                                                    { igSetNextItemAllowOverlap(); }
slider_float3               :: #force_inline proc(label: string, v: [3]f32, v_min: f32, v_max: f32, format := "%.3f", flags := Slider_Flags(0)) -> bool                                                                { return swr_igSliderFloat3(label, v, v_min, v_max, format, flags); }
table_set_column_index      :: #force_inline proc(column_n: i32) -> bool                                                                                                                                               { return igTableSetColumnIndex(column_n); }
debug_log                   :: #force_inline proc(fmt_: string, args: ..any)                                                                                                                                           { swr_igDebugLog(fmt_, args); }
font_render_text            :: #force_inline proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: Vec2, col: u32, clip_rect: Vec4, text_begin: string, text_end: string, wrap_width := f32(0.0), cpu_fine_clip := bool(false)) { swr_ImFont_RenderText(self, draw_list, size, pos, col, clip_rect, text_begin, text_end, wrap_width, cpu_fine_clip); }

draw_list_path_bezier_cubic_curve_to :: #force_inline proc(self: ^Draw_List, p2: Vec2, p3: Vec2, p4: Vec2, num_segments := i32(0)) { ImDrawList_PathBezierCubicCurveTo(self, p2, p3, p4, num_segments); }


table_get_column_name :: proc {
	table_get_column_name_int,
};
table_get_column_name_int :: #force_inline proc(column_n := i32(-1)) -> cstring                               { return igTableGetColumnName_Int(column_n); }

color_edit4               :: #force_inline proc(label: string, col: [4]f32, flags := Color_Edit_Flags(0)) -> bool { return swr_igColorEdit4(label, col, flags); }
draw_list_prim_rect       :: #force_inline proc(self: ^Draw_List, a: Vec2, b: Vec2, col: u32)                 { ImDrawList_PrimRect(self, a, b, col); }

io_clear_input_mouse :: #force_inline proc(self: ^IO) { ImGuiIO_ClearInputMouse(self); }

font_get_char_advance :: #force_inline proc(self: ^ImFont, c: Wchar) -> f32 { return ImFont_GetCharAdvance(self, c); }

pop_item_width           :: #force_inline proc()                                { igPopItemWidth(); }
draw_list_prim_write_idx :: #force_inline proc(self: ^Draw_List, idx: Draw_Idx) { ImDrawList_PrimWriteIdx(self, idx); }


tree_node :: proc {
	tree_node_str,
	tree_node_str_str,
	tree_node_ptr,
};
tree_node_str          :: #force_inline proc(label: string) -> bool                                         { return swr_igTreeNode_Str(label); }
tree_node_str_str      :: #force_inline proc(str_id: string, fmt_: string, args: ..any) -> bool             { return swr_igTreeNode_StrStr(str_id, fmt_, args); }
tree_node_ptr          :: #force_inline proc(ptr_id: rawptr, fmt_: string, args: ..any) -> bool             { return swr_igTreeNode_Ptr(ptr_id, fmt_, args); }

io_add_mouse_pos_event :: #force_inline proc(self: ^IO, x: f32, y: f32)                                     { ImGuiIO_AddMousePosEvent(self, x, y); }

draw_list_add_bezier_cubic :: #force_inline proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32, thickness: f32, num_segments := i32(0)) { ImDrawList_AddBezierCubic(self, p1, p2, p3, p4, col, thickness, num_segments); }

end_popup                 :: #force_inline proc()                                                                                          { igEndPopup(); }

begin_child :: proc {
	begin_child_str,
	begin_child_id,
};
begin_child_str           :: #force_inline proc(str_id: string, size := Vec2(Vec2 {0,0}), child_flags := Child_Flags(0), window_flags := Window_Flags(0)) -> bool { return swr_igBeginChild_Str(str_id, size, child_flags, window_flags); }
begin_child_id            :: #force_inline proc(id: ImID, size := Vec2(Vec2 {0,0}), child_flags := Child_Flags(0), window_flags := Window_Flags(0)) -> bool { return igBeginChild_ID(id, size, child_flags, window_flags); }

table_get_column_flags    :: #force_inline proc(column_n := i32(-1)) -> Table_Column_Flags                                                 { return igTableGetColumnFlags(column_n); }
get_draw_list_shared_data :: #force_inline proc() -> ^Draw_List_Shared_Data                                                                { return igGetDrawListSharedData(); }
log_text                  :: #force_inline proc(fmt_: string, args: ..any)                                                                 { swr_igLogText(fmt_, args); }
input_int3                :: #force_inline proc(label: string, v: [3]i32, flags := Input_Text_Flags(0)) -> bool                            { return swr_igInputInt3(label, v, flags); }
text_buffer_size          :: #force_inline proc(self: ^Text_Buffer) -> i32                                                                 { return ImGuiTextBuffer_size(self); }


plot_histogram :: proc {
	plot_histogram_float_ptr,
	plot_histogram_fn_float_ptr,
};
plot_histogram_float_ptr      :: #force_inline proc(label: string, values: ^f32, values_count: i32, values_offset := i32(0), overlay_text := "", scale_min := f32(max(f32)), scale_max := f32(max(f32)), graph_size := Vec2(Vec2 {0,0}), stride := i32(size_of(f32))) { swr_igPlotHistogram_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride); }
plot_histogram_fn_float_ptr   :: #force_inline proc(label: string, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: string, scale_min: f32, scale_max: f32, graph_size: Vec2) { wrapper_plot_histogram_fn_float_ptr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size); }

get_mouse_drag_delta          :: #force_inline proc(pOut: ^Vec2, button := Mouse_Button(0), lock_threshold := f32(-1.0))                                                                                                   { igGetMouseDragDelta(pOut, button, lock_threshold); }
table_next_column             :: #force_inline proc() -> bool                                                                                                                                                              { return igTableNextColumn(); }
get_cursor_pos_y              :: #force_inline proc() -> f32                                                                                                                                                               { return igGetCursorPosY(); }
begin_multi_select            :: #force_inline proc(flags: Multi_Select_Flags, selection_size := i32(-1), items_count := i32(-1)) -> ^Multi_Select_Io                                                                      { return igBeginMultiSelect(flags, selection_size, items_count); }
invisible_button              :: #force_inline proc(str_id: string, size: Vec2, flags := Button_Flags(0)) -> bool                                                                                                          { return swr_igInvisibleButton(str_id, size, flags); }
draw_list_add_triangle_filled :: #force_inline proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32)                                                                                                              { ImDrawList_AddTriangleFilled(self, p1, p2, p3, col); }
draw_list_add_ngon_filled     :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32)                                                                                              { ImDrawList_AddNgonFilled(self, center, radius, col, num_segments); }

font_atlas_add_custom_rect_regular :: #force_inline proc(self: ^Font_Atlas, width: i32, height: i32) -> i32 { return ImFontAtlas_AddCustomRectRegular(self, width, height); }

get_draw_data       :: #force_inline proc() -> ^Draw_Data                                                                                                { return igGetDrawData(); }
table_header        :: #force_inline proc(label: string)                                                                                                 { swr_igTableHeader(label); }
drag_float2         :: #force_inline proc(label: string, v: [2]f32, v_speed := f32(1.0), v_min := f32(0.0), v_max := f32(0.0), format := "%.3f", flags := Slider_Flags(0)) -> bool { return swr_igDragFloat2(label, v, v_speed, v_min, v_max, format, flags); }
io_clear_input_keys :: #force_inline proc(self: ^IO)                                                                                                     { ImGuiIO_ClearInputKeys(self); }

draw_list_add_rect_filled_multi_color :: #force_inline proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col_upr_left: u32, col_upr_right: u32, col_bot_right: u32, col_bot_left: u32) { ImDrawList_AddRectFilledMultiColor(self, p_min, p_max, col_upr_left, col_upr_right, col_bot_right, col_bot_left); }

tree_pop               :: #force_inline proc()                                                                                                            { igTreePop(); }
drag_float             :: #force_inline proc(label: string, v: ^f32, v_speed := f32(1.0), v_min := f32(0.0), v_max := f32(0.0), format := "%.3f", flags := Slider_Flags(0)) -> bool { return swr_igDragFloat(label, v, v_speed, v_min, v_max, format, flags); }
draw_list_add_callback :: #force_inline proc(self: ^Draw_List, callback: Draw_Callback, callback_data: rawptr)                                            { ImDrawList_AddCallback(self, callback, callback_data); }

get_window_pos           :: #force_inline proc() -> Vec2                                                  { return wrapper_get_window_pos(); }
storage_get_void_ptr_ref :: #force_inline proc(self: ^Storage, key: ImID, default_val : rawptr = nil) -> ^rawptr { return ImGuiStorage_GetVoidPtrRef(self, key, default_val); }

selection_basic_storage_clear :: #force_inline proc(self: ^Selection_Basic_Storage) { ImGuiSelectionBasicStorage_Clear(self); }


selectable :: proc {
	selectable_bool,
	selectable_bool_ptr,
};
selectable_bool     :: #force_inline proc(label: string, selected := bool(false), flags := Selectable_Flags(0), size := Vec2(Vec2 {0,0})) -> bool { return swr_igSelectable_Bool(label, selected, flags, size); }
selectable_bool_ptr :: #force_inline proc(label: string, p_selected: ^bool, flags := Selectable_Flags(0), size := Vec2(Vec2 {0,0})) -> bool { return swr_igSelectable_BoolPtr(label, p_selected, flags, size); }

push_style_var_y    :: #force_inline proc(idx: Style_Var, val_y: f32)                                                     { igPushStyleVarY(idx, val_y); }
text_unformatted    :: #force_inline proc(text: string)                                                                   { wrapper_unformatted_text(text); }
viewport_get_center :: #force_inline proc(pOut: ^Vec2, self: ^Viewport)                                                   { ImGuiViewport_GetCenter(pOut, self); }

set_drag_drop_payload    :: #force_inline proc(type: string, data: rawptr, sz: uint, cond := Cond(0)) -> bool                                                 { return swr_igSetDragDropPayload(type, data, sz, cond); }
is_any_item_active       :: #force_inline proc() -> bool                                                                                                      { return igIsAnyItemActive(); }
is_window_appearing      :: #force_inline proc() -> bool                                                                                                      { return igIsWindowAppearing(); }
drag_int4                :: #force_inline proc(label: string, v: [4]i32, v_speed := f32(1.0), v_min := i32(0), v_max := i32(0), format := "%d", flags := Slider_Flags(0)) -> bool { return swr_igDragInt4(label, v, v_speed, v_min, v_max, format, flags); }
draw_list_splitter_split :: #force_inline proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, count: i32)                                                  { ImDrawListSplitter_Split(self, draw_list, count); }

draw_list_prim_rect_uv :: #force_inline proc(self: ^Draw_List, a: Vec2, b: Vec2, uv_a: Vec2, uv_b: Vec2, col: u32) { ImDrawList_PrimRectUV(self, a, b, uv_a, uv_b, col); }


is_key_released :: proc {
	is_key_released_nil,
};
is_key_released_nil          :: #force_inline proc(key: Key) -> bool                                                                                { return igIsKeyReleased_Nil(key); }


shortcut :: proc {
	shortcut_nil,
};
shortcut_nil                 :: #force_inline proc(key_chord: Key_Chord, flags := Input_Flags(0)) -> bool                                           { return igShortcut_Nil(key_chord, flags); }

slider_int2                  :: #force_inline proc(label: string, v: [2]i32, v_min: i32, v_max: i32, format := "%d", flags := Slider_Flags(0)) -> bool { return swr_igSliderInt2(label, v, v_min, v_max, format, flags); }
set_next_window_content_size :: #force_inline proc(size: Vec2)                                                                                      { igSetNextWindowContentSize(size); }
draw_list_add_circle_filled  :: #force_inline proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments := i32(0))                   { ImDrawList_AddCircleFilled(self, center, radius, col, num_segments); }

font_find_glyph_no_fallback :: #force_inline proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph { return ImFont_FindGlyphNoFallback(self, c); }

draw_list_push_clip_rect_full_screen :: #force_inline proc(self: ^Draw_List)                                                   { ImDrawList_PushClipRectFullScreen(self); }
draw_list_add_quad_filled            :: #force_inline proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32) { ImDrawList_AddQuadFilled(self, p1, p2, p3, p4, col); }

list_clipper_include_items_by_index :: #force_inline proc(self: ^List_Clipper, item_begin: i32, item_end: i32) { ImGuiListClipper_IncludeItemsByIndex(self, item_begin, item_end); }

set_next_window_collapsed   :: #force_inline proc(collapsed: bool, cond := Cond(0)) { igSetNextWindowCollapsed(collapsed, cond); }
draw_list_clear_free_memory :: #force_inline proc(self: ^Draw_List)            { ImDrawList__ClearFreeMemory(self); }

get_io              :: #force_inline proc() -> ^IO                                                                        { return igGetIO(); }
set_tab_item_closed :: #force_inline proc(tab_or_docked_window_label: string)                                             { swr_igSetTabItemClosed(tab_or_docked_window_label); }
font_render_char    :: #force_inline proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: Vec2, col: u32, c: Wchar) { ImFont_RenderChar(self, draw_list, size, pos, col, c); }

font_atlas_get_glyph_ranges_greek :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar { return ImFontAtlas_GetGlyphRangesGreek(self); }

get_mouse_pos_on_opening_current_popup                :: #force_inline proc(pOut: ^Vec2)                 { igGetMousePosOnOpeningCurrentPopup(pOut); }
font_atlas_get_glyph_ranges_chinese_simplified_common :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar { return ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(self); }
font_atlas_get_glyph_ranges_thai                      :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar { return ImFontAtlas_GetGlyphRangesThai(self); }

slider_scalar_n   :: #force_inline proc(label: string, data_type: Data_Type, p_data: rawptr, components: i32, p_min: rawptr, p_max: rawptr, format := "", flags := Slider_Flags(0)) -> bool { return swr_igSliderScalarN(label, data_type, p_data, components, p_min, p_max, format, flags); }
text_buffer_empty :: #force_inline proc(self: ^Text_Buffer) -> bool                                                                                                                        { return ImGuiTextBuffer_empty(self); }

draw_list_pop_texture_id :: #force_inline proc(self: ^Draw_List) { ImDrawList_PopTextureID(self); }

text_buffer_clear :: #force_inline proc(self: ^Text_Buffer) { ImGuiTextBuffer_clear(self); }

font_add_glyph :: #force_inline proc(self: ^ImFont, src_cfg: ^Font_Config, c: Wchar, x0: f32, y0: f32, x1: f32, y1: f32, u0: f32, v0: f32, u1: f32, v1: f32, advance_x: f32) { ImFont_AddGlyph(self, src_cfg, c, x0, y0, x1, y1, u0, v0, u1, v1, advance_x); }

font_atlas_build :: #force_inline proc(self: ^Font_Atlas) -> bool { return ImFontAtlas_Build(self); }

get_state_storage        :: #force_inline proc() -> ^Storage     { return igGetStateStorage(); }
draw_list_channels_merge :: #force_inline proc(self: ^Draw_List) { ImDrawList_ChannelsMerge(self); }

save_ini_settings_to_disk   :: #force_inline proc(ini_filename: string)                                                                   { swr_igSaveIniSettingsToDisk(ini_filename); }
save_ini_settings_to_memory :: #force_inline proc(out_ini_size : ^uint = nil) -> cstring                                                  { return igSaveIniSettingsToMemory(out_ini_size); }
draw_list_add_rect_filled   :: #force_inline proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col: u32, rounding := f32(0.0), flags := Draw_Flags(0)) { ImDrawList_AddRectFilled(self, p_min, p_max, col, rounding, flags); }

font_glyph_ranges_builder_clear :: #force_inline proc(self: ^Font_Glyph_Ranges_Builder) { ImFontGlyphRangesBuilder_Clear(self); }

table_angled_headers_row :: #force_inline proc()                                                { igTableAngledHeadersRow(); }
dummy                    :: #force_inline proc(size: Vec2)                                      { igDummy(size); }
progress_bar             :: #force_inline proc(fraction: f32, size_arg := Vec2(Vec2 {-min(f32),0}), overlay := "") { swr_igProgressBar(fraction, size_arg, overlay); }
arrow_button             :: #force_inline proc(str_id: string, dir: Dir) -> bool                { return swr_igArrowButton(str_id, dir); }
storage_get_void_ptr     :: #force_inline proc(self: ^Storage, key: ImID) -> rawptr             { return ImGuiStorage_GetVoidPtr(self, key); }

font_is_glyph_range_unused :: #force_inline proc(self: ^ImFont, c_begin: u32, c_last: u32) -> bool { return ImFont_IsGlyphRangeUnused(self, c_begin, c_last); }

text                                   :: #force_inline proc(fmt_: string, args: ..any)               { wrapper_text(fmt_, ..args); }
input_text_callback_data_has_selection :: #force_inline proc(self: ^Input_Text_Callback_Data) -> bool { return ImGuiInputTextCallbackData_HasSelection(self); }

draw_list_prim_vtx :: #force_inline proc(self: ^Draw_List, pos: Vec2, uv: Vec2, col: u32) { ImDrawList_PrimVtx(self, pos, uv, col); }

color_picker4       :: #force_inline proc(label: string, col: [4]f32, flags := Color_Edit_Flags(0), ref_col : ^f32 = nil) -> bool { return swr_igColorPicker4(label, col, flags, ref_col); }
text_buffer_reserve :: #force_inline proc(self: ^Text_Buffer, capacity: i32)                                           { ImGuiTextBuffer_reserve(self, capacity); }

draw_list_splitter_merge :: #force_inline proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List) { ImDrawListSplitter_Merge(self, draw_list); }

storage_get_bool :: #force_inline proc(self: ^Storage, key: ImID, default_val := bool(false)) -> bool { return ImGuiStorage_GetBool(self, key, default_val); }

style_colors_dark                    :: #force_inline proc(dst : ^Style = nil)                   { igStyleColorsDark(dst); }
set_item_tooltip                     :: #force_inline proc(fmt_: string, args: ..any)            { swr_igSetItemTooltip(fmt_, args); }
table_get_row_index                  :: #force_inline proc() -> i32                              { return igTableGetRowIndex(); }
end_tab_item                         :: #force_inline proc()                                     { igEndTabItem(); }
font_atlas_get_glyph_ranges_japanese :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar          { return ImFontAtlas_GetGlyphRangesJapanese(self); }

begin_disabled     :: #force_inline proc(disabled := bool(true))                             { igBeginDisabled(disabled); }
text_buffer_append :: #force_inline proc(self: ^Text_Buffer, str: string, str_end := "")     { swr_ImGuiTextBuffer_append(self, str, str_end); }

small_button             :: #force_inline proc(label: string) -> bool                                                                              { return swr_igSmallButton(label); }
begin_drag_drop_source   :: #force_inline proc(flags := Drag_Drop_Flags(0)) -> bool                                                                { return igBeginDragDropSource(flags); }
text_disabled            :: #force_inline proc(fmt_: string, args: ..any)                                                                          { wrapper_text_disabled(fmt_, ..args); }
draw_list_clone_output   :: #force_inline proc(self: ^Draw_List) -> ^Draw_List                                                                     { return ImDrawList_CloneOutput(self); }
draw_list_push_clip_rect :: #force_inline proc(self: ^Draw_List, clip_rect_min: Vec2, clip_rect_max: Vec2, intersect_with_current_clip_rect := bool(false)) { ImDrawList_PushClipRect(self, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect); }


set_scroll_from_pos_x :: proc {
	set_scroll_from_pos_x_float,
};
set_scroll_from_pos_x_float :: #force_inline proc(local_x: f32, center_x_ratio := f32(0.5))     { igSetScrollFromPosX_Float(local_x, center_x_ratio); }

pop_item_flag               :: #force_inline proc()                                             { igPopItemFlag(); }
is_mouse_hovering_rect      :: #force_inline proc(r_min: Vec2, r_max: Vec2, clip := bool(true)) -> bool { return igIsMouseHoveringRect(r_min, r_max, clip); }
viewport_get_work_center    :: #force_inline proc(pOut: ^Vec2, self: ^Viewport)                 { ImGuiViewport_GetWorkCenter(pOut, self); }

draw_cmd_get_tex_id :: #force_inline proc(self: ^Draw_Cmd) -> Texture_ID { return ImDrawCmd_GetTexID(self); }

text_buffer_c_str :: #force_inline proc(self: ^Text_Buffer) -> cstring { return ImGuiTextBuffer_c_str(self); }

set_next_item_width         :: #force_inline proc(item_width: f32)                                                                                 { igSetNextItemWidth(item_width); }
create_context              :: #force_inline proc(shared_font_atlas : ^Font_Atlas = nil) -> ^Context                                               { return igCreateContext(shared_font_atlas); }
pop_id                      :: #force_inline proc()                                                                                                { igPopID(); }

is_mouse_released :: proc {
	is_mouse_released_nil,
};
is_mouse_released_nil       :: #force_inline proc(button: Mouse_Button) -> bool                                                                    { return igIsMouseReleased_Nil(button); }

set_next_window_scroll      :: #force_inline proc(scroll: Vec2)                                                                                    { igSetNextWindowScroll(scroll); }
slider_float2               :: #force_inline proc(label: string, v: [2]f32, v_min: f32, v_max: f32, format := "%.3f", flags := Slider_Flags(0)) -> bool { return swr_igSliderFloat2(label, v, v_min, v_max, format, flags); }
begin_drag_drop_target      :: #force_inline proc() -> bool                                                                                        { return igBeginDragDropTarget(); }

tree_push :: proc {
	tree_push_str,
	tree_push_ptr,
};
tree_push_str               :: #force_inline proc(str_id: string)                                                                                  { swr_igTreePush_Str(str_id); }
tree_push_ptr               :: #force_inline proc(ptr_id: rawptr)                                                                                  { igTreePush_Ptr(ptr_id); }

end_child                   :: #force_inline proc()                                                                                                { igEndChild(); }
destroy_context             :: #force_inline proc(ctx : ^Context = nil)                                                                            { igDestroyContext(ctx); }
font_atlas_clear_input_data :: #force_inline proc(self: ^Font_Atlas)                                                                               { ImFontAtlas_ClearInputData(self); }

draw_list_add_triangle :: #force_inline proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32, thickness := f32(1.0)) { ImDrawList_AddTriangle(self, p1, p2, p3, col, thickness); }

end_list_box                           :: #force_inline proc()                                                                { igEndListBox(); }
get_font_size                          :: #force_inline proc() -> f32                                                         { return igGetFontSize(); }
font_glyph_ranges_builder_build_ranges :: #force_inline proc(self: ^Font_Glyph_Ranges_Builder, out_ranges: ^Im_Vector(Wchar)) { ImFontGlyphRangesBuilder_BuildRanges(self, out_ranges); }


plot_lines :: proc {
	plot_lines_float_ptr,
	plot_lines_fn_float_ptr,
};
plot_lines_float_ptr                     :: #force_inline proc(label: string, values: ^f32, values_count: i32, values_offset := i32(0), overlay_text := "", scale_min := f32(max(f32)), scale_max := f32(max(f32)), graph_size := Vec2(Vec2 {0,0}), stride := i32(size_of(f32))) { swr_igPlotLines_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride); }
plot_lines_fn_float_ptr                  :: #force_inline proc(label: string, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: string, scale_min: f32, scale_max: f32, graph_size: Vec2) { wrapper_plot_lines_fn_float_ptr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size); }

show_style_editor                        :: #force_inline proc(ref : ^Style = nil)                                                                                                                                                    { igShowStyleEditor(ref); }
accept_drag_drop_payload                 :: #force_inline proc(type: string, flags := Drag_Drop_Flags(0)) -> ^Payload                                                                                                                 { return swr_igAcceptDragDropPayload(type, flags); }
draw_list_path_bezier_quadratic_curve_to :: #force_inline proc(self: ^Draw_List, p2: Vec2, p3: Vec2, num_segments := i32(0))                                                                                                          { ImDrawList_PathBezierQuadraticCurveTo(self, p2, p3, num_segments); }


combo :: proc {
	combo_str_arr,
	combo_str,
	combo_fn_str_ptr,
};
combo_str_arr     :: #force_inline proc(label: string, current_item: ^i32, items: []string, popup_max_height_in_items := i32(0)) -> bool                                    { return wrapper_combo_str_arr(label, current_item, items, popup_max_height_in_items); }
combo_str         :: #force_inline proc(label: string, current_item: ^i32, items_separated_by_zeros: string, popup_max_height_in_items := i32(-1)) -> bool                  { return swr_igCombo_Str(label, current_item, items_separated_by_zeros, popup_max_height_in_items); }
combo_fn_str_ptr  :: #force_inline proc(label: string, current_item: ^i32, getter: ^^cstring, user_data: rawptr, items_count: i32, popup_max_height_in_items := i32(-1)) -> bool { return swr_igCombo_FnStrPtr(label, current_item, getter, user_data, items_count, popup_max_height_in_items); }

color_picker3     :: #force_inline proc(label: string, col: [3]f32, flags := Color_Edit_Flags(0)) -> bool                                                                   { return swr_igColorPicker3(label, col, flags); }
text_filter_build :: #force_inline proc(self: ^Text_Filter)                                                                                                                 { ImGuiTextFilter_Build(self); }

begin_main_menu_bar              :: #force_inline proc() -> bool                                                   { return igBeginMainMenuBar(); }
get_style                        :: #force_inline proc() -> ^Style                                                 { return igGetStyle(); }
get_window_size                  :: #force_inline proc() -> Vec2                                                   { return wrapper_get_window_size(); }
set_cursor_screen_pos            :: #force_inline proc(pos: Vec2)                                                  { igSetCursorScreenPos(pos); }

set_window_focus :: proc {
	set_window_focus_nil,
	set_window_focus_str,
};
set_window_focus_nil             :: #force_inline proc()                                                           { igSetWindowFocus_Nil(); }
set_window_focus_str             :: #force_inline proc(name: string)                                               { swr_igSetWindowFocus_Str(name); }

input_int2                       :: #force_inline proc(label: string, v: [2]i32, flags := Input_Text_Flags(0)) -> bool { return swr_igInputInt2(label, v, flags); }
end_disabled                     :: #force_inline proc()                                                           { igEndDisabled(); }
selection_basic_storage_contains :: #force_inline proc(self: ^Selection_Basic_Storage, id: ImID) -> bool           { return ImGuiSelectionBasicStorage_Contains(self, id); }

show_user_guide                 :: #force_inline proc()                             { igShowUserGuide(); }
get_mouse_pos                   :: #force_inline proc(pOut: ^Vec2)                  { igGetMousePos(pOut); }
text_link_open_url              :: #force_inline proc(label: string, url := "")     { swr_igTextLinkOpenURL(label, url); }
draw_list_on_changed_texture_id :: #force_inline proc(self: ^Draw_List)             { ImDrawList__OnChangedTextureID(self); }
draw_list_channels_split        :: #force_inline proc(self: ^Draw_List, count: i32) { ImDrawList_ChannelsSplit(self, count); }

table_get_column_index            :: #force_inline proc() -> i32                                                                                                       { return igTableGetColumnIndex(); }
is_any_item_focused               :: #force_inline proc() -> bool                                                                                                      { return igIsAnyItemFocused(); }
get_key_pressed_amount            :: #force_inline proc(key: Key, repeat_delay: f32, rate: f32) -> i32                                                                 { return igGetKeyPressedAmount(key, repeat_delay, rate); }
v_slider_float                    :: #force_inline proc(label: string, size: Vec2, v: ^f32, v_min: f32, v_max: f32, format := "%.3f", flags := Slider_Flags(0)) -> bool { return swr_igVSliderFloat(label, size, v, v_min, v_max, format, flags); }
get_frame_height                  :: #force_inline proc() -> f32                                                                                                       { return igGetFrameHeight(); }
drag_float3                       :: #force_inline proc(label: string, v: [3]f32, v_speed := f32(1.0), v_min := f32(0.0), v_max := f32(0.0), format := "%.3f", flags := Slider_Flags(0)) -> bool { return swr_igDragFloat3(label, v, v_speed, v_min, v_max, format, flags); }
get_item_rect_size                :: #force_inline proc(pOut: ^Vec2)                                                                                                   { igGetItemRectSize(pOut); }
get_content_region_avail          :: #force_inline proc(pOut: ^Vec2)                                                                                                   { igGetContentRegionAvail(pOut); }
font_glyph_ranges_builder_set_bit :: #force_inline proc(self: ^Font_Glyph_Ranges_Builder, n: uint)                                                                     { ImFontGlyphRangesBuilder_SetBit(self, n); }

font_atlas_add_font_default :: #force_inline proc(self: ^Font_Atlas, font_cfg : ^Font_Config = nil) -> ^ImFont { return ImFontAtlas_AddFontDefault(self, font_cfg); }

get_frame_height_with_spacing            :: #force_inline proc() -> f32                     { return igGetFrameHeightWithSpacing(); }
set_mouse_cursor                         :: #force_inline proc(cursor_type: Mouse_Cursor)   { igSetMouseCursor(cursor_type); }
font_atlas_get_glyph_ranges_chinese_full :: #force_inline proc(self: ^Font_Atlas) -> ^Wchar { return ImFontAtlas_GetGlyphRangesChineseFull(self); }

draw_list_splitter_clear :: #force_inline proc(self: ^Draw_List_Splitter) { ImDrawListSplitter_Clear(self); }

font_set_glyph_visible :: #force_inline proc(self: ^ImFont, c: Wchar, visible: bool) { ImFont_SetGlyphVisible(self, c, visible); }

storage_set_all_int :: #force_inline proc(self: ^Storage, val: i32) { ImGuiStorage_SetAllInt(self, val); }


set_window_pos :: proc {
	set_window_pos_vec2,
	set_window_pos_str,
};
set_window_pos_vec2                  :: #force_inline proc(pos: Vec2, cond := Cond(0))                                                                                                                                        { igSetWindowPos_Vec2(pos, cond); }
set_window_pos_str                   :: #force_inline proc(name: string, pos: Vec2, cond := Cond(0))                                                                                                                          { swr_igSetWindowPos_Str(name, pos, cond); }

slider_int3                          :: #force_inline proc(label: string, v: [3]i32, v_min: i32, v_max: i32, format := "%d", flags := Slider_Flags(0)) -> bool                                                                { return swr_igSliderInt3(label, v, v_min, v_max, format, flags); }

is_popup_open :: proc {
	is_popup_open_str,
};
is_popup_open_str                    :: #force_inline proc(str_id: string, flags := Popup_Flags(0)) -> bool                                                                                                                   { return swr_igIsPopupOpen_Str(str_id, flags); }

begin                                :: #force_inline proc(name: string, p_open : ^bool = nil, flags := Window_Flags(0)) -> bool                                                                                              { return swr_igBegin(name, p_open, flags); }
text_colored                         :: #force_inline proc(col: Vec4, fmt_: string, args: ..any)                                                                                                                              { wrapper_text_colored(col, fmt_, ..args); }
is_any_item_hovered                  :: #force_inline proc() -> bool                                                                                                                                                          { return igIsAnyItemHovered(); }
is_window_collapsed                  :: #force_inline proc() -> bool                                                                                                                                                          { return igIsWindowCollapsed(); }
get_column_index                     :: #force_inline proc() -> i32                                                                                                                                                           { return igGetColumnIndex(); }
drag_float_range2                    :: #force_inline proc(label: string, v_current_min: ^f32, v_current_max: ^f32, v_speed := f32(1.0), v_min := f32(0.0), v_max := f32(0.0), format := "%.3f", format_max := "", flags := Slider_Flags(0)) -> bool { return swr_igDragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags); }
get_time                             :: #force_inline proc() -> f64                                                                                                                                                           { return igGetTime(); }
font_atlas_get_mouse_cursor_tex_data :: #force_inline proc(self: ^Font_Atlas, cursor: Mouse_Cursor, out_offset: ^Vec2, out_size: ^Vec2, out_uv_border: [2]Vec2, out_uv_fill: [2]Vec2) -> bool                                 { return ImFontAtlas_GetMouseCursorTexData(self, cursor, out_offset, out_size, out_uv_border, out_uv_fill); }

font_glyph_ranges_builder_add_ranges :: #force_inline proc(self: ^Font_Glyph_Ranges_Builder, ranges: ^Wchar) { ImFontGlyphRangesBuilder_AddRanges(self, ranges); }

set_window_font_scale       :: #force_inline proc(scale: f32)                        { igSetWindowFontScale(scale); }
mem_free                    :: #force_inline proc(ptr: rawptr)                       { igMemFree(ptr); }
bullet                      :: #force_inline proc()                                  { igBullet(); }
io_set_app_accepting_events :: #force_inline proc(self: ^IO, accepting_events: bool) { ImGuiIO_SetAppAcceptingEvents(self, accepting_events); }

storage_get_bool_ref :: #force_inline proc(self: ^Storage, key: ImID, default_val := bool(false)) -> ^bool { return ImGuiStorage_GetBoolRef(self, key, default_val); }

draw_list_add_convex_poly_filled :: #force_inline proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32) { ImDrawList_AddConvexPolyFilled(self, points, num_points, col); }

input_text_with_hint             :: #force_inline proc(label: string, hint: string, buf: string, buf_size: uint, flags := Input_Text_Flags(0), callback : Input_Text_Callback = nil, user_data : rawptr = nil) -> bool { return swr_igInputTextWithHint(label, hint, buf, buf_size, flags, callback, user_data); }
set_next_window_size_constraints :: #force_inline proc(size_min: Vec2, size_max: Vec2, custom_callback : Size_Callback = nil, custom_callback_data : rawptr = nil)                                     { igSetNextWindowSizeConstraints(size_min, size_max, custom_callback, custom_callback_data); }
label_text                       :: #force_inline proc(label: string, fmt_: string, args: ..any)                                                                                                       { swr_igLabelText(label, fmt_, args); }
log_to_clipboard                 :: #force_inline proc(auto_open_depth := i32(-1))                                                                                                                     { igLogToClipboard(auto_open_depth); }
io_add_mouse_button_event        :: #force_inline proc(self: ^IO, button: i32, down: bool)                                                                                                             { ImGuiIO_AddMouseButtonEvent(self, button, down); }

get_column_width    :: #force_inline proc(column_index := i32(-1)) -> f32                                                     { return igGetColumnWidth(column_index); }
draw_list_path_rect :: #force_inline proc(self: ^Draw_List, rect_min: Vec2, rect_max: Vec2, rounding := f32(0.0), flags := Draw_Flags(0)) { ImDrawList_PathRect(self, rect_min, rect_max, rounding, flags); }

text_filter_is_active :: #force_inline proc(self: ^Text_Filter) -> bool { return ImGuiTextFilter_IsActive(self); }


open_popup :: proc {
	open_popup_str,
	open_popup_id,
};
open_popup_str                       :: #force_inline proc(str_id: string, popup_flags := Popup_Flags(0))     { swr_igOpenPopup_Str(str_id, popup_flags); }
open_popup_id                        :: #force_inline proc(id: ImID, popup_flags := Popup_Flags(0))           { igOpenPopup_ID(id, popup_flags); }

is_mouse_dragging                    :: #force_inline proc(button: Mouse_Button, lock_threshold := f32(-1.0)) -> bool { return igIsMouseDragging(button, lock_threshold); }
color_convert_u32to_float4           :: #force_inline proc(pOut: ^Vec4, in_: u32)                             { igColorConvertU32ToFloat4(pOut, in_); }
close_current_popup                  :: #force_inline proc()                                                  { igCloseCurrentPopup(); }
is_any_mouse_down                    :: #force_inline proc() -> bool                                          { return igIsAnyMouseDown(); }
set_current_context                  :: #force_inline proc(ctx: ^Context)                                     { igSetCurrentContext(ctx); }
set_next_frame_want_capture_keyboard :: #force_inline proc(want_capture_keyboard: bool)                       { igSetNextFrameWantCaptureKeyboard(want_capture_keyboard); }
io_add_mouse_wheel_event             :: #force_inline proc(self: ^IO, wheel_x: f32, wheel_y: f32)             { ImGuiIO_AddMouseWheelEvent(self, wheel_x, wheel_y); }

end                   :: #force_inline proc()          { igEnd(); }
io_clear_events_queue :: #force_inline proc(self: ^IO) { ImGuiIO_ClearEventsQueue(self); }

input_float2      :: #force_inline proc(label: string, v: [2]f32, format := "%.3f", flags := Input_Text_Flags(0)) -> bool { return swr_igInputFloat2(label, v, format, flags); }
storage_set_float :: #force_inline proc(self: ^Storage, key: ImID, val: f32)                                         { ImGuiStorage_SetFloat(self, key, val); }

set_clipboard_text :: #force_inline proc(text: string)  { swr_igSetClipboardText(text); }

