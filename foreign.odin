package imgui;

when ODIN_DEBUG {
	foreign import cimgui "external/cimgui_debug.lib";
} else {
	foreign import cimgui "external/cimgui.lib";
}

@(default_calling_convention="c")
foreign cimgui {
	igGetCursorPosX             :: proc() -> f32 ---;
	igIsRectVisible_Nil         :: proc(size: Vec2) -> bool ---;
	igIsRectVisible_Vec2        :: proc(rect_min: Vec2, rect_max: Vec2) -> bool ---;
	igColorConvertHSVtoRGB      :: proc(h: f32, s: f32, v: f32, out_r: ^f32, out_g: ^f32, out_b: ^f32) ---;
	igGetTreeNodeToLabelSpacing :: proc() -> f32 ---;
	igBeginCombo                :: proc(label: cstring, preview_value: cstring, flags: Combo_Flags) -> bool ---;
	igDestroyContext            :: proc(ctx: ^Context) ---;
	igBeginChild_Str            :: proc(str_id: cstring, size: Vec2, child_flags: Child_Flags, window_flags: Window_Flags) -> bool ---;
	igBeginChild_ID             :: proc(id: ImID, size: Vec2, child_flags: Child_Flags, window_flags: Window_Flags) -> bool ---;
	igSetScrollFromPosY_Float   :: proc(local_y: f32, center_y_ratio: f32) ---;
	igBeginMultiSelect          :: proc(flags: Multi_Select_Flags, selection_size: i32, items_count: i32) -> ^Multi_Select_Io ---;
	ImGuiTextBuffer_append      :: proc(self: ^Text_Buffer, str: cstring, str_end: cstring) ---;
	ImGuiTextBuffer_appendf     :: proc(self: ^Text_Buffer, fmt_: cstring, #c_vararg args: ..any) ---;

	igInputInt2                     :: proc(label: cstring, v: [2]i32, flags: Input_Text_Flags) -> bool ---;
	ImGuiSelectionBasicStorage_Swap :: proc(self: ^Selection_Basic_Storage, r: ^Selection_Basic_Storage) ---;

	ImFont_CalcTextSizeA :: proc(pOut: ^Vec2, self: ^ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: cstring, text_end: cstring, remaining: ^cstring) ---;

	ImFontAtlas_Build :: proc(self: ^Font_Atlas) -> bool ---;

	igSetTooltip          :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	ImGuiTextFilter_Build :: proc(self: ^Text_Filter) ---;

	igInputFloat2                          :: proc(label: cstring, v: [2]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImDrawList__CalcCircleAutoSegmentCount :: proc(self: ^Draw_List, radius: f32) -> i32 ---;

	ImGuiIO_AddMouseButtonEvent :: proc(self: ^IO, button: i32, down: bool) ---;
	ImGuiIO_ClearInputKeys      :: proc(self: ^IO) ---;

	igBeginGroup            :: proc() ---;
	igBeginDisabled         :: proc(disabled: bool) ---;
	igDragFloatRange2       :: proc(label: cstring, v_current_min: ^f32, v_current_max: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, format_max: cstring, flags: Slider_Flags) -> bool ---;
	igEndGroup              :: proc() ---;
	igSetCursorPos          :: proc(local_pos: Vec2) ---;
	igOpenPopup_Str         :: proc(str_id: cstring, popup_flags: Popup_Flags) ---;
	igOpenPopup_ID          :: proc(id: ImID, popup_flags: Popup_Flags) ---;
	igTreeNodeEx_Str        :: proc(label: cstring, flags: Tree_Node_Flags) -> bool ---;
	igTreeNodeEx_StrStr     :: proc(str_id: cstring, flags: Tree_Node_Flags, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreeNodeEx_Ptr        :: proc(ptr_id: rawptr, flags: Tree_Node_Flags, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	ImGuiStorage_GetBoolRef :: proc(self: ^Storage, key: ImID, default_val: bool) -> ^bool ---;

	igPushItemWidth         :: proc(item_width: f32) ---;
	igInputInt              :: proc(label: cstring, v: ^i32, step: i32, step_fast: i32, flags: Input_Text_Flags) -> bool ---;
	ImDrawList_PopTextureID :: proc(self: ^Draw_List) ---;

	igInputTextWithHint     :: proc(label: cstring, hint: cstring, buf: cstring, buf_size: uint, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igGetFrameHeight        :: proc() -> f32 ---;
	igBeginTabBar           :: proc(str_id: cstring, flags: Tab_Bar_Flags) -> bool ---;
	igImageButton           :: proc(str_id: cstring, user_texture_id: Texture_ID, image_size: Vec2, uv0: Vec2, uv1: Vec2, bg_col: Vec4, tint_col: Vec4) -> bool ---;
	igTabItemButton         :: proc(label: cstring, flags: Tab_Item_Flags) -> bool ---;
	igSliderFloat2          :: proc(label: cstring, v: [2]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImFont_BuildLookupTable :: proc(self: ^ImFont) ---;

	igGetCurrentContext            :: proc() -> ^Context ---;
	igBeginPopupContextVoid        :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	ImFontAtlas_GetTexDataAsAlpha8 :: proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---;

	ImDrawData_Clear :: proc(self: ^Draw_Data) ---;

	ImFontAtlas_GetCustomRectByIndex :: proc(self: ^Font_Atlas, index: i32) -> ^Font_Atlas_Custom_Rect ---;

	igIsKeyDown_Nil         :: proc(key: Key) -> bool ---;
	ImDrawList_AddImageQuad :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, uv1: Vec2, uv2: Vec2, uv3: Vec2, uv4: Vec2, col: u32) ---;
	ImDrawList__PathArcToN  :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---;

	igGetColumnsCount                                :: proc() -> i32 ---;
	igSliderInt                                      :: proc(label: cstring, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igDragIntRange2                                  :: proc(label: cstring, v_current_min: ^i32, v_current_max: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, format_max: cstring, flags: Slider_Flags) -> bool ---;
	ImGuiSelectionBasicStorage_GetStorageIdFromIndex :: proc(self: ^Selection_Basic_Storage, idx: i32) -> ImID ---;

	igCloseCurrentPopup           :: proc() ---;
	igGetWindowDrawList           :: proc() -> ^Draw_List ---;
	igTableGetRowIndex            :: proc() -> i32 ---;
	igTextLink                    :: proc(label: cstring) -> bool ---;
	ImGuiIO_SetKeyEventNativeData :: proc(self: ^IO, key: Key, native_keycode: i32, native_scancode: i32, native_legacy_index: i32) ---;

	igGetItemRectSize               :: proc(pOut: ^Vec2) ---;
	igEndDragDropTarget             :: proc() ---;
	ImFontAtlas_GetGlyphRangesGreek :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igDragFloat3                               :: proc(label: cstring, v: [3]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igGetKeyPressedAmount                      :: proc(key: Key, repeat_delay: f32, rate: f32) -> i32 ---;
	igSmallButton                              :: proc(label: cstring) -> bool ---;
	igIsKeyPressed_Bool                        :: proc(key: Key, repeat: bool) -> bool ---;
	igSetScrollHereX                           :: proc(center_x_ratio: f32) ---;
	ImGuiSelectionBasicStorage_SetItemSelected :: proc(self: ^Selection_Basic_Storage, id: ImID, selected: bool) ---;

	igGetDrawListSharedData          :: proc() -> ^Draw_List_Shared_Data ---;
	igSetWindowPos_Vec2              :: proc(pos: Vec2, cond: Cond) ---;
	igSetWindowPos_Str               :: proc(name: cstring, pos: Vec2, cond: Cond) ---;
	igColumns                        :: proc(count: i32, id: cstring, borders: bool) ---;
	ImGuiSelectionBasicStorage_Clear :: proc(self: ^Selection_Basic_Storage) ---;

	igDebugTextEncoding         :: proc(text: cstring) ---;
	igGetFrameHeightWithSpacing :: proc() -> f32 ---;
	igMemFree                   :: proc(ptr: rawptr) ---;
	igBeginMainMenuBar          :: proc() -> bool ---;
	ImGuiIO_ClearInputMouse     :: proc(self: ^IO) ---;

	ImFontAtlas_AddCustomRectRegular :: proc(self: ^Font_Atlas, width: i32, height: i32) -> i32 ---;

	igArrowButton          :: proc(str_id: cstring, dir: Dir) -> bool ---;
	igDebugStartItemPicker :: proc() ---;
	ImFont_GetCharAdvance  :: proc(self: ^ImFont, c: Wchar) -> f32 ---;

	ImDrawList_AddCircleFilled :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32) ---;

	igColorEdit3          :: proc(label: cstring, col: [3]f32, flags: Color_Edit_Flags) -> bool ---;
	igPopTextWrapPos      :: proc() ---;
	ImGuiIO_AddFocusEvent :: proc(self: ^IO, focused: bool) ---;

	ImFontGlyphRangesBuilder_BuildRanges :: proc(self: ^Font_Glyph_Ranges_Builder, out_ranges: ^Im_Vector(Wchar)) ---;

	igDragInt3          :: proc(label: cstring, v: [3]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igGetTime           :: proc() -> f64 ---;
	igLogToFile         :: proc(auto_open_depth: i32, filename: cstring) ---;
	ImFont_AddRemapChar :: proc(self: ^ImFont, dst: Wchar, src: Wchar, overwrite_dst: bool) ---;

	igSetNextWindowSize         :: proc(size: Vec2, cond: Cond) ---;
	igIsMouseHoveringRect       :: proc(r_min: Vec2, r_max: Vec2, clip: bool) -> bool ---;
	igBeginPopupContextItem     :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	igGetForegroundDrawList_Nil :: proc() -> ^Draw_List ---;
	igGetColumnWidth            :: proc(column_index: i32) -> f32 ---;
	igEndMainMenuBar            :: proc() ---;
	igGetScrollX                :: proc() -> f32 ---;
	ImDrawList_AddRect          :: proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col: u32, rounding: f32, flags: Draw_Flags, thickness: f32) ---;

	igColorConvertU32ToFloat4      :: proc(pOut: ^Vec4, in_: u32) ---;
	igEndMenuBar                   :: proc() ---;
	ImFontGlyphRangesBuilder_Clear :: proc(self: ^Font_Glyph_Ranges_Builder) ---;

	ImDrawListSplitter_Split           :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, count: i32) ---;
	ImDrawListSplitter_ClearFreeMemory :: proc(self: ^Draw_List_Splitter) ---;

	igInputScalarN          :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImGuiPayload_IsDelivery :: proc(self: ^Payload) -> bool ---;

	ImGuiStorage_SetInt :: proc(self: ^Storage, key: ImID, val: i32) ---;

	ImGuiTextFilter_IsActive :: proc(self: ^Text_Filter) -> bool ---;

	igSetColumnOffset        :: proc(column_index: i32, offset_x: f32) ---;
	ImDrawList_AddRectFilled :: proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col: u32, rounding: f32, flags: Draw_Flags) ---;

	ImGuiTextFilter_Clear :: proc(self: ^Text_Filter) ---;

	ImGuiPayload_Clear :: proc(self: ^Payload) ---;

	igIsItemDeactivatedAfterEdit                      :: proc() -> bool ---;
	igGetAllocatorFunctions                           :: proc(p_alloc_func: ^Mem_Alloc_Func, p_free_func: ^Mem_Free_Func, p_user_data: ^rawptr) ---;
	igPushStyleVarX                                   :: proc(idx: Style_Var, val_x: f32) ---;
	igShowAboutWindow                                 :: proc(p_open: ^bool) ---;
	igTableSetColumnIndex                             :: proc(column_n: i32) -> bool ---;
	igGetMouseCursor                                  :: proc() -> Mouse_Cursor ---;
	igIsItemDeactivated                               :: proc() -> bool ---;
	ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igGetMouseDragDelta          :: proc(pOut: ^Vec2, button: Mouse_Button, lock_threshold: f32) ---;
	igLogText                    :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igIsPopupOpen_Str            :: proc(str_id: cstring, flags: Popup_Flags) -> bool ---;
	igEndDragDropSource          :: proc() ---;
	ImDrawList__PopUnusedDrawCmd :: proc(self: ^Draw_List) ---;

	ImGuiStorage_SetBool :: proc(self: ^Storage, key: ImID, val: bool) ---;

	ImFont_GrowIndex :: proc(self: ^ImFont, new_size: i32) ---;

	igBegin                       :: proc(name: cstring, p_open: ^bool, flags: Window_Flags) -> bool ---;
	igGetWindowPos                :: proc(pOut: ^Vec2) ---;
	igColorPicker4                :: proc(label: cstring, col: [4]f32, flags: Color_Edit_Flags, ref_col: ^f32) -> bool ---;
	igIsKeyChordPressed_Nil       :: proc(key_chord: Key_Chord) -> bool ---;
	igInputInt3                   :: proc(label: cstring, v: [3]i32, flags: Input_Text_Flags) -> bool ---;
	ImDrawList_AddQuadFilled      :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32) ---;
	ImDrawList_ChannelsSetCurrent :: proc(self: ^Draw_List, n: i32) ---;

	igGetWindowSize            :: proc(pOut: ^Vec2) ---;
	igGetStyleColorName        :: proc(idx: Col) -> cstring ---;
	igMemAlloc                 :: proc(size: uint) -> rawptr ---;
	igSetItemDefaultFocus      :: proc() ---;
	igIsMouseDoubleClicked_Nil :: proc(button: Mouse_Button) -> bool ---;
	igEndChild                 :: proc() ---;
	igIsAnyItemActive          :: proc() -> bool ---;
	igTableAngledHeadersRow    :: proc() ---;
	ImDrawListSplitter_Merge   :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List) ---;

	ImGuiViewport_GetCenter :: proc(pOut: ^Vec2, self: ^Viewport) ---;

	igInputDouble              :: proc(label: cstring, v: ^f64, step: f64, step_fast: f64, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igInvisibleButton          :: proc(str_id: cstring, size: Vec2, flags: Button_Flags) -> bool ---;
	igSetMouseCursor           :: proc(cursor_type: Mouse_Cursor) ---;
	igSetNextItemShortcut      :: proc(key_chord: Key_Chord, flags: Input_Flags) ---;
	igSelectable_Bool          :: proc(label: cstring, selected: bool, flags: Selectable_Flags, size: Vec2) -> bool ---;
	igSelectable_BoolPtr       :: proc(label: cstring, p_selected: ^bool, flags: Selectable_Flags, size: Vec2) -> bool ---;
	igSetNextWindowCollapsed   :: proc(collapsed: bool, cond: Cond) ---;
	igNewLine                  :: proc() ---;
	ImDrawList_PathFillConcave :: proc(self: ^Draw_List, col: u32) ---;

	ImGuiStorage_GetInt :: proc(self: ^Storage, key: ImID, default_val: i32) -> i32 ---;

	igGetFrameCount          :: proc() -> i32 ---;
	igSetNextItemStorageID   :: proc(storage_id: ImID) ---;
	igSliderFloat3           :: proc(label: cstring, v: [3]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSetKeyboardFocusHere   :: proc(offset: i32) ---;
	ImGuiStorage_GetFloatRef :: proc(self: ^Storage, key: ImID, default_val: f32) -> ^f32 ---;
	ImGuiStorage_GetVoidPtr  :: proc(self: ^Storage, key: ImID) -> rawptr ---;

	ImFontAtlas_AddFontFromMemoryCompressedBase85TTF :: proc(self: ^Font_Atlas, compressed_font_data_base85: cstring, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igIsItemClicked            :: proc(mouse_button: Mouse_Button) -> bool ---;
	ImFontAtlas_AddFontDefault :: proc(self: ^Font_Atlas, font_cfg: ^Font_Config) -> ^ImFont ---;

	igIsAnyItemHovered  :: proc() -> bool ---;
	igPopItemWidth      :: proc() ---;
	ImFontAtlas_AddFont :: proc(self: ^Font_Atlas, font_cfg: ^Font_Config) -> ^ImFont ---;

	igSetNextItemWidth               :: proc(item_width: f32) ---;
	ImFontAtlas_AddFontFromMemoryTTF :: proc(self: ^Font_Atlas, font_data: rawptr, font_data_size: i32, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igGetItemRectMax        :: proc(pOut: ^Vec2) ---;
	ImDrawList_PrimWriteVtx :: proc(self: ^Draw_List, pos: Vec2, uv: Vec2, col: u32) ---;

	igCalcItemWidth                :: proc() -> f32 ---;
	igPlotLines_FloatPtr           :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2, stride: i32) ---;
	igPlotLines_FnFloatPtr         :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2) ---
	ImFontAtlas_GetGlyphRangesThai :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igIsItemToggledSelection :: proc() -> bool ---;
	igInputFloat4            :: proc(label: cstring, v: [4]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImGuiTextBuffer_reserve  :: proc(self: ^Text_Buffer, capacity: i32) ---;

	igGetVersion          :: proc() -> cstring ---;
	igEndPopup            :: proc() ---;
	ImDrawList_AddEllipse :: proc(self: ^Draw_List, center: Vec2, radius: Vec2, col: u32, rot: f32, num_segments: i32, thickness: f32) ---;

	igTableHeadersRow     :: proc() ---;
	igGetFontSize         :: proc() -> f32 ---;
	igDragFloat2          :: proc(label: cstring, v: [2]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImDrawList_PathStroke :: proc(self: ^Draw_List, col: u32, flags: Draw_Flags, thickness: f32) ---;
	ImDrawList_PrimQuadUV :: proc(self: ^Draw_List, a: Vec2, b: Vec2, c: Vec2, d: Vec2, uv_a: Vec2, uv_b: Vec2, uv_c: Vec2, uv_d: Vec2, col: u32) ---;

	igSetScrollHereY           :: proc(center_y_ratio: f32) ---;
	ImGuiIO_AddMouseWheelEvent :: proc(self: ^IO, wheel_x: f32, wheel_y: f32) ---;

	ImGuiTextBuffer_c_str :: proc(self: ^Text_Buffer) -> cstring ---;

	igAlignTextToFramePadding :: proc() ---;
	ImGuiStorage_SetFloat     :: proc(self: ^Storage, key: ImID, val: f32) ---;

	igGetStyleColorVec4      :: proc(idx: Col) -> ^Vec4 ---;
	ImDrawList__SetTextureID :: proc(self: ^Draw_List, texture_id: Texture_ID) ---;

	igSliderFloat4        :: proc(label: cstring, v: [4]f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImGuiTextBuffer_clear :: proc(self: ^Text_Buffer) ---;

	ImDrawList_AddTriangle :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32, thickness: f32) ---;

	igSliderInt4              :: proc(label: cstring, v: [4]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igBeginMenuBar            :: proc() -> bool ---;
	ImGuiIO_AddKeyAnalogEvent :: proc(self: ^IO, key: Key, down: bool, v: f32) ---;

	igColorEdit4              :: proc(label: cstring, col: [4]f32, flags: Color_Edit_Flags) -> bool ---;
	igVSliderScalar           :: proc(label: cstring, size: Vec2, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	ImFont_IsGlyphRangeUnused :: proc(self: ^ImFont, c_begin: u32, c_last: u32) -> bool ---;

	igLoadIniSettingsFromMemory               :: proc(ini_data: cstring, ini_size: uint) ---;
	igGetCursorPos                            :: proc(pOut: ^Vec2) ---;
	igDragInt4                                :: proc(label: cstring, v: [4]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igShowUserGuide                           :: proc() ---;
	ImGuiInputTextCallbackData_ClearSelection :: proc(self: ^Input_Text_Callback_Data) ---;

	ImFontAtlas_GetGlyphRangesChineseFull :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	ImDrawList_AddEllipseFilled :: proc(self: ^Draw_List, center: Vec2, radius: Vec2, col: u32, rot: f32, num_segments: i32) ---;

	igTextUnformatted            :: proc(text: cstring, text_end: cstring) ---;
	igShowStyleSelector          :: proc(label: cstring) -> bool ---;
	ImDrawList__ResetForNewFrame :: proc(self: ^Draw_List) ---;

	igGetScrollY                       :: proc() -> f32 ---;
	ImFontAtlas_GetGlyphRangesJapanese :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igGetContentRegionAvail        :: proc(pOut: ^Vec2) ---;
	ImFontAtlas_GetTexDataAsRGBA32 :: proc(self: ^Font_Atlas, out_pixels: ^^u8, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---;

	igSetWindowFocus_Nil   :: proc() ---;
	igSetWindowFocus_Str   :: proc(name: cstring) ---;
	ImDrawList_PopClipRect :: proc(self: ^Draw_List) ---;

	ImGuiSelectionBasicStorage_Contains :: proc(self: ^Selection_Basic_Storage, id: ImID) -> bool ---;

	ImFontAtlas_CalcCustomRectUV      :: proc(self: ^Font_Atlas, rect: ^Font_Atlas_Custom_Rect, out_uv_min: ^Vec2, out_uv_max: ^Vec2) ---;
	ImFontAtlas_GetGlyphRangesDefault :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igIsWindowCollapsed                 :: proc() -> bool ---;
	ImGuiListClipper_IncludeItemByIndex :: proc(self: ^List_Clipper, item_index: i32) ---;

	ImGuiStorage_GetFloat :: proc(self: ^Storage, key: ImID, default_val: f32) -> f32 ---;

	igTableGetColumnFlags          :: proc(column_n: i32) -> Table_Column_Flags ---;
	ImDrawList__OnChangedVtxOffset :: proc(self: ^Draw_List) ---;

	ImDrawCmd_GetTexID :: proc(self: ^Draw_Cmd) -> Texture_ID ---;

	igBeginPopup         :: proc(str_id: cstring, flags: Window_Flags) -> bool ---;
	igSetWindowSize_Vec2 :: proc(size: Vec2, cond: Cond) ---;
	igSetWindowSize_Str  :: proc(name: cstring, size: Vec2, cond: Cond) ---;
	igIsItemFocused      :: proc() -> bool ---;
	ImDrawList_PathRect  :: proc(self: ^Draw_List, rect_min: Vec2, rect_max: Vec2, rounding: f32, flags: Draw_Flags) ---;

	igBeginTabItem          :: proc(label: cstring, p_open: ^bool, flags: Tab_Item_Flags) -> bool ---;
	igTableGetSortSpecs     :: proc() -> ^Table_Sort_Specs ---;
	igPushItemFlag          :: proc(option: Item_Flags, enabled: bool) ---;
	igTableGetHoveredColumn :: proc() -> i32 ---;
	igEndTable              :: proc() ---;
	ImDrawList_PathArcTo    :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---;

	igDragScalar                       :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igDummy                            :: proc(size: Vec2) ---;
	igInputFloat                       :: proc(label: cstring, v: ^f32, step: f32, step_fast: f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igIsKeyReleased_Nil                :: proc(key: Key) -> bool ---;
	ImFontAtlas_GetGlyphRangesCyrillic :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	igSetNextItemOpen        :: proc(is_open: bool, cond: Cond) ---;
	igStyleColorsDark        :: proc(dst: ^Style) ---;
	igGetCursorStartPos      :: proc(pOut: ^Vec2) ---;
	igGetItemRectMin         :: proc(pOut: ^Vec2) ---;
	igGetFontTexUvWhitePixel :: proc(pOut: ^Vec2) ---;
	igPopItemFlag            :: proc() ---;
	igIsWindowHovered        :: proc(flags: Hovered_Flags) -> bool ---;
	igTableSetupScrollFreeze :: proc(cols: i32, rows: i32) ---;
	igInputInt4              :: proc(label: cstring, v: [4]i32, flags: Input_Text_Flags) -> bool ---;
	ImDrawList_ChannelsMerge :: proc(self: ^Draw_List) ---;

	ImGuiListClipper_IncludeItemsByIndex :: proc(self: ^List_Clipper, item_begin: i32, item_end: i32) ---;

	igDragFloat                :: proc(label: cstring, v: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igTextColored              :: proc(col: Vec4, fmt_: cstring, #c_vararg args: ..any) ---;
	igIsMouseClicked_Bool      :: proc(button: Mouse_Button, repeat: bool) -> bool ---;
	igPushClipRect             :: proc(clip_rect_min: Vec2, clip_rect_max: Vec2, intersect_with_current_clip_rect: bool) ---;
	ImGuiTextFilter_PassFilter :: proc(self: ^Text_Filter, text: cstring, text_end: cstring) -> bool ---;

	igUnindent                 :: proc(indent_w: f32) ---;
	igSetScrollX_Float         :: proc(scroll_x: f32) ---;
	ImDrawList_AddImageRounded :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: Vec2, p_max: Vec2, uv_min: Vec2, uv_max: Vec2, col: u32, rounding: f32, flags: Draw_Flags) ---;

	igGetItemID                 :: proc() -> ImID ---;
	igGetScrollMaxX             :: proc() -> f32 ---;
	igBeginDragDropSource       :: proc(flags: Drag_Drop_Flags) -> bool ---;
	igText                      :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igGetIO                     :: proc() -> ^IO ---;
	igEndTabItem                :: proc() ---;
	igSetStateStorage           :: proc(storage: ^Storage) ---;
	igShowFontSelector          :: proc(label: cstring) ---;
	igAcceptDragDropPayload     :: proc(type: cstring, flags: Drag_Drop_Flags) -> ^Payload ---;
	ImGuiStorage_BuildSortByKey :: proc(self: ^Storage) ---;

	igIsItemToggledOpen  :: proc() -> bool ---;
	igIsItemActive       :: proc() -> bool ---;
	igStyleColorsClassic :: proc(dst: ^Style) ---;
	igLabelText          :: proc(label: cstring, fmt_: cstring, #c_vararg args: ..any) ---;
	igSetDragDropPayload :: proc(type: cstring, data: rawptr, sz: uint, cond: Cond) -> bool ---;
	igLogToTTY           :: proc(auto_open_depth: i32) ---;
	ImFont_RenderChar    :: proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: Vec2, col: u32, c: Wchar) ---;

	igBullet                              :: proc() ---;
	ImDrawList_PathBezierQuadraticCurveTo :: proc(self: ^Draw_List, p2: Vec2, p3: Vec2, num_segments: i32) ---;
	ImDrawList_PrimRect                   :: proc(self: ^Draw_List, a: Vec2, b: Vec2, col: u32) ---;

	igPushStyleColor_U32      :: proc(idx: Col, col: u32) ---;
	igPushStyleColor_Vec4     :: proc(idx: Col, col: Vec4) ---;
	igSeparator               :: proc() ---;
	igDebugLog                :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igEndMultiSelect          :: proc() -> ^Multi_Select_Io ---;
	igSliderAngle             :: proc(label: cstring, v_rad: ^f32, v_degrees_min: f32, v_degrees_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igButton                  :: proc(label: cstring, size: Vec2) -> bool ---;
	ImGuiIO_AddInputCharacter :: proc(self: ^IO, c: u32) ---;

	igSetNextWindowSizeConstraints :: proc(size_min: Vec2, size_max: Vec2, custom_callback: Size_Callback, custom_callback_data: rawptr) ---;
	ImGuiViewport_GetWorkCenter    :: proc(pOut: ^Vec2, self: ^Viewport) ---;

	ImGuiListClipper_Begin :: proc(self: ^List_Clipper, items_count: i32, items_height: f32) ---;

	ImFontAtlas_AddCustomRectFontGlyph :: proc(self: ^Font_Atlas, font: ^ImFont, id: Wchar, width: i32, height: i32, advance_x: f32, offset: Vec2) -> i32 ---;

	igSliderScalarN                 :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igPopClipRect                   :: proc() ---;
	ImFontGlyphRangesBuilder_SetBit :: proc(self: ^Font_Glyph_Ranges_Builder, n: uint) ---;

	igGetTextLineHeight    :: proc() -> f32 ---;
	ImFont_SetGlyphVisible :: proc(self: ^ImFont, c: Wchar, visible: bool) ---;

	igSetAllocatorFunctions :: proc(alloc_func: Alloc_Func, free_func: Free_Func) ---
	igIsAnyMouseDown        :: proc() -> bool ---;
	ImFont_AddGlyph         :: proc(self: ^ImFont, src_cfg: ^Font_Config, c: Wchar, x0: f32, y0: f32, x1: f32, y1: f32, u0: f32, v0: f32, u1: f32, v1: f32, advance_x: f32) ---;

	igTableSetColumnEnabled          :: proc(column_n: i32, v: bool) ---;
	igEndTabBar                      :: proc() ---;
	igDebugCheckVersionAndDataLayout :: proc(version_str: cstring, sz_io: uint, sz_style: uint, sz_vec2: uint, sz_vec4: uint, sz_drawvert: uint, sz_drawidx: uint) -> bool ---;
	igEndFrame                       :: proc() ---;
	ImDrawList_PrimReserve           :: proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) ---;

	ImGuiIO_AddKeyEvent :: proc(self: ^IO, key: Key, down: bool) ---;

	ImFontAtlas_Clear :: proc(self: ^Font_Atlas) ---;

	ImDrawList_AddCallback :: proc(self: ^Draw_List, callback: Draw_Callback, callback_data: rawptr) ---;

	ImGuiStorage_GetIntRef :: proc(self: ^Storage, key: ImID, default_val: i32) -> ^i32 ---;

	ImGuiIO_AddMouseSourceEvent :: proc(self: ^IO, source: Mouse_Source) ---;

	ImDrawList_PushTextureID :: proc(self: ^Draw_List, texture_id: Texture_ID) ---;

	igIsMouseDown_Nil                    :: proc(button: Mouse_Button) -> bool ---;
	igSetWindowFontScale                 :: proc(scale: f32) ---;
	igSetColumnWidth                     :: proc(column_index: i32, width: f32) ---;
	ImGuiInputTextCallbackData_SelectAll :: proc(self: ^Input_Text_Callback_Data) ---;

	igDragScalarN              :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, components: i32, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	ImFont_FindGlyphNoFallback :: proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph ---;

	ImDrawList_AddNgonFilled :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32) ---;

	igSaveIniSettingsToMemory :: proc(out_ini_size: ^uint) -> cstring ---;
	igDragFloat4              :: proc(label: cstring, v: [4]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImGuiTextBuffer_empty     :: proc(self: ^Text_Buffer) -> bool ---;

	ImGuiSelectionBasicStorage_ApplyRequests :: proc(self: ^Selection_Basic_Storage, ms_io: ^Multi_Select_Io) ---;

	ImDrawList__OnChangedTextureID :: proc(self: ^Draw_List) ---;

	igIsWindowAppearing              :: proc() -> bool ---;
	igSetCurrentContext              :: proc(ctx: ^Context) ---;
	igGetDragDropPayload             :: proc() -> ^Payload ---;
	igIsItemEdited                   :: proc() -> bool ---;
	igCollapsingHeader_TreeNodeFlags :: proc(label: cstring, flags: Tree_Node_Flags) -> bool ---;
	igCollapsingHeader_BoolPtr       :: proc(label: cstring, p_visible: ^bool, flags: Tree_Node_Flags) -> bool ---;
	igValue_Bool                     :: proc(prefix: cstring, b: bool) ---;
	igValue_Int                      :: proc(prefix: cstring, v: i32) ---;
	igValue_Uint                     :: proc(prefix: cstring, v: u32) ---;
	igValue_Float                    :: proc(prefix: cstring, v: f32, float_format: cstring) ---;
	igSetNextWindowScroll            :: proc(scroll: Vec2) ---;
	igCreateContext                  :: proc(shared_font_atlas: ^Font_Atlas) -> ^Context ---;
	igEndMenu                        :: proc() ---;
	igPopStyleVar                    :: proc(count: i32) ---;
	igBeginMenu                      :: proc(label: cstring, enabled: bool) -> bool ---;
	igEnd                            :: proc() ---;
	igTableHeader                    :: proc(label: cstring) ---;
	ImDrawListSplitter_Clear         :: proc(self: ^Draw_List_Splitter) ---;

	igTableGetColumnIndex         :: proc() -> i32 ---;
	igLogButtons                  :: proc() ---;
	ImDrawList__OnChangedClipRect :: proc(self: ^Draw_List) ---;

	igStyleColorsLight :: proc(dst: ^Style) ---;
	igLogFinish        :: proc() ---;
	ImColor_HSV        :: proc(pOut: ^Color, h: f32, s: f32, v: f32, a: f32) ---;

	ImGuiIO_AddInputCharactersUTF8 :: proc(self: ^IO, str: cstring) ---;

	igSetCursorScreenPos      :: proc(pos: Vec2) ---;
	igColorConvertFloat4ToU32 :: proc(in_: Vec4) -> u32 ---;
	igPushTextWrapPos         :: proc(wrap_local_pos_x: f32) ---;
	igGetWindowHeight         :: proc() -> f32 ---;
	ImDrawList_GetClipRectMin :: proc(pOut: ^Vec2, self: ^Draw_List) ---;
	ImDrawList_PrimRectUV     :: proc(self: ^Draw_List, a: Vec2, b: Vec2, uv_a: Vec2, uv_b: Vec2, col: u32) ---;

	igGetStyle                           :: proc() -> ^Style ---;
	ImDrawListSplitter_SetCurrentChannel :: proc(self: ^Draw_List_Splitter, draw_list: ^Draw_List, channel_idx: i32) ---;

	igSetNextWindowFocus           :: proc() ---;
	igDebugFlashStyleColor         :: proc(idx: Col) ---;
	igSetNextItemSelectionUserData :: proc(selection_user_data: Selection_User_Data) ---;
	ImDrawList__TryMergeDrawCmds   :: proc(self: ^Draw_List) ---;

	igSetScrollY_Float :: proc(scroll_y: f32) ---;
	igShowDemoWindow   :: proc(p_open: ^bool) ---;
	igPopStyleColor    :: proc(count: i32) ---;
	ImColor_SetHSV     :: proc(self: ^Color, h: f32, s: f32, v: f32, a: f32) ---;

	ImDrawList_AddLine :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, col: u32, thickness: f32) ---;

	ImGuiStorage_GetVoidPtrRef :: proc(self: ^Storage, key: ImID, default_val: rawptr) -> ^rawptr ---;

	ImFontGlyphRangesBuilder_GetBit :: proc(self: ^Font_Glyph_Ranges_Builder, n: uint) -> bool ---;

	ImFont_GetDebugName :: proc(self: ^ImFont) -> cstring ---;

	igGetScrollMaxY      :: proc() -> f32 ---;
	igSetNextWindowPos   :: proc(pos: Vec2, cond: Cond, pivot: Vec2) ---;
	ImGuiTextRange_empty :: proc(self: ^Text_Range) -> bool ---;
	ImGuiTextRange_split :: proc(self: ^Text_Range, separator: i8, out: ^Im_Vector(Text_Range)) ---;

	ImFont_CalcWordWrapPositionA :: proc(self: ^ImFont, scale: f32, text: cstring, text_end: cstring, wrap_width: f32) -> cstring ---;

	igBeginDragDropTarget :: proc() -> bool ---;
	igTextLinkOpenURL     :: proc(label: cstring, url: cstring) ---;
	igEndCombo            :: proc() ---;
	ImFont_RenderText     :: proc(self: ^ImFont, draw_list: ^Draw_List, size: f32, pos: Vec2, col: u32, clip_rect: Vec4, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip: bool) ---;

	igGetWindowWidth        :: proc() -> f32 ---;
	ImDrawList_PrimWriteIdx :: proc(self: ^Draw_List, idx: Draw_Idx) ---;

	igSetCursorPosY        :: proc(local_y: f32) ---;
	ImGuiStorage_SetAllInt :: proc(self: ^Storage, val: i32) ---;

	ImFontAtlas_AddFontFromFileTTF :: proc(self: ^Font_Atlas, filename: cstring, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igBeginTable         :: proc(str_id: cstring, columns: i32, flags: Table_Flags, outer_size: Vec2, inner_width: f32) -> bool ---;
	ImFontAtlas_SetTexID :: proc(self: ^Font_Atlas, id: Texture_ID) ---;

	ImDrawList_GetClipRectMax :: proc(pOut: ^Vec2, self: ^Draw_List) ---;

	ImGuiInputTextCallbackData_HasSelection :: proc(self: ^Input_Text_Callback_Data) -> bool ---;

	igMenuItem_Bool                :: proc(label: cstring, shortcut: cstring, selected: bool, enabled: bool) -> bool ---;
	igMenuItem_BoolPtr             :: proc(label: cstring, shortcut: cstring, p_selected: ^bool, enabled: bool) -> bool ---;
	igSliderInt3                   :: proc(label: cstring, v: [3]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igInputTextMultiline           :: proc(label: cstring, buf: cstring, buf_size: uint, size: Vec2, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igSliderFloat                  :: proc(label: cstring, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	igListBox_Str_arr              :: proc(label: cstring, current_item: ^i32, items: cstring, items_count: i32, height_in_items: i32) -> bool ---;
	igListBox_FnStrPtr             :: proc(label: cstring, current_item: ^i32, getter: ^^cstring, user_data: rawptr, items_count: i32, height_in_items: i32) -> bool ---;
	ImDrawList_AddConvexPolyFilled :: proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32) ---;

	igPopID                                     :: proc() ---;
	igSpacing                                   :: proc() ---;
	igTableSetBgColor                           :: proc(target: Table_Bg_Target, color: u32, column_n: i32) ---;
	igSameLine                                  :: proc(offset_from_start_x: f32, spacing: f32) ---;
	ImGuiSelectionExternalStorage_ApplyRequests :: proc(self: ^Selection_External_Storage, ms_io: ^Multi_Select_Io) ---;

	igVSliderFloat            :: proc(label: cstring, size: Vec2, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImDrawData_ScaleClipRects :: proc(self: ^Draw_Data, fb_scale: Vec2) ---;

	igGetBackgroundDrawList_Nil        :: proc() -> ^Draw_List ---;
	ImDrawList_AddRectFilledMultiColor :: proc(self: ^Draw_List, p_min: Vec2, p_max: Vec2, col_upr_left: u32, col_upr_right: u32, col_bot_right: u32, col_bot_left: u32) ---;

	igIsMouseDragging                  :: proc(button: Mouse_Button, lock_threshold: f32) -> bool ---;
	ImFontGlyphRangesBuilder_AddRanges :: proc(self: ^Font_Glyph_Ranges_Builder, ranges: ^Wchar) ---;

	igCheckboxFlags_IntPtr  :: proc(label: cstring, flags: ^i32, flags_value: i32) -> bool ---;
	igCheckboxFlags_UintPtr :: proc(label: cstring, flags: ^u32, flags_value: u32) -> bool ---;
	igBeginListBox          :: proc(label: cstring, size: Vec2) -> bool ---;
	ImDrawList_AddCircle    :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32, thickness: f32) ---;

	igGetColumnIndex       :: proc() -> i32 ---;
	igTextWrapped          :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	ImDrawList_AddPolyline :: proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32, flags: Draw_Flags, thickness: f32) ---;

	ImFontAtlas_GetMouseCursorTexData :: proc(self: ^Font_Atlas, cursor: Mouse_Cursor, out_offset: ^Vec2, out_size: ^Vec2, out_uv_border: [2]Vec2, out_uv_fill: [2]Vec2) -> bool ---;

	igBeginTooltip                :: proc() -> bool ---;
	ImGuiIO_SetAppAcceptingEvents :: proc(self: ^IO, accepting_events: bool) ---;

	ImDrawList_AddImage :: proc(self: ^Draw_List, user_texture_id: Texture_ID, p_min: Vec2, p_max: Vec2, uv_min: Vec2, uv_max: Vec2, col: u32) ---;

	ImGuiTextFilter_Draw :: proc(self: ^Text_Filter, label: cstring, width: f32) -> bool ---;

	igGetMousePosOnOpeningCurrentPopup :: proc(pOut: ^Vec2) ---;
	igTableGetColumnName_Int           :: proc(column_n: i32) -> cstring ---;
	ImDrawList_AddDrawCmd              :: proc(self: ^Draw_List) ---;

	igShowIDStackToolWindow        :: proc(p_open: ^bool) ---;
	igLogToClipboard               :: proc(auto_open_depth: i32) ---;
	igIsItemActivated              :: proc() -> bool ---;
	ImGuiIO_AddInputCharacterUTF16 :: proc(self: ^IO, c: Wchar16) ---;

	igIsMousePosValid     :: proc(mouse_pos: ^Vec2) -> bool ---;
	igGetCursorPosY       :: proc() -> f32 ---;
	ImGuiListClipper_Step :: proc(self: ^List_Clipper) -> bool ---;

	ImGuiPayload_IsDataType :: proc(self: ^Payload, type: cstring) -> bool ---;

	ImGuiInputTextCallbackData_DeleteChars :: proc(self: ^Input_Text_Callback_Data, pos: i32, bytes_count: i32) ---;

	igSetScrollFromPosX_Float   :: proc(local_x: f32, center_x_ratio: f32) ---;
	ImDrawList__ClearFreeMemory :: proc(self: ^Draw_List) ---;

	ImFont_FindGlyph :: proc(self: ^ImFont, c: Wchar) -> ^Font_Glyph ---;

	igLoadIniSettingsFromDisk   :: proc(ini_filename: cstring) ---;
	igBeginPopupContextWindow   :: proc(str_id: cstring, popup_flags: Popup_Flags) -> bool ---;
	ImDrawList__PathArcToFastEx :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min_sample: i32, a_max_sample: i32, a_step: i32) ---;

	igInputFloat3              :: proc(label: cstring, v: [3]f32, format: cstring, flags: Input_Text_Flags) -> bool ---;
	igSetNextWindowContentSize :: proc(size: Vec2) ---;
	igVSliderInt               :: proc(label: cstring, size: Vec2, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	ImDrawList_PushClipRect    :: proc(self: ^Draw_List, clip_rect_min: Vec2, clip_rect_max: Vec2, intersect_with_current_clip_rect: bool) ---;

	igSetClipboardText              :: proc(text: cstring) ---;
	igGetCursorScreenPos            :: proc(pOut: ^Vec2) ---;
	igEndDisabled                   :: proc() ---;
	igGetMouseClickedCount          :: proc(button: Mouse_Button) -> i32 ---;
	ImDrawList_AddConcavePolyFilled :: proc(self: ^Draw_List, points: ^Vec2, num_points: i32, col: u32) ---;

	ImGuiListClipper_End :: proc(self: ^List_Clipper) ---;

	ImGuiPayload_IsPreview :: proc(self: ^Payload) -> bool ---;

	ImDrawList_PushClipRectFullScreen :: proc(self: ^Draw_List) ---;

	igGetColumnOffset            :: proc(column_index: i32) -> f32 ---;
	ImDrawData_DeIndexAllBuffers :: proc(self: ^Draw_Data) ---;

	ImDrawList_PathClear :: proc(self: ^Draw_List) ---;

	igGetClipboardText     :: proc() -> cstring ---;
	igPushFont             :: proc(font: ^ImFont) ---;
	ImFont_ClearOutputData :: proc(self: ^ImFont) ---;

	igTableGetColumnCount                :: proc() -> i32 ---;
	ImFontAtlas_GetGlyphRangesVietnamese :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	ImGuiStorage_Clear :: proc(self: ^Storage) ---;

	igOpenPopupOnItemClick :: proc(str_id: cstring, popup_flags: Popup_Flags) ---;
	ImFontAtlas_ClearFonts :: proc(self: ^Font_Atlas) ---;

	igProgressBar                                  :: proc(fraction: f32, size_arg: Vec2, overlay: cstring) ---;
	igSetItemTooltip                               :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igGetMousePos                                  :: proc(pOut: ^Vec2) ---;
	igNewFrame                                     :: proc() ---;
	igTableSetupColumn                             :: proc(label: cstring, flags: Table_Column_Flags, init_width_or_weight: f32, user_id: ImID) ---;
	ImGuiSelectionBasicStorage_GetNextSelectedItem :: proc(self: ^Selection_Basic_Storage, opaque_it: ^rawptr, out_id: ^ImID) -> bool ---;

	igGetKeyName             :: proc(key: Key) -> cstring ---;
	ImDrawList_PathArcToFast :: proc(self: ^Draw_List, center: Vec2, radius: f32, a_min_of_12: i32, a_max_of_12: i32) ---;

	igSetColorEditOptions    :: proc(flags: Color_Edit_Flags) ---;
	igCalcTextSize           :: proc(pOut: ^Vec2, text: cstring, text_end: cstring, hide_text_after_double_hash: bool, wrap_width: f32) ---;
	igRadioButton_Bool       :: proc(label: cstring, active: bool) -> bool ---;
	igRadioButton_IntPtr     :: proc(label: cstring, v: ^i32, v_button: i32) -> bool ---;
	ImGuiStyle_ScaleAllSizes :: proc(self: ^Style, scale_factor: f32) ---;

	ImFontGlyphRangesBuilder_AddChar :: proc(self: ^Font_Glyph_Ranges_Builder, c: Wchar) ---;

	ImDrawList_AddText_Vec2    :: proc(self: ^Draw_List, pos: Vec2, col: u32, text_begin: cstring, text_end: cstring) ---;
	ImDrawList_AddText_FontPtr :: proc(self: ^Draw_List, font: ^ImFont, font_size: f32, pos: Vec2, col: u32, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip_rect: ^Vec4) ---;
	ImDrawList_AddQuad         :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32, thickness: f32) ---;

	igShortcut_Nil       :: proc(key_chord: Key_Chord, flags: Input_Flags) -> bool ---;
	ImGuiStorage_GetBool :: proc(self: ^Storage, key: ImID, default_val: bool) -> bool ---;

	ImDrawList_PathLineToMergeDuplicate :: proc(self: ^Draw_List, pos: Vec2) ---;

	ImFontAtlas_IsBuilt :: proc(self: ^Font_Atlas) -> bool ---;

	igIsAnyItemFocused        :: proc() -> bool ---;
	igResetMouseDragDelta     :: proc(button: Mouse_Button) ---;
	ImDrawList_AddBezierCubic :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, col: u32, thickness: f32, num_segments: i32) ---;

	igIsWindowFocused        :: proc(flags: Focused_Flags) -> bool ---;
	igGetColorU32_Col        :: proc(idx: Col, alpha_mul: f32) -> u32 ---;
	igGetColorU32_Vec4       :: proc(col: Vec4) -> u32 ---;
	igGetColorU32_U32        :: proc(col: u32, alpha_mul: f32) -> u32 ---;
	ImGuiIO_ClearEventsQueue :: proc(self: ^IO) ---;

	igColorPicker3               :: proc(label: cstring, col: [3]f32, flags: Color_Edit_Flags) -> bool ---;
	ImDrawList_AddTriangleFilled :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32) ---;

	ImGuiInputTextCallbackData_InsertChars :: proc(self: ^Input_Text_Callback_Data, pos: i32, text: cstring, text_end: cstring) ---;

	igSetNextFrameWantCaptureKeyboard  :: proc(want_capture_keyboard: bool) ---;
	ImGuiListClipper_SeekCursorForItem :: proc(self: ^List_Clipper, item_index: i32) ---;

	igGetTextLineHeightWithSpacing :: proc() -> f32 ---;
	ImDrawList_ChannelsSplit       :: proc(self: ^Draw_List, count: i32) ---;

	ImFontAtlas_ClearInputData :: proc(self: ^Font_Atlas) ---;

	igSetWindowCollapsed_Bool :: proc(collapsed: bool, cond: Cond) ---;
	igSetWindowCollapsed_Str  :: proc(name: cstring, collapsed: bool, cond: Cond) ---;
	ImFont_IsLoaded           :: proc(self: ^ImFont) -> bool ---;

	igGetMainViewport      :: proc() -> ^Viewport ---;
	ImDrawData_AddDrawList :: proc(self: ^Draw_Data, draw_list: ^Draw_List) ---;

	igSetItemKeyOwner_Nil    :: proc(key: Key) ---;
	igSaveIniSettingsToDisk  :: proc(ini_filename: cstring) ---;
	igInputScalar            :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: Input_Text_Flags) -> bool ---;
	ImDrawList_PrimUnreserve :: proc(self: ^Draw_List, idx_count: i32, vtx_count: i32) ---;

	ImFontAtlas_ClearTexData :: proc(self: ^Font_Atlas) ---;

	ImGuiTextBuffer_size :: proc(self: ^Text_Buffer) -> i32 ---;

	igImage                           :: proc(user_texture_id: Texture_ID, image_size: Vec2, uv0: Vec2, uv1: Vec2, tint_col: Vec4, border_col: Vec4) ---;
	ImDrawList_PathBezierCubicCurveTo :: proc(self: ^Draw_List, p2: Vec2, p3: Vec2, p4: Vec2, num_segments: i32) ---;

	igSetCursorPosX            :: proc(local_x: f32) ---;
	igPlotHistogram_FloatPtr   :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2, stride: i32) ---;
	igPlotHistogram_FnFloatPtr :: proc(label: cstring, values_getter: Value_Getter_Proc, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: Vec2) ---
	igShowMetricsWindow        :: proc(p_open: ^bool) ---;
	ImDrawList_PathLineTo      :: proc(self: ^Draw_List, pos: Vec2) ---;
	ImDrawList_AddNgon         :: proc(self: ^Draw_List, center: Vec2, radius: f32, col: u32, num_segments: i32, thickness: f32) ---;

	ImFontAtlas_AddFontFromMemoryCompressedTTF :: proc(self: ^Font_Atlas, compressed_font_data: rawptr, compressed_font_data_size: i32, size_pixels: f32, font_cfg: ^Font_Config, glyph_ranges: ^Wchar) -> ^ImFont ---;

	igSeparatorText                :: proc(label: cstring) ---;
	ImFontAtlasCustomRect_IsPacked :: proc(self: ^Font_Atlas_Custom_Rect) -> bool ---;

	igCheckbox                       :: proc(label: cstring, v: ^bool) -> bool ---;
	igRender                         :: proc() ---;
	igSliderInt2                     :: proc(label: cstring, v: [2]i32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igCombo_Str_arr                  :: proc(label: cstring, current_item: ^i32, items: ^cstring, items_count: i32, popup_max_height_in_items: i32) -> bool ---
	igCombo_Str                      :: proc(label: cstring, current_item: ^i32, items_separated_by_zeros: cstring, popup_max_height_in_items: i32) -> bool ---;
	igCombo_FnStrPtr                 :: proc(label: cstring, current_item: ^i32, getter: ^^cstring, user_data: rawptr, items_count: i32, popup_max_height_in_items: i32) -> bool ---;
	igSetTabItemClosed               :: proc(tab_or_docked_window_label: cstring) ---;
	ImFontAtlas_GetGlyphRangesKorean :: proc(self: ^Font_Atlas) -> ^Wchar ---;

	ImFontGlyphRangesBuilder_AddText :: proc(self: ^Font_Glyph_Ranges_Builder, text: cstring, text_end: cstring) ---;

	ImGuiTextBuffer_begin :: proc(self: ^Text_Buffer) -> cstring ---;

	ImDrawList_PathFillConvex :: proc(self: ^Draw_List, col: u32) ---;

	igIsMouseReleased_Nil :: proc(button: Mouse_Button) -> bool ---;
	igDragInt2            :: proc(label: cstring, v: [2]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igSliderScalar        :: proc(label: cstring, data_type: Data_Type, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: Slider_Flags) -> bool ---;
	igIsItemHovered       :: proc(flags: Hovered_Flags) -> bool ---;
	igEndTooltip          :: proc() ---;
	ImDrawList_PrimVtx    :: proc(self: ^Draw_List, pos: Vec2, uv: Vec2, col: u32) ---;

	igGetStateStorage              :: proc() -> ^Storage ---;
	igNextColumn                   :: proc() ---;
	igEndListBox                   :: proc() ---;
	igTableNextColumn              :: proc() -> bool ---;
	igPopFont                      :: proc() ---;
	igGetPlatformIO                :: proc() -> ^Platform_Io ---;
	igInputText                    :: proc(label: cstring, buf: cstring, buf_size: uint, flags: Input_Text_Flags, callback: Input_Text_Callback, user_data: rawptr) -> bool ---;
	igSetNextFrameWantCaptureMouse :: proc(want_capture_mouse: bool) ---;
	ImGuiStorage_SetVoidPtr        :: proc(self: ^Storage, key: ImID, val: rawptr) ---;

	igIsItemVisible          :: proc() -> bool ---;
	igShowDebugLogWindow     :: proc(p_open: ^bool) ---;
	igColorButton            :: proc(desc_id: cstring, col: Vec4, flags: Color_Edit_Flags, size: Vec2) -> bool ---;
	igDragInt                :: proc(label: cstring, v: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: Slider_Flags) -> bool ---;
	igGetDrawData            :: proc() -> ^Draw_Data ---;
	ImGuiIO_AddMousePosEvent :: proc(self: ^IO, x: f32, y: f32) ---;

	igSetNextWindowBgAlpha         :: proc(alpha: f32) ---;
	igPushID_Str                   :: proc(str_id: cstring) ---;
	igPushID_StrStr                :: proc(str_id_begin: cstring, str_id_end: cstring) ---;
	igPushID_Ptr                   :: proc(ptr_id: rawptr) ---;
	igPushID_Int                   :: proc(int_id: i32) ---;
	igTreePush_Str                 :: proc(str_id: cstring) ---;
	igTreePush_Ptr                 :: proc(ptr_id: rawptr) ---;
	igBeginItemTooltip             :: proc() -> bool ---;
	igColorConvertRGBtoHSV         :: proc(r: f32, g: f32, b: f32, out_h: ^f32, out_s: ^f32, out_v: ^f32) ---;
	ImDrawList_PathEllipticalArcTo :: proc(self: ^Draw_List, center: Vec2, radius: Vec2, rot: f32, a_min: f32, a_max: f32, num_segments: i32) ---;

	igTreePop              :: proc() ---;
	igGetID_Str            :: proc(str_id: cstring) -> ImID ---;
	igGetID_StrStr         :: proc(str_id_begin: cstring, str_id_end: cstring) -> ImID ---;
	igGetID_Ptr            :: proc(ptr_id: rawptr) -> ImID ---;
	igGetID_Int            :: proc(int_id: i32) -> ImID ---;
	ImDrawList_CloneOutput :: proc(self: ^Draw_List) -> ^Draw_List ---;

	igTableNextRow      :: proc(row_flags: Table_Row_Flags, min_row_height: f32) ---;
	igIndent            :: proc(indent_w: f32) ---;
	ImGuiTextBuffer_end :: proc(self: ^Text_Buffer) -> cstring ---;

	igPushStyleVarY               :: proc(idx: Style_Var, val_y: f32) ---;
	igGetFont                     :: proc() -> ^ImFont ---;
	igPushStyleVar_Float          :: proc(idx: Style_Var, val: f32) ---;
	igPushStyleVar_Vec2           :: proc(idx: Style_Var, val: Vec2) ---;
	ImDrawList_AddBezierQuadratic :: proc(self: ^Draw_List, p1: Vec2, p2: Vec2, p3: Vec2, col: u32, thickness: f32, num_segments: i32) ---;

	igBulletText              :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igTextDisabled            :: proc(fmt_: cstring, #c_vararg args: ..any) ---;
	igBeginPopupModal         :: proc(name: cstring, p_open: ^bool, flags: Window_Flags) -> bool ---;
	igSetNextItemAllowOverlap :: proc() ---;
	igShowStyleEditor         :: proc(ref: ^Style) ---;
	igTreeNode_Str            :: proc(label: cstring) -> bool ---;
	igTreeNode_StrStr         :: proc(str_id: cstring, fmt_: cstring, #c_vararg args: ..any) -> bool ---;
	igTreeNode_Ptr            :: proc(ptr_id: rawptr, fmt_: cstring, #c_vararg args: ..any) -> bool ---;

}
