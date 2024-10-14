package imgui;

when ODIN_DEBUG {
	foreign import cimgui "external/cimgui_debug.lib";
} else {
	foreign import cimgui "external/cimgui.lib";
}

@(default_calling_convention="c")
foreign cimgui {
	igDragFloat3        :: proc(label: cstring, v: [3]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImGuiIO_AddKeyEvent :: proc(self: ^IO, key: Key, down: bool) ---;

	igDragIntRange2                    :: proc(label: cstring, v_current_min: ^i32, v_current_max: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, format_max: cstring, flags: Slider_Flags) -> bool ---;
	igColorButton                      :: proc(desc_id: cstring, col: Vec4, flags: Color_Edit_Flags, size: Vec2) -> bool ---;
	igIsMouseClicked_Bool              :: proc(button: Mouse_Button, repeat: bool) -> bool ---;
	ImFontGlyphRangesBuilder_AddRanges :: proc(self: ^Font_Glyph_Ranges_Builder, ranges: ^Wchar) ---;

	ImGuiTextBuffer_append :: proc(self: ^Text_Buffer, str: cstring, str_end: cstring) ---;

	igBeginPopupContextVoid              :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	igInputScalarN                       :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igTextUnformatted                    :: proc(text: cstring, text_end: cstring) ---;
	igGetKeyName                         :: proc(key: Key) -> cstring ---;
	ImDrawListSplitter_SetCurrentChannel :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, channel_idx: i32) ---;

	igGetStyleColorName          :: proc(idx: Col) -> cstring ---;
	igSetScrollY_Float           :: proc(scroll_y: f32) ---;
	igCheckboxFlags_IntPtr       :: proc(label: cstring, flags: ^i32, flags_value: i32) -> bool ---;
	igCheckboxFlags_UintPtr      :: proc(label: cstring, flags: ^u32, flags_value: u32) -> bool ---;
	igSliderInt4                 :: proc(label: cstring, v: [4]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragScalar                 :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igInputText                  :: proc(label: cstring, buf: cstring, buf_size: uint, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	ImDrawData_DeIndexAllBuffers :: proc(self: ^Draw_Data) ---;

	ImDrawList__PathArcToFastEx :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min_sample: i32, a_max_sample: i32, a_step: i32) ---;
	ImDrawList_PathLineTo       :: proc(self: ^Draw_List, pos: Vec2) ---;

	ImFont_AddRemapChar :: proc(self: ^ImFont, dst: Wchar, src: Wchar, overwrite_dst: bool) ---;

	igSetWindowFocus_Nil   :: proc() ---;
	igSetWindowFocus_Str   :: proc(name: cstring) ---;
	igTreeNode_Str         :: proc(label: cstring) -> bool ---;
	igTreeNode_StrStr      :: proc(str_id: cstring, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreeNode_Ptr         :: proc(ptr_id: rawptr, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igGetScrollMaxY        :: proc() -> f32 ---;
	ImGuiStorage_GetIntRef :: proc(self: ^Storage, key: ImID, default_val: i32) -> ^i32 ---;

	igColorConvertU32ToFloat4 :: proc(pOut: ^Vec4, in_: u32) ---;
	ImGuiIO_ClearEventsQueue  :: proc(self: ^IO) ---;

	ImGuiTextRange_split :: proc(self: ^Text_Range, separator: i8, out: ^Im_Vector(Text_Range)) ---;

	igIsItemDeactivatedAfterEdit    :: proc() -> bool ---;
	igSaveIniSettingsToDisk         :: proc(ini_filename: cstring) ---;
	igLoadIniSettingsFromMemory     :: proc(ini_data: cstring, ini_size: uint) ---;
	igGetMouseCursor                :: proc() -> Mouse_Cursor ---;
	igPopItemWidth                  :: proc() ---;
	igInputInt4                     :: proc(label: cstring, v: [4]i32, flags: Input_Text_Flags) -> bool ---;
	igGetMainViewport               :: proc() -> ^Viewport ---;
	ImFontGlyphRangesBuilder_SetBit :: proc(self: ^Font_Glyph_Ranges_Builder, n: uint) ---;

	ImGuiIO_AddFocusEvent :: proc(self: ^IO, focused: bool) ---;

	igStyleColorsLight    :: proc(dst: ^Style) ---;
	ImDrawList_PathStroke :: proc(self: ^Draw_List, col: u32, flags: Draw_Flags, thickness: f32) ---;

	ImGuiInputTextCallbackData_DeleteChars :: proc(self: ^Input_Text_Callback_Data, pos: i32, bytes_count: i32) ---;

	igSelectable_Bool    :: proc(label: cstring, selected: bool, flags: Selectable_Flags, size: Vec2) -> bool ---;
	igSelectable_BoolPtr :: proc(label: cstring, p_selected: ^bool, flags: Selectable_Flags, size: Vec2) -> bool ---;
	ImGuiTextFilter_Draw :: proc(self: ^Text_Filter, label: cstring, width: f32) -> bool ---;

	ImFontAtlas_Clear :: proc(self: ^Font_Atlas) ---;

	ImDrawList_ChannelsSetCurrent :: proc(self: ^Draw_List, n: i32) ---;

	ImGuiTextFilter_Clear :: proc(self: ^Text_Filter) ---;

	igIsAnyItemFocused         :: proc() -> bool ---;
	igLogFinish                :: proc() ---;
	igBeginDragDropSource      :: proc(flags: Drag_Drop_Flags) -> bool ---;
	igRadioButton_Bool         :: proc(label: cstring, active: bool) -> bool ---;
	igRadioButton_IntPtr       :: proc(label: cstring, v: ^i32, v_button: i32) -> bool ---;
	ImDrawList_AddImageRounded :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: Vec2, p_max: Vec2, uv_min: Vec2, uv_max: Vec2, col: u32, rounding: f32, flags: Draw_Flags) ---;

	igSetNextWindowContentSize                       :: proc(size: Vec2) ---;
	igRender                                         :: proc() ---;
	igEndMenuBar                                     :: proc() ---;
	igIsItemActive                                   :: proc() -> bool ---;
	igPopStyleColor                                  :: proc(count: i32) ---;
	igLabelText                                      :: proc(label: cstring, fmt_: cstring, #c_vararg args: ..any) ---;
	igGetPlatformIO                                  :: proc() -> ^Platform_Io ---;
	ImFontAtlas_AddFontFromMemoryCompressedBase85TTF :: proc(self: ^Font_Atlas, compressed_font_data_base85: cstring, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igDragFloat                       :: proc(label: cstring, v: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSetNextFrameWantCaptureKeyboard :: proc(want_capture_keyboard: bool) ---;
	igListBox_Str_arr                 :: proc(label: cstring, current_item: ^i32, items: cstring, items_count: i32, height_in_items: i32) -> bool ---;
	igListBox_FnStrPtr                :: proc(label: cstring, current_item: ^i32, getter: ^^cstring, user_data: rawptr, items_count: i32, height_in_items: i32) -> bool ---;
	ImColor_SetHSV                    :: proc(self: ^Color, h: f32, s: f32, v: f32, a: f32) ---;

	igEndTabItem                         :: proc() ---;
	igSetCurrentContext                  :: proc(ctx: ^Context) ---;
	igSliderFloat3                       :: proc(label: cstring, v: [3]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igTableGetColumnFlags                :: proc(column_n: i32) -> Table_Column_Flags ---;
	igIsMouseHoveringRect                :: proc(r_min: Vec2, r_max: Vec2, clip: bool) -> bool ---;
	ImGuiInputTextCallbackData_SelectAll :: proc(self: ^Input_Text_Callback_Data) ---;

	igGetFrameHeight                :: proc() -> f32 ---;
	igEndTooltip                    :: proc() ---;
	ImGuiSelectionBasicStorage_Swap :: proc(self: ^Selection_Basic_Storage, r: ^Selection_Basic_Storage) ---;

	ImFontAtlas_GetGlyphRangesKorean :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igLogToTTY                 :: proc(auto_open_depth: i32) ---;
	igMemAlloc                 :: proc(size: uint) -> rawptr ---;
	igSaveIniSettingsToMemory  :: proc(out_ini_size: ^uint) -> cstring ---;
	igSeparatorText            :: proc(label: cstring) ---;
	ImFontAtlas_AddFontDefault :: proc(self: ^Font_Atlas, font_cfg: ^Font_Config) -> ^ImFont ---;

	ImGuiIO_AddMouseButtonEvent :: proc(self: ^IO, button: i32, down: bool) ---;

	ImGuiListClipper_Begin :: proc(self: ^List_Clipper, items_count: i32, items_height: f32) ---;

	igPopClipRect                              :: proc() ---;
	igIsItemToggledSelection                   :: proc() -> bool ---;
	igStyleColorsClassic                       :: proc(dst: ^Style) ---;
	igCreateContext                            :: proc(shared_font_atlas: ^Font_Atlas) -> ^Context ---;
	igDebugStartItemPicker                     :: proc() ---;
	igSliderFloat                              :: proc(label: cstring, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igIsItemHovered                            :: proc(flags: Hovered_Flags) -> bool ---;
	igBeginTabItem                             :: proc(label: cstring, p_open: ^bool, flags: Tab_Item_Flags) -> bool ---;
	igGetKeyPressedAmount                      :: proc(key: Key, repeat_delay: f32, rate: f32) -> i32 ---;
	igEndFrame                                 :: proc() ---;
	ImGuiSelectionBasicStorage_SetItemSelected :: proc(self: ^Selection_Basic_Storage, id: ImID, selected: bool) ---;

	ImDrawList__SetTextureID :: proc(self: ^Draw_List, texture_id: Texture_ID) ---;

	ImGuiPayload_IsDelivery :: proc(self: ^Payload) -> bool ---;

	igEndTable            :: proc() ---;
	igSetWindowPos_Vec2   :: proc(pos: Vec2, cond: Cond) ---;
	igSetWindowPos_Str    :: proc(name: cstring, pos: Vec2, cond: Cond) ---;
	igTableGetColumnIndex :: proc() -> i32 ---;
	ImDrawList_AddNgon    :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32, thickness: f32) ---;

	ImGuiStyle_ScaleAllSizes :: proc(self: ^Style, scale_factor: f32) ---;

	ImDrawList__ClearFreeMemory :: proc(self: ^Draw_List) ---;

	ImFont_RenderText :: proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: Vec2, col: u32, clip_rect: Vec4, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip: bool) ---;

	ImDrawList_CloneOutput :: proc(self: ^Draw_List) -> ^Draw_List ---;

	igTableGetColumnCount :: proc() -> i32 ---;
	ImGuiTextBuffer_empty :: proc(self: ^Text_Buffer) -> bool ---;

	igGetItemRectMax        :: proc(pOut: ^Vec2) ---;
	ImGuiStorage_GetBoolRef :: proc(self: ^Storage, key: ImID, default_val: bool) -> ^bool ---;

	igGetItemRectSize                                 :: proc(pOut: ^Vec2) ---;
	igEndGroup                                        :: proc() ---;
	igIsAnyItemHovered                                :: proc() -> bool ---;
	ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon :: proc(self: ^Font_Atlas) -> ^Wchar ---;
	ImFontAtlas_AddFontFromMemoryTTF                  :: proc(self: ^Font_Atlas, font_data: rawptr, font_data_size: i32, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igIsAnyItemActive            :: proc() -> bool ---;
	ImDrawList__PopUnusedDrawCmd :: proc(self: ^Draw_List) ---;

	ImGuiIO_ClearInputMouse :: proc(self: ^IO) ---;

	igTableSetColumnEnabled             :: proc(column_n: i32, v: bool) ---;
	igSetWindowFontScale                :: proc(scale: f32) ---;
	igLoadIniSettingsFromDisk           :: proc(ini_filename: cstring) ---;
	igTableHeadersRow                   :: proc() ---;
	ImDrawList_AddPolyline              :: proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32, flags: Draw_Flags, thickness: f32) ---;
	ImDrawList_PathLineToMergeDuplicate :: proc(self: ^Draw_List, pos: Vec2) ---;

	igDragFloat2            :: proc(label: cstring, v: [2]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igIsMouseDown_Nil       :: proc(button: Mouse_Button) -> bool ---;
	ImFont_BuildLookupTable :: proc(self: ^ImFont) ---;

	igSetTabItemClosed       :: proc(tab_or_docked_window_label: cstring) ---;
	ImGuiTextFilter_IsActive :: proc(self: ^Text_Filter) -> bool ---;

	igGetContentRegionAvail :: proc(pOut: ^Vec2) ---;
	igShowAboutWindow       :: proc(p_open: ^bool) ---;
	igIsItemVisible         :: proc() -> bool ---;
	igSetItemKeyOwner_Nil   :: proc(key: Key) ---;
	ImDrawList_PopClipRect  :: proc(self: ^Draw_List) ---;

	igCalcItemWidth                       :: proc() -> f32 ---;
	igTableSetColumnIndex                 :: proc(column_n: i32) -> bool ---;
	igGetDragDropPayload                  :: proc() -> ^Payload ---;
	ImFontAtlas_GetGlyphRangesChineseFull :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	ImGuiStorage_SetInt :: proc(self: ^Storage, key: ImID, val: i32) ---;

	igBeginTooltip      :: proc() -> bool ---;
	igSmallButton       :: proc(label: cstring) -> bool ---;
	igColorEdit4        :: proc(label: cstring, col: [4]f32, flags: Color_Edit_Flags) -> bool ---;
	igSetScrollHereX    :: proc(center_x_ratio: f32) ---;
	igBeginMenuBar      :: proc() -> bool ---;
	ImFontAtlas_IsBuilt :: proc(self: ^Font_Atlas) -> bool ---;

	igEndDisabled          :: proc() ---;
	igTextColored          :: proc(col: Vec4, fmt_: cstring, #c_vararg args: ..any) ---;
	igOpenPopupOnItemClick :: proc(str_id: cstring, popup_flags: Popup_Flags) ---;
	igColumns              :: proc(count: i32, id: cstring, borders: bool) ---;
	ImDrawList_PathClear   :: proc(self: ^Draw_List) ---;

	ImFontAtlas_AddCustomRectRegular :: proc(self: ^Font_Atlas, width: i32, height: i32) -> i32 ---;

	igLogButtons        :: proc() ---;
	igColorPicker3      :: proc(label: cstring, col: [3]f32, flags: Color_Edit_Flags) -> bool ---;
	igNewLine           :: proc() ---;
	igIsItemDeactivated :: proc() -> bool ---;
	igGetColumnsCount   :: proc() -> i32 ---;
	igImageButton       :: proc(str_id: cstring, user_texture_id: Texture_ID, image_size: Vec2, uv0: Vec2, uv1: Vec2, bg_col: Vec4, tint_col: Vec4) -> bool ---;
	ImDrawList_AddQuad  :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32, thickness: f32) ---;

	igDragScalarN                  :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igTableSetBgColor              :: proc(target: Table_Bg_Target, color: u32, column_n: i32) ---;
	ImDrawList_PrimRect            :: proc(self: ^Draw_List, a: Vec2, b: Vec2, col: u32) ---;
	ImDrawList_AddConvexPolyFilled :: proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32) ---;

	igSetMouseCursor         :: proc(cursor_type: Mouse_Cursor) ---;
	ImDrawListSplitter_Split :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, count: i32) ---;

	igSliderInt                      :: proc(label: cstring, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSetNextItemSelectionUserData   :: proc(selection_user_data: Selection_User_Data) ---;
	igSetDragDropPayload             :: proc(type: cstring, data: rawptr, sz: uint, cond: Cond) -> bool ---;
	igDebugCheckVersionAndDataLayout :: proc(version_str: cstring, sz_io: uint, sz_style: uint, sz_vec2: uint, sz_vec4: uint, sz_drawvert: uint, sz_drawidx: uint) -> bool ---;
	igColorConvertFloat4ToU32        :: proc(in_: Vec4) -> u32 ---;
	igEndListBox                     :: proc() ---;
	igDummy                          :: proc(size: Vec2) ---;
	ImGuiTextRange_empty             :: proc(self: ^Text_Range) -> bool ---;

	igInputFloat3        :: proc(label: cstring, v: [3]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igCalcTextSize       :: proc(pOut: ^Vec2, text: cstring, text_end: cstring, hide_text_after_double_hash: bool, wrap_width: f32) ---;
	ImDrawList_AddCircle :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32, thickness: f32) ---;

	igColorConvertHSVtoRGB           :: proc(h: f32, s: f32, v: f32, out_r: ^f32, out_g: ^f32, out_b: ^f32) ---;
	ImFontGlyphRangesBuilder_AddText :: proc(self: ^Font_Glyph_Ranges_Builder, text: cstring, text_end: cstring) ---;

	ImGuiViewport_GetWorkCenter :: proc(pOut: ^Vec2, self: ^Viewport) ---;

	igSliderScalar          :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igUnindent              :: proc(indent_w: f32) ---;
	ImDrawList_PrimWriteIdx :: proc(self: ^Draw_List, idx: Draw_Idx) ---;

	igPopFont               :: proc() ---;
	ImDrawList_AddImageQuad :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, uv1: Vec2, uv2: Vec2, uv3: Vec2, uv4: Vec2, col: u32) ---;

	igBeginDragDropTarget :: proc() -> bool ---;
	igIsItemToggledOpen   :: proc() -> bool ---;
	igTreePop             :: proc() ---;
	igBulletText          :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igGetCursorPosY       :: proc() -> f32 ---;
	igIsWindowFocused     :: proc(flags: Focused_Flags) -> bool ---;
	igInputScalar         :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImGuiStorage_SetBool  :: proc(self: ^Storage, key: ImID, val: bool) ---;

	igEndDragDropSource        :: proc() ---;
	ImDrawList_AddCircleFilled :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32) ---;

	igLogText                             :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igGetColumnIndex                      :: proc() -> i32 ---;
	igGetBackgroundDrawList_Nil           :: proc() -> ^Draw_List ---;
	ImDrawList_PathBezierQuadraticCurveTo :: proc(self: ^Draw_List, p2: Vec2, p3: Vec2, num_segments: i32) ---;

	igSliderFloat4                 :: proc(label: cstring, v: [4]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSetItemDefaultFocus          :: proc() ---;
	ImFontAtlas_GetGlyphRangesThai :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igIsAnyMouseDown      :: proc() -> bool ---;
	igPushItemWidth       :: proc(item_width: f32) ---;
	ImDrawList_AddEllipse :: proc(self: ^Draw_List, center: Vec2, radius: Vec2, col: u32, rot: f32, num_segments: i32, thickness: f32) ---;

	igInputDouble                  :: proc(label: cstring, v: ^f64, step: f64, step_fast: f64, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImFontAtlas_AddFontFromFileTTF :: proc(self: ^Font_Atlas, filename: cstring, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igTextLinkOpenURL            :: proc(label: cstring, url: cstring) ---;
	igSetColorEditOptions        :: proc(flags: Color_Edit_Flags) ---;
	igTableNextColumn            :: proc() -> bool ---;
	igIsKeyPressed_Bool          :: proc(key: Key, repeat: bool) -> bool ---;
	igIsItemClicked              :: proc(mouse_button: Mouse_Button) -> bool ---;
	igBeginPopup                 :: proc(str_id: cstring, flags: Window_Flags) -> bool ---;
	ImDrawList__ResetForNewFrame :: proc(self: ^Draw_List) ---;

	igSetNextItemAllowOverlap :: proc() ---;
	igGetID_Str               :: proc(str_id: cstring) -> ImID ---;
	igGetID_StrStr            :: proc(str_id_begin: cstring, str_id_end: cstring) -> ImID ---;
	igGetID_Ptr               :: proc(ptr_id: rawptr) -> ImID ---;
	igGetID_Int               :: proc(int_id: i32) -> ImID ---;
	igGetCurrentContext       :: proc() -> ^Context ---;
	ImFont_SetGlyphVisible    :: proc(self: ^ImFont, c: Wchar, visible: bool) ---;

	ImGuiInputTextCallbackData_InsertChars :: proc(self: ^Input_Text_Callback_Data, pos: i32, text: cstring, text_end: cstring) ---;

	igDragInt        :: proc(label: cstring, v: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImDrawData_Clear :: proc(self: ^Draw_Data) ---;

	ImGuiStorage_GetVoidPtrRef :: proc(self: ^Storage, key: ImID, default_val: rawptr) -> ^rawptr ---;

	ImDrawList_PrimReserve :: proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) ---;

	igBeginChild_Str       :: proc(str_id: cstring, size: Vec2, child_flags: Child_Flags, window_flags: Window_Flags) -> bool ---;
	igBeginChild_ID        :: proc(id: ImID, size: Vec2, child_flags: Child_Flags, window_flags: Window_Flags) -> bool ---;
	igEndMainMenuBar       :: proc() ---;
	igSliderScalarN        :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igPlotLines_FloatPtr   :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2, stride: i32) ---;
	igPlotLines_FnFloatPtr :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2) ---
	ImDrawList__PathArcToN :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---;

	igSetNextItemStorageID :: proc(storage_id: ImID) ---;
	igSetStateStorage      :: proc(storage: ^Storage) ---;
	igLogToClipboard       :: proc(auto_open_depth: i32) ---;
	ImFont_GrowIndex       :: proc(self: ^ImFont, new_size: i32) ---;

	igGetTextLineHeight           :: proc() -> f32 ---;
	igBullet                      :: proc() ---;
	igSpacing                     :: proc() ---;
	igInputTextMultiline          :: proc(label: cstring, buf: cstring, buf_size: uint, size: Vec2, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igArrowButton                 :: proc(str_id: cstring, dir: Dir) -> bool ---;
	igSetColumnWidth              :: proc(column_index: i32, width: f32) ---;
	igGetVersion                  :: proc() -> cstring ---;
	igGetWindowPos                :: proc(pOut: ^Vec2) ---;
	ImGuiIO_SetKeyEventNativeData :: proc(self: ^IO, key: Key, native_keycode: i32, native_scancode: i32, native_legacy_index: i32) ---;

	igGetAllocatorFunctions  :: proc(p_alloc_func: ^Mem_Alloc_Func, p_free_func: ^Mem_Free_Func, p_user_data: ^rawptr) ---;
	igSetNextWindowCollapsed :: proc(collapsed: bool, cond: Cond) ---;
	ImGuiTextBuffer_size     :: proc(self: ^Text_Buffer) -> i32 ---;

	igGetWindowDrawList   :: proc() -> ^Draw_List ---;
	igTableNextRow        :: proc(row_flags: Table_Row_Flags, min_row_height: f32) ---;
	ImGuiStorage_GetFloat :: proc(self: ^Storage, key: ImID, default_val: f32) -> f32 ---;

	ImDrawList_PushTextureID :: proc(self: ^Draw_List, texture_id: Texture_ID) ---;

	igShowStyleSelector    :: proc(label: cstring) -> bool ---;
	ImFont_ClearOutputData :: proc(self: ^ImFont) ---;

	ImDrawList_AddRectFilled       :: proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col: u32, rounding: f32, flags: Draw_Flags) ---;
	ImDrawList__OnChangedTextureID :: proc(self: ^Draw_List) ---;

	igEnd                    :: proc() ---;
	igCheckbox               :: proc(label: cstring, v: ^bool) -> bool ---;
	igGetScrollX             :: proc() -> f32 ---;
	ImDrawList_AddNgonFilled :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32) ---;

	igSetScrollHereY                     :: proc(center_y_ratio: f32) ---;
	ImFontAtlas_GetTexDataAsRGBA32       :: proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---;
	ImFontAtlas_GetGlyphRangesVietnamese :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	ImGuiTextFilter_Build :: proc(self: ^Text_Filter) ---;

	igIsKeyDown_Nil                     :: proc(key: Key) -> bool ---;
	igShowDemoWindow                    :: proc(p_open: ^bool) ---;
	igColorPicker4                      :: proc(label: cstring, col: [4]f32, flags: Color_Edit_Flags, ref_col: ^f32) -> bool ---;
	ImGuiListClipper_IncludeItemByIndex :: proc(self: ^List_Clipper, item_index: i32) ---;

	igBeginMenu             :: proc(label: cstring, enabled: bool) -> bool ---;
	igShowStyleEditor       :: proc(ref: ^Style) ---;
	igNewFrame              :: proc() ---;
	igIsMousePosValid       :: proc(mouse_pos: ^Vec2) -> bool ---;
	igTableAngledHeadersRow :: proc() ---;
	igTableGetHoveredColumn :: proc() -> i32 ---;
	ImGuiTextBuffer_appendf :: proc(self: ^Text_Buffer, fmt_: cstring, #c_vararg args: ..any) ---;

	ImDrawList_PopTextureID :: proc(self: ^Draw_List) ---;

	ImDrawData_AddDrawList :: proc(self: ^Draw_Data, draw_list: ^Draw_List) ---;

	igSetWindowSize_Vec2           :: proc(size: Vec2, cond: Cond) ---;
	igSetWindowSize_Str            :: proc(name: cstring, size: Vec2, cond: Cond) ---;
	igDestroyContext               :: proc(ctx: ^Context) ---;
	igTreeNodeEx_Str               :: proc(label: cstring, flags: Tree_Node_Flags) -> bool ---;
	igTreeNodeEx_StrStr            :: proc(str_id: cstring, flags: Tree_Node_Flags, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreeNodeEx_Ptr               :: proc(ptr_id: rawptr, flags: Tree_Node_Flags, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igGetColumnOffset              :: proc(column_index: i32) -> f32 ---;
	igGetTextLineHeightWithSpacing :: proc() -> f32 ---;
	ImDrawCmd_GetTexID             :: proc(self: ^Draw_Cmd) -> Texture_ID ---;

	igBeginItemTooltip :: proc() -> bool ---;
	ImFont_AddGlyph    :: proc(self: ^ImFont, src_cfg: ^Font_Config, c: Wchar, x0: f32, y0: f32, x1: f32, y1: f32, u0: f32, v0: f32, u1: f32, v1: f32, advance_x: f32) ---;

	ImGuiStorage_GetBool :: proc(self: ^Storage, key: ImID, default_val: bool) -> bool ---;

	igBeginMainMenuBar             :: proc() -> bool ---;
	igInputFloat2                  :: proc(label: cstring, v: [2]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImDrawList_PathEllipticalArcTo :: proc(self: ^Draw_List, center: Vec2, radius: Vec2, rot: f32, a_min: f32, a_max: f32, num_segments: i32) ---;

	igSameLine                     :: proc(offset_from_start_x: f32, spacing: f32) ---;
	ImFontAtlas_GetTexDataAsAlpha8 :: proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---;

	ImDrawList__TryMergeDrawCmds :: proc(self: ^Draw_List) ---;

	ImGuiStorage_SetVoidPtr :: proc(self: ^Storage, key: ImID, val: rawptr) ---;

	igGetTime                :: proc() -> f64 ---;
	ImDrawListSplitter_Merge :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List) ---;

	igSetNextFrameWantCaptureMouse :: proc(want_capture_mouse: bool) ---;
	ImDrawList_AddDrawCmd          :: proc(self: ^Draw_List) ---;
	ImDrawList_AddQuadFilled       :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32) ---;

	igGetCursorPosX                         :: proc() -> f32 ---;
	igPushFont                              :: proc(font: ^ImFont) ---;
	ImGuiInputTextCallbackData_HasSelection :: proc(self: ^Input_Text_Callback_Data) -> bool ---;

	igIndent                           :: proc(indent_w: f32) ---;
	ImDrawListSplitter_ClearFreeMemory :: proc(self: ^Draw_List_Splitter) ---;

	igIsItemFocused             :: proc() -> bool ---;
	igGetTreeNodeToLabelSpacing :: proc() -> f32 ---;
	ImFont_FindGlyph            :: proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph ---;

	ImGuiStorage_GetVoidPtr :: proc(self: ^Storage, key: ImID) -> rawptr ---;

	ImDrawList_PathFillConcave :: proc(self: ^Draw_List, col: u32) ---;

	igShowUserGuide               :: proc() ---;
	igSliderInt3                  :: proc(label: cstring, v: [3]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImDrawList__OnChangedClipRect :: proc(self: ^Draw_List) ---;

	ImDrawListSplitter_Clear :: proc(self: ^Draw_List_Splitter) ---;

	igBeginPopupContextItem :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	igGetMouseClickedCount  :: proc(button: Mouse_Button) -> i32 ---;
	igSetCursorPosY         :: proc(local_y: f32) ---;
	igSetColumnOffset       :: proc(column_index: i32, offset_x: f32) ---;
	igTreePush_Str          :: proc(str_id: cstring) ---;
	igTreePush_Ptr          :: proc(ptr_id: rawptr) ---;
	ImFontAtlas_Build       :: proc(self: ^Font_Atlas) -> bool ---;

	igBeginDisabled    :: proc(disabled: bool) ---;
	ImDrawList_AddRect :: proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col: u32, rounding: f32, flags: Draw_Flags, thickness: f32) ---;

	igGetCursorStartPos             :: proc(pOut: ^Vec2) ---;
	igSetNextWindowFocus            :: proc() ---;
	igEndDragDropTarget             :: proc() ---;
	igSeparator                     :: proc() ---;
	igSetAllocatorFunctions         :: proc(alloc_func: Alloc_Func, free_func: Free_Func) ---
	ImFontAtlas_GetGlyphRangesGreek :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	ImDrawList_AddConcavePolyFilled :: proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32) ---;

	igCloseCurrentPopup   :: proc() ---;
	igDebugLog            :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igValue_Bool          :: proc(prefix: cstring, b: bool) ---;
	igValue_Int           :: proc(prefix: cstring, v: i32) ---;
	igValue_Uint          :: proc(prefix: cstring, v: u32) ---;
	igValue_Float         :: proc(prefix: cstring, v: f32, float_format: cstring) ---;
	igInputInt            :: proc(label: cstring, v: ^i32, step: i32, step_fast: i32, flags: Input_Text_Flags) -> bool ---;
	ImGuiStorage_SetFloat :: proc(self: ^Storage, key: ImID, val: f32) ---;

	igShowDebugLogWindow              :: proc(p_open: ^bool) ---;
	igGetFont                         :: proc() -> ^ImFont ---;
	igLogToFile                       :: proc(auto_open_depth: i32, filename: cstring) ---;
	igBeginPopupModal                 :: proc(name: cstring, p_open: ^bool, flags: Window_Flags) -> bool ---;
	ImDrawList_PathBezierCubicCurveTo :: proc(self: ^Draw_List, p2: Vec2, p3: Vec2, p4: Vec2, num_segments: i32) ---;

	ImGuiIO_ClearInputKeys :: proc(self: ^IO) ---;

	igEndPopup                 :: proc() ---;
	igPushItemFlag             :: proc(option: Item_Flags, enabled: bool) ---;
	ImFont_FindGlyphNoFallback :: proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph ---;

	ImGuiIO_AddInputCharacterUTF16 :: proc(self: ^IO, c: Wchar16) ---;

	ImFontAtlas_AddFontFromMemoryCompressedTTF :: proc(self: ^Font_Atlas, compressed_font_data: rawptr, compressed_font_data_size: i32, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igVSliderScalar                   :: proc(label: cstring, size: Vec2, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	ImFontAtlas_GetGlyphRangesDefault :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	ImGuiListClipper_IncludeItemsByIndex :: proc(self: ^List_Clipper, item_begin: i32, item_end: i32) ---;

	ImFontGlyphRangesBuilder_BuildRanges :: proc(self: ^Font_Glyph_Ranges_Builder, out_ranges: ^Im_Vector(Wchar)) ---;

	igSetKeyboardFocusHere              :: proc(offset: i32) ---;
	igAlignTextToFramePadding           :: proc() ---;
	igDragInt2                          :: proc(label: cstring, v: [2]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igIsRectVisible_Nil                 :: proc(size: Vec2) -> bool ---;
	igIsRectVisible_Vec2                :: proc(rect_min: Vec2, rect_max: Vec2) -> bool ---;
	igSetNextItemWidth                  :: proc(item_width: f32) ---;
	ImGuiSelectionBasicStorage_Contains :: proc(self: ^Selection_Basic_Storage, id: ImID) -> bool ---;

	igGetStateStorage          :: proc() -> ^Storage ---;
	ImFontAtlas_ClearInputData :: proc(self: ^Font_Atlas) ---;

	igSetNextWindowSizeConstraints :: proc(size_min: Vec2, size_max: Vec2, custom_callback: Size_Callback, custom_callback_data: rawptr) ---;
	igGetMouseDragDelta            :: proc(pOut: ^Vec2, button: Mouse_Button, lock_threshold: f32) ---;
	igImage                        :: proc(user_texture_id: Texture_ID, image_size: Vec2, uv0: Vec2, uv1: Vec2, tint_col: Vec4, border_col: Vec4) ---;
	igSetTooltip                   :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	ImGuiStorage_BuildSortByKey    :: proc(self: ^Storage) ---;

	igPushTextWrapPos        :: proc(wrap_local_pos_x: f32) ---;
	ImFontAtlas_ClearTexData :: proc(self: ^Font_Atlas) ---;

	igDragFloat4          :: proc(label: cstring, v: [4]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImGuiTextBuffer_begin :: proc(self: ^Text_Buffer) -> cstring ---;

	igGetClipboardText               :: proc() -> cstring ---;
	igPopStyleVar                    :: proc(count: i32) ---;
	ImFontAtlas_GetCustomRectByIndex :: proc(self: ^Font_Atlas, index: i32) -> ^Font_Atlas_Custom_Rect ---;

	igSetNextWindowSize   :: proc(size: Vec2, cond: Cond) ---;
	ImGuiTextBuffer_c_str :: proc(self: ^Text_Buffer) -> cstring ---;

	ImGuiIO_AddKeyAnalogEvent :: proc(self: ^IO, key: Key, down: bool, v: f32) ---;

	ImFontAtlas_AddCustomRectFontGlyph :: proc(self: ^Font_Atlas, font: ^ImFont, id: Wchar, width: i32, height: i32, advance_x: f32, offset: Vec2) -> i32 ---;

	igShowIDStackToolWindow                :: proc(p_open: ^bool) ---;
	ImDrawList__CalcCircleAutoSegmentCount :: proc(self: ^Draw_List, radius: f32) -> i32 ---;

	igSetItemTooltip    :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igGetWindowHeight   :: proc() -> f32 ---;
	igGetScrollY        :: proc() -> f32 ---;
	igVSliderInt        :: proc(label: cstring, size: Vec2, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igBeginCombo        :: proc(label: cstring, preview_value: cstring, flags: Combo_Flags) -> bool ---;
	igGetFrameCount     :: proc() -> i32 ---;
	ImDrawList_PathRect :: proc(self: ^Draw_List, rect_min: Vec2, rect_max: Vec2, rounding: f32, flags: Draw_Flags) ---;

	igTableGetSortSpecs         :: proc() -> ^Table_Sort_Specs ---;
	igGetItemID                 :: proc() -> ImID ---;
	igGetForegroundDrawList_Nil :: proc() -> ^Draw_List ---;
	ImDrawList_PushClipRect     :: proc(self: ^Draw_List, clip_rect_min: Vec2, clip_rect_max: Vec2, intersect_with_current_clip_rect: bool) ---;

	igInputFloat            :: proc(label: cstring, v: ^f32, step: f32, step_fast: f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImGuiPayload_IsDataType :: proc(self: ^Payload, type: cstring) -> bool ---;

	ImFontAtlas_GetGlyphRangesJapanese :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igGetColumnWidth                 :: proc(column_index: i32) -> f32 ---;
	ImGuiSelectionBasicStorage_Clear :: proc(self: ^Selection_Basic_Storage) ---;

	igTextLink                               :: proc(label: cstring) -> bool ---;
	ImGuiSelectionBasicStorage_ApplyRequests :: proc(self: ^Selection_Basic_Storage, ms_io: ^Multi_Select_Io) ---;

	ImGuiPayload_Clear :: proc(self: ^Payload) ---;

	igPushStyleColor_U32                        :: proc(idx: Col, col: u32) ---;
	igPushStyleColor_Vec4                       :: proc(idx: Col, col: Vec4) ---;
	ImGuiSelectionExternalStorage_ApplyRequests :: proc(self: ^Selection_External_Storage, ms_io: ^Multi_Select_Io) ---;

	igSetNextItemShortcut             :: proc(key_chord: Key_Chord, flags: Input_Flags) ---;
	igPlotHistogram_FloatPtr          :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2, stride: i32) ---;
	igPlotHistogram_FnFloatPtr        :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2) ---
	ImDrawList_PushClipRectFullScreen :: proc(self: ^Draw_List) ---;

	igSetNextWindowPos  :: proc(pos: Vec2, cond: Cond, pivot: Vec2) ---;
	ImGuiStorage_GetInt :: proc(self: ^Storage, key: ImID, default_val: i32) -> i32 ---;

	igBegin                :: proc(name: cstring, p_open: ^bool, flags: Window_Flags) -> bool ---;
	igTableGetRowIndex     :: proc() -> i32 ---;
	igPushStyleVarY        :: proc(idx: Style_Var, val_y: f32) ---;
	igResetMouseDragDelta  :: proc(button: Mouse_Button) ---;
	igGetIO                :: proc() -> ^IO ---;
	ImFontAtlas_ClearFonts :: proc(self: ^Font_Atlas) ---;

	igDebugFlashStyleColor                    :: proc(idx: Col) ---;
	ImGuiInputTextCallbackData_ClearSelection :: proc(self: ^Input_Text_Callback_Data) ---;

	ImGuiPayload_IsPreview :: proc(self: ^Payload) -> bool ---;

	ImFontGlyphRangesBuilder_GetBit :: proc(self: ^Font_Glyph_Ranges_Builder, n: uint) -> bool ---;

	igMemFree          :: proc(ptr: rawptr) ---;
	ImDrawList_AddLine :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, col: u32, thickness: f32) ---;

	igSetNextWindowScroll              :: proc(scroll: Vec2) ---;
	igGetFontTexUvWhitePixel           :: proc(pOut: ^Vec2) ---;
	ImGuiListClipper_SeekCursorForItem :: proc(self: ^List_Clipper, item_index: i32) ---;

	igSetScrollFromPosX_Float :: proc(local_x: f32, center_x_ratio: f32) ---;
	ImFont_IsLoaded           :: proc(self: ^ImFont) -> bool ---;

	ImDrawList_GetClipRectMin :: proc(pOut: ^Vec2, self: ^Draw_List) ---;

	igShortcut_Nil            :: proc(key_chord: Key_Chord, flags: Input_Flags) -> bool ---;
	igGetColorU32_Col         :: proc(idx: Col, alpha_mul: f32) -> u32 ---;
	igGetColorU32_Vec4        :: proc(col: Vec4) -> u32 ---;
	igGetColorU32_U32         :: proc(col: u32, alpha_mul: f32) -> u32 ---;
	igIsWindowAppearing       :: proc() -> bool ---;
	ImGuiIO_AddInputCharacter :: proc(self: ^IO, c: u32) ---;

	igSliderInt2             :: proc(label: cstring, v: [2]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImDrawList_PathArcToFast :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min_of_12: i32, a_max_of_12: i32) ---;

	igSetCursorScreenPos  :: proc(pos: Vec2) ---;
	ImGuiTextBuffer_clear :: proc(self: ^Text_Buffer) ---;

	igTableGetColumnName_Int           :: proc(column_n: i32) -> cstring ---;
	igSetCursorPosX                    :: proc(local_x: f32) ---;
	ImFontAtlas_GetGlyphRangesCyrillic :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igIsMouseDragging                 :: proc(button: Mouse_Button, lock_threshold: f32) -> bool ---;
	ImFontAtlas_GetMouseCursorTexData :: proc(self: ^Font_Atlas, cursor: Mouse_Cursor, out_offset: ^Vec2, out_size: ^Vec2, out_uv_border: [2]Vec2, out_uv_fill: [2]Vec2) -> bool ---;

	igGetCursorPos               :: proc(pOut: ^Vec2) ---;
	igNextColumn                 :: proc() ---;
	igGetWindowSize              :: proc(pOut: ^Vec2) ---;
	igShowFontSelector           :: proc(label: cstring) ---;
	ImFontAtlas_CalcCustomRectUV :: proc(self: ^Font_Atlas, rect: ^Font_Atlas_Custom_Rect, out_uv_min: ^Vec2, out_uv_max: ^Vec2) ---;

	igEndMenu                        :: proc() ---;
	ImFontGlyphRangesBuilder_AddChar :: proc(self: ^Font_Glyph_Ranges_Builder, c: Wchar) ---;

	ImFont_GetDebugName :: proc(self: ^ImFont) -> cstring ---;

	igAcceptDragDropPayload  :: proc(type: cstring, flags: Drag_Drop_Flags) -> ^Payload ---;
	ImGuiStorage_GetFloatRef :: proc(self: ^Storage, key: ImID, default_val: f32) -> ^f32 ---;

	igInputInt2                  :: proc(label: cstring, v: [2]i32, flags: Input_Text_Flags) -> bool ---;
	ImFont_CalcWordWrapPositionA :: proc(self: ^ImFont, scale: f32, text: cstring, text_end: cstring, wrap_width: f32) -> cstring ---;

	igGetMousePos          :: proc(pOut: ^Vec2) ---;
	ImDrawList_AddTriangle :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32, thickness: f32) ---;

	igGetDrawData                  :: proc() -> ^Draw_Data ---;
	ImDrawList__OnChangedVtxOffset :: proc(self: ^Draw_List) ---;

	igEndMultiSelect      :: proc() -> ^Multi_Select_Io ---;
	ImDrawList_PrimRectUV :: proc(self: ^Draw_List, a: Vec2, b: Vec2, uv_a: Vec2, uv_b: Vec2, col: u32) ---;
	ImDrawList_PrimVtx    :: proc(self: ^Draw_List, pos: Vec2, uv: Vec2, col: u32) ---;

	igPopTextWrapPos       :: proc() ---;
	igColorConvertRGBtoHSV :: proc(r: f32, g: f32, b: f32, out_h: ^f32, out_s: ^f32, out_v: ^f32) ---;
	ImFont_GetCharAdvance  :: proc(self: ^ImFont, c: Wchar) -> f32 ---;

	ImDrawList_AddTriangleFilled :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32) ---;

	ImGuiListClipper_Step :: proc(self: ^List_Clipper) -> bool ---;

	ImDrawList_AddBezierQuadratic :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32, thickness: f32, num_segments: i32) ---;

	igSetScrollX_Float             :: proc(scroll_x: f32) ---;
	igSetWindowCollapsed_Bool      :: proc(collapsed: bool, cond: Cond) ---;
	igSetWindowCollapsed_Str       :: proc(name: cstring, collapsed: bool, cond: Cond) ---;
	igSetCursorPos                 :: proc(local_pos: Vec2) ---;
	ImFontAtlasCustomRect_IsPacked :: proc(self: ^Font_Atlas_Custom_Rect) -> bool ---;

	igGetWindowWidth   :: proc() -> f32 ---;
	igTextWrapped      :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igBeginListBox     :: proc(label: cstring, size: Vec2) -> bool ---;
	ImGuiStorage_Clear :: proc(self: ^Storage) ---;

	igBeginPopupContextWindow :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	igGetCursorScreenPos      :: proc(pOut: ^Vec2) ---;
	igInputTextWithHint       :: proc(label: cstring, hint: cstring, buf: cstring, buf_size: uint, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igMenuItem_Bool           :: proc(label: cstring, shortcut: cstring, selected: bool, enabled: bool) -> bool ---;
	igMenuItem_BoolPtr        :: proc(label: cstring, shortcut: cstring, p_selected: ^bool, enabled: bool) -> bool ---;
	igPopID                   :: proc() ---;
	ImGuiViewport_GetCenter   :: proc(pOut: ^Vec2, self: ^Viewport) ---;

	ImFont_CalcTextSizeA :: proc(pOut: ^Vec2, self: ^ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: cstring, text_end: cstring, remaining: ^cstring) ---;

	igGetScrollMaxX             :: proc() -> f32 ---;
	igIsKeyChordPressed_Nil     :: proc(key_chord: Key_Chord) -> bool ---;
	ImDrawList_AddEllipseFilled :: proc(self: ^Draw_List, center: Vec2, radius: Vec2, col: u32, rot: f32, num_segments: i32) ---;

	igIsMouseReleased_Nil :: proc(button: Mouse_Button) -> bool ---;
	igEndCombo            :: proc() ---;
	ImDrawList_PrimQuadUV :: proc(self: ^Draw_List, a: Vec2, b: Vec2, c: Vec2, d: Vec2, uv_a: Vec2, uv_b: Vec2, uv_c: Vec2, uv_d: Vec2, col: u32) ---;

	ImFont_IsGlyphRangeUnused :: proc(self: ^ImFont, c_begin: u32, c_last: u32) -> bool ---;

	igPushID_Str                       :: proc(str_id: cstring) ---;
	igPushID_StrStr                    :: proc(str_id_begin: cstring, str_id_end: cstring) ---;
	igPushID_Ptr                       :: proc(ptr_id: rawptr) ---;
	igPushID_Int                       :: proc(int_id: i32) ---;
	igDragInt3                         :: proc(label: cstring, v: [3]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igPushClipRect                     :: proc(clip_rect_min: Vec2, clip_rect_max: Vec2, intersect_with_current_clip_rect: bool) ---;
	igBeginTable                       :: proc(str_id: cstring, columns: i32, flags: Table_Flags, outer_size: Vec2, inner_width: f32) -> bool ---;
	igGetMousePosOnOpeningCurrentPopup :: proc(pOut: ^Vec2) ---;
	igStyleColorsDark                  :: proc(dst: ^Style) ---;
	igSetNextWindowBgAlpha             :: proc(alpha: f32) ---;
	igIsWindowCollapsed                :: proc() -> bool ---;
	igInvisibleButton                  :: proc(str_id: cstring, size: Vec2, flags: Button_Flags) -> bool ---;
	igCombo_Str_arr                    :: proc(label: cstring, current_item: ^i32, items: ^cstring, items_count: i32, popup_max_height_in_items: i32) -> bool ---
	igCombo_Str                        :: proc(label: cstring, current_item: ^i32, items_separated_by_zeros: cstring, popup_max_height_in_items: i32) -> bool ---;
	igCombo_FnStrPtr                   :: proc(label: cstring, current_item: ^i32, getter: ^^cstring, user_data: rawptr, items_count: i32, popup_max_height_in_items: i32) -> bool ---;
	ImGuiIO_AddInputCharactersUTF8     :: proc(self: ^IO, str: cstring) ---;

	ImDrawList_PrimUnreserve :: proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) ---;

	igEndChild          :: proc() ---;
	igVSliderFloat      :: proc(label: cstring, size: Vec2, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImFontAtlas_AddFont :: proc(self: ^Font_Atlas, font_cfg: ^Font_Config) -> ^ImFont ---;

	igOpenPopup_Str         :: proc(str_id: cstring, popup_flags: Popup_Flags) ---;
	igOpenPopup_ID          :: proc(id: ImID, popup_flags: Popup_Flags) ---;
	igIsItemActivated       :: proc() -> bool ---;
	ImDrawList_PrimWriteVtx :: proc(self: ^Draw_List, pos: Vec2, uv: Vec2, col: u32) ---;

	igGetFrameHeightWithSpacing :: proc() -> f32 ---;
	igIsWindowHovered           :: proc(flags: Hovered_Flags) -> bool ---;
	igColorEdit3                :: proc(label: cstring, col: [3]f32, flags: Color_Edit_Flags) -> bool ---;
	igBeginGroup                :: proc() ---;
	ImDrawList_GetClipRectMax   :: proc(pOut: ^Vec2, self: ^Draw_List) ---;

	ImGuiTextBuffer_reserve :: proc(self: ^Text_Buffer, capacity: i32) ---;

	igGetStyle        :: proc() -> ^Style ---;
	ImFont_RenderChar :: proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: Vec2, col: u32, c: Wchar) ---;

	igDragInt4     :: proc(label: cstring, v: [4]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderFloat2 :: proc(label: cstring, v: [2]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImColor_HSV    :: proc(pOut: ^Color, h: f32, s: f32, v: f32, a: f32) ---;

	igTableHeader              :: proc(label: cstring) ---;
	ImGuiTextFilter_PassFilter :: proc(self: ^Text_Filter, text: cstring, text_end: cstring) -> bool ---;

	igText                 :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igTabItemButton        :: proc(label: cstring, flags: Tab_Item_Flags) -> bool ---;
	ImGuiStorage_SetAllInt :: proc(self: ^Storage, val: i32) ---;

	ImDrawList_AddBezierCubic :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32, thickness: f32, num_segments: i32) ---;
	ImDrawList_AddCallback    :: proc(self: ^Draw_List, callback: Draw_Callback, callback_data: rawptr) ---;

	igIsItemEdited                     :: proc() -> bool ---;
	igTableSetupScrollFreeze           :: proc(cols: i32, rows: i32) ---;
	ImDrawList_AddRectFilledMultiColor :: proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col_upr_left: u32, col_upr_right: u32, col_bot_right: u32, col_bot_left: u32) ---;
	ImDrawList_PathArcTo               :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---;

	igEndTabBar                                      :: proc() ---;
	igSliderAngle                                    :: proc(label: cstring, v_rad: ^f32, v_degrees_min: f32, v_degrees_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igPushStyleVarX                                  :: proc(idx: Style_Var, val_x: f32) ---;
	igGetFontSize                                    :: proc() -> f32 ---;
	igDebugTextEncoding                              :: proc(text: cstring) ---;
	ImGuiSelectionBasicStorage_GetStorageIdFromIndex :: proc(self: ^Selection_Basic_Storage, idx: i32) -> ImID ---;

	ImFontAtlas_SetTexID :: proc(self: ^Font_Atlas, id: Texture_ID) ---;

	igInputFloat4                 :: proc(label: cstring, v: [4]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igPopItemFlag                 :: proc() ---;
	igBeginMultiSelect            :: proc(flags: Multi_Select_Flags, selection_size: i32, items_count: i32) -> ^Multi_Select_Io ---;
	igShowMetricsWindow           :: proc(p_open: ^bool) ---;
	ImGuiIO_SetAppAcceptingEvents :: proc(self: ^IO, accepting_events: bool) ---;
	ImGuiIO_AddMousePosEvent      :: proc(self: ^IO, x: f32, y: f32) ---;

	igIsMouseDoubleClicked_Nil :: proc(button: Mouse_Button) -> bool ---;
	igGetDrawListSharedData    :: proc() -> ^Draw_List_Shared_Data ---;
	ImGuiTextBuffer_end        :: proc(self: ^Text_Buffer) -> cstring ---;

	igSetScrollFromPosY_Float :: proc(local_y: f32, center_y_ratio: f32) ---;
	igDragFloatRange2         :: proc(label: cstring, v_current_min: ^f32, v_current_max: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, format_max: cstring, flags: Slider_Flags) -> bool ---;
	igSetNextItemOpen         :: proc(is_open: bool, cond: Cond) ---;
	ImDrawList_AddImage       :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: Vec2, p_max: Vec2, uv_min: Vec2, uv_max: Vec2, col: u32) ---;
	ImDrawList_ChannelsSplit  :: proc(self: ^Draw_List, count: i32) ---;

	ImGuiSelectionBasicStorage_GetNextSelectedItem :: proc(self: ^Selection_Basic_Storage, opaque_it: ^rawptr, out_id: ^ImID) -> bool ---;

	igSetClipboardText         :: proc(text: cstring) ---;
	ImDrawList_AddText_Vec2    :: proc(self: ^Draw_List, pos: Vec2, col: u32, text_begin: cstring, text_end: cstring) ---;
	ImDrawList_AddText_FontPtr :: proc(self: ^Draw_List, font: ^ImFont, font_size: f32, pos: Vec2, col: u32, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip_rect: ^Vec4) ---;
	ImDrawList_ChannelsMerge   :: proc(self: ^Draw_List) ---;

	igGetStyleColorVec4        :: proc(idx: Col) -> ^Vec4 ---;
	igIsKeyReleased_Nil        :: proc(key: Key) -> bool ---;
	ImGuiIO_AddMouseWheelEvent :: proc(self: ^IO, wheel_x: f32, wheel_y: f32) ---;

	ImGuiListClipper_End :: proc(self: ^List_Clipper) ---;

	igGetItemRectMin          :: proc(pOut: ^Vec2) ---;
	igProgressBar             :: proc(fraction: f32, size_arg: Vec2, overlay: cstring) ---;
	ImDrawData_ScaleClipRects :: proc(self: ^Draw_Data, fb_scale: Vec2) ---;

	igBeginTabBar             :: proc(str_id: cstring, flags: Tab_Bar_Flags) -> bool ---;
	igPushStyleVar_Float      :: proc(idx: Style_Var, val: f32) ---;
	igPushStyleVar_Vec2       :: proc(idx: Style_Var, val: Vec2) ---;
	igIsPopupOpen_Str         :: proc(str_id: cstring, flags: Popup_Flags) -> bool ---;
	igTableSetupColumn        :: proc(label: cstring, flags: Table_Column_Flags, init_width_or_weight: f32, user_id: ImID) ---;
	igTextDisabled            :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	ImDrawList_PathFillConvex :: proc(self: ^Draw_List, col: u32) ---;

	igCollapsingHeader_TreeNodeFlags :: proc(label: cstring, flags: Tree_Node_Flags) -> bool ---;
	igCollapsingHeader_BoolPtr       :: proc(label: cstring, p_visible: ^bool, flags: Tree_Node_Flags) -> bool ---;
	ImFontGlyphRangesBuilder_Clear   :: proc(self: ^Font_Glyph_Ranges_Builder) ---;

	igButton                    :: proc(label: cstring, size: Vec2) -> bool ---;
	ImGuiIO_AddMouseSourceEvent :: proc(self: ^IO, source: Mouse_Source) ---;

	igInputInt3 :: proc(label: cstring, v: [3]i32, flags: Input_Text_Flags) -> bool ---;

}
