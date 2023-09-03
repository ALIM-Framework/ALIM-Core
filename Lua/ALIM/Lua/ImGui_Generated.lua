--------------------------------------------------------------------------------
-- File: ImGui_Generated.lua
-- Created: 2023-09-03 16:34:16
-- License: http://beamng.com/bCDDL-1.1.txt
--------------------------------------------------------------------------------

local C = ffi.C

return function(M)

function M.GetCurrentContext() return C.ImGui_GetCurrentContext() end
function M.SetCurrentContext() C.ImGui_SetCurrentContext() end
function M.GetIO() return C.ImGui_GetIO() end
function M.GetStyle() return C.ImGui_GetStyle() end
function M.NewFrame() C.ImGui_NewFrame() end
function M.EndFrame() C.ImGui_EndFrame() end
function M.Render() C.ImGui_Render() end
function M.GetDrawData() return C.ImGui_GetDrawData() end
function M.ShowDemoWindow(bool_p_open)
  -- bool_p_open is optional and can be nil
  C.ImGui_ShowDemoWindow(bool_p_open)
end
function M.ShowMetricsWindow(bool_p_open)
  -- bool_p_open is optional and can be nil
  C.ImGui_ShowMetricsWindow(bool_p_open)
end
function M.ShowAboutWindow(bool_p_open)
  -- bool_p_open is optional and can be nil
  C.ImGui_ShowAboutWindow(bool_p_open)
end
function M.ShowStyleEditor(ImGuiStyle_ref)
  -- ImGuiStyle_ref is optional and can be nil
  C.ImGui_ShowStyleEditor(ImGuiStyle_ref)
end
function M.ShowStyleSelector(string_label)
  if string_label == nil then  return end
  return C.ImGui_ShowStyleSelector(string_label)
end
function M.ShowFontSelector(string_label)
  if string_label == nil then  return end
  C.ImGui_ShowFontSelector(string_label)
end
function M.ShowUserGuide() C.ImGui_ShowUserGuide() end
function M.GetVersion() return C.ImGui_GetVersion() end
function M.StyleColorsDark(ImGuiStyle_dst)
  -- ImGuiStyle_dst is optional and can be nil
  C.ImGui_StyleColorsDark(ImGuiStyle_dst)
end
function M.StyleColorsLight(ImGuiStyle_dst)
  -- ImGuiStyle_dst is optional and can be nil
  C.ImGui_StyleColorsLight(ImGuiStyle_dst)
end
function M.StyleColorsClassic(ImGuiStyle_dst)
  -- ImGuiStyle_dst is optional and can be nil
  C.ImGui_StyleColorsClassic(ImGuiStyle_dst)
end
function M.Begin(string_name, bool_p_open, ImGuiWindowFlags_flags)
  -- bool_p_open is optional and can be nil
  if ImGuiWindowFlags_flags == nil then ImGuiWindowFlags_flags = 0 end
  if string_name == nil then  return end
  return C.ImGui_Begin(string_name, bool_p_open, ImGuiWindowFlags_flags)
end
function M.End() C.ImGui_End() end
function M.BeginChild1(string_str_id, ImVec2_size, bool_border, ImGuiWindowFlags_flags)
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if bool_border == nil then bool_border = false end
  if ImGuiWindowFlags_flags == nil then ImGuiWindowFlags_flags = 0 end
  if string_str_id == nil then  return end
  return C.ImGui_BeginChild1(string_str_id, ImVec2_size, bool_border, ImGuiWindowFlags_flags)
end
function M.BeginChild2(ImGuiID_id, ImVec2_size, bool_border, ImGuiWindowFlags_flags)
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if bool_border == nil then bool_border = false end
  if ImGuiWindowFlags_flags == nil then ImGuiWindowFlags_flags = 0 end
  return C.ImGui_BeginChild2(ImGuiID_id, ImVec2_size, bool_border, ImGuiWindowFlags_flags)
end
function M.EndChild() C.ImGui_EndChild() end
function M.IsWindowAppearing() return C.ImGui_IsWindowAppearing() end
function M.IsWindowCollapsed() return C.ImGui_IsWindowCollapsed() end
function M.IsWindowFocused(ImGuiFocusedFlags_flags)
  if ImGuiFocusedFlags_flags == nil then ImGuiFocusedFlags_flags = 0 end
  return C.ImGui_IsWindowFocused(ImGuiFocusedFlags_flags)
end
function M.IsWindowHovered(ImGuiHoveredFlags_flags)
  if ImGuiHoveredFlags_flags == nil then ImGuiHoveredFlags_flags = 0 end
  return C.ImGui_IsWindowHovered(ImGuiHoveredFlags_flags)
end
function M.GetWindowDrawList() return C.ImGui_GetWindowDrawList() end
function M.GetWindowDpiScale() return C.ImGui_GetWindowDpiScale() end
function M.GetWindowViewport() return C.ImGui_GetWindowViewport() end
function M.GetWindowPos() return C.ImGui_GetWindowPos() end
function M.GetWindowSize() return C.ImGui_GetWindowSize() end
function M.GetWindowWidth() return C.ImGui_GetWindowWidth() end
function M.GetWindowHeight() return C.ImGui_GetWindowHeight() end
function M.SetNextWindowPos(ImVec2_pos, ImGuiCond_cond, ImVec2_pivot)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  if ImVec2_pivot == nil then ImVec2_pivot = M.ImVec2(0,0) end
  C.ImGui_SetNextWindowPos(ImVec2_pos, ImGuiCond_cond, ImVec2_pivot)
end
function M.SetNextWindowSize(ImVec2_size, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  C.ImGui_SetNextWindowSize(ImVec2_size, ImGuiCond_cond)
end
function M.SetNextWindowSizeConstraints(ImVec2_size_min, ImVec2_size_max, ImGuiSizeCallback_custom_callback, void_custom_callback_data)
  -- ImGuiSizeCallback_custom_callback is optional and can be nil
  -- void_custom_callback_data is optional and can be nil
  C.ImGui_SetNextWindowSizeConstraints(ImVec2_size_min, ImVec2_size_max, ImGuiSizeCallback_custom_callback, void_custom_callback_data)
end
function M.SetNextWindowContentSize(ImVec2_size) C.ImGui_SetNextWindowContentSize(ImVec2_size) end
function M.SetNextWindowCollapsed(bool_collapsed, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  C.ImGui_SetNextWindowCollapsed(bool_collapsed, ImGuiCond_cond)
end
function M.SetNextWindowFocus() C.ImGui_SetNextWindowFocus() end
function M.SetNextWindowBgAlpha(float_alpha) C.ImGui_SetNextWindowBgAlpha(float_alpha) end
function M.SetNextWindowViewport(ImGuiID_viewport_id) C.ImGui_SetNextWindowViewport(ImGuiID_viewport_id) end
function M.SetWindowPos1(ImVec2_pos, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  C.ImGui_SetWindowPos1(ImVec2_pos, ImGuiCond_cond)
end
function M.SetWindowSize1(ImVec2_size, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  C.ImGui_SetWindowSize1(ImVec2_size, ImGuiCond_cond)
end
function M.SetWindowCollapsed1(bool_collapsed, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  C.ImGui_SetWindowCollapsed1(bool_collapsed, ImGuiCond_cond)
end
function M.SetWindowFocus1() C.ImGui_SetWindowFocus1() end
function M.SetWindowFontScale(float_scale) C.ImGui_SetWindowFontScale(float_scale) end
function M.SetWindowPos2(string_name, ImVec2_pos, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  if string_name == nil then  return end
  C.ImGui_SetWindowPos2(string_name, ImVec2_pos, ImGuiCond_cond)
end
function M.SetWindowSize2(string_name, ImVec2_size, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  if string_name == nil then  return end
  C.ImGui_SetWindowSize2(string_name, ImVec2_size, ImGuiCond_cond)
end
function M.SetWindowCollapsed2(string_name, bool_collapsed, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  if string_name == nil then  return end
  C.ImGui_SetWindowCollapsed2(string_name, bool_collapsed, ImGuiCond_cond)
end
function M.SetWindowFocus2(string_name)
  if string_name == nil then  return end
  C.ImGui_SetWindowFocus2(string_name)
end
function M.GetContentRegionAvail() return C.ImGui_GetContentRegionAvail() end
function M.GetContentRegionMax() return C.ImGui_GetContentRegionMax() end
function M.GetWindowContentRegionMin() return C.ImGui_GetWindowContentRegionMin() end
function M.GetWindowContentRegionMax() return C.ImGui_GetWindowContentRegionMax() end
function M.GetWindowContentRegionWidth() return C.ImGui_GetWindowContentRegionWidth() end
function M.GetScrollX() return C.ImGui_GetScrollX() end
function M.GetScrollY() return C.ImGui_GetScrollY() end
function M.SetScrollX(float_scroll_x) C.ImGui_SetScrollX(float_scroll_x) end
function M.SetScrollY(float_scroll_y) C.ImGui_SetScrollY(float_scroll_y) end
function M.GetScrollMaxX() return C.ImGui_GetScrollMaxX() end
function M.GetScrollMaxY() return C.ImGui_GetScrollMaxY() end
function M.SetScrollHereX(float_center_x_ratio)
  if float_center_x_ratio == nil then float_center_x_ratio = 0.5 end
  C.ImGui_SetScrollHereX(float_center_x_ratio)
end
function M.SetScrollHereY(float_center_y_ratio)
  if float_center_y_ratio == nil then float_center_y_ratio = 0.5 end
  C.ImGui_SetScrollHereY(float_center_y_ratio)
end
function M.SetScrollFromPosX(float_local_x, float_center_x_ratio)
  if float_center_x_ratio == nil then float_center_x_ratio = 0.5 end
  C.ImGui_SetScrollFromPosX(float_local_x, float_center_x_ratio)
end
function M.SetScrollFromPosY(float_local_y, float_center_y_ratio)
  if float_center_y_ratio == nil then float_center_y_ratio = 0.5 end
  C.ImGui_SetScrollFromPosY(float_local_y, float_center_y_ratio)
end
function M.PushFont(ImFont_font)
  if ImFont_font == nil then  return end
  C.ImGui_PushFont(ImFont_font)
end
function M.PopFont() C.ImGui_PopFont() end
function M.PushStyleColor1(ImGuiCol_idx, ImU32_col) C.ImGui_PushStyleColor1(ImGuiCol_idx, ImU32_col) end
function M.PushStyleColor2(ImGuiCol_idx, ImVec4_col) C.ImGui_PushStyleColor2(ImGuiCol_idx, ImVec4_col) end
function M.PopStyleColor(int_count)
  if int_count == nil then int_count = 1 end
  C.ImGui_PopStyleColor(int_count)
end
function M.PushStyleVar1(ImGuiStyleVar_idx, float_val) C.ImGui_PushStyleVar1(ImGuiStyleVar_idx, float_val) end
function M.PushStyleVar2(ImGuiStyleVar_idx, ImVec2_val) C.ImGui_PushStyleVar2(ImGuiStyleVar_idx, ImVec2_val) end
function M.PopStyleVar(int_count)
  if int_count == nil then int_count = 1 end
  C.ImGui_PopStyleVar(int_count)
end
function M.PushAllowKeyboardFocus(bool_allow_keyboard_focus) C.ImGui_PushAllowKeyboardFocus(bool_allow_keyboard_focus) end
function M.PopAllowKeyboardFocus() C.ImGui_PopAllowKeyboardFocus() end
function M.PushButtonRepeat(_repeat) C.ImGui_PushButtonRepeat(_repeat) end
function M.PopButtonRepeat() C.ImGui_PopButtonRepeat() end
function M.PushItemWidth(float_item_width) C.ImGui_PushItemWidth(float_item_width) end
function M.PopItemWidth() C.ImGui_PopItemWidth() end
function M.SetNextItemWidth(float_item_width) C.ImGui_SetNextItemWidth(float_item_width) end
function M.CalcItemWidth() return C.ImGui_CalcItemWidth() end
function M.PushTextWrapPos(float_wrap_local_pos_x)
  if float_wrap_local_pos_x == nil then float_wrap_local_pos_x = 0 end
  C.ImGui_PushTextWrapPos(float_wrap_local_pos_x)
end
function M.PopTextWrapPos() C.ImGui_PopTextWrapPos() end
function M.GetFont() return C.ImGui_GetFont() end
function M.GetFontSize() return C.ImGui_GetFontSize() end
function M.GetFontTexUvWhitePixel() return C.ImGui_GetFontTexUvWhitePixel() end
function M.GetColorU321(ImGuiCol_idx, float_alpha_mul)
  if float_alpha_mul == nil then float_alpha_mul = 1 end
  return C.ImGui_GetColorU321(ImGuiCol_idx, float_alpha_mul)
end
function M.GetColorU322(ImVec4_col) return C.ImGui_GetColorU322(ImVec4_col) end
function M.GetColorU323(ImU32_col) return C.ImGui_GetColorU323(ImU32_col) end
function M.GetStyleColorVec4(ImGuiCol_idx) return C.ImGui_GetStyleColorVec4(ImGuiCol_idx) end
function M.Separator() C.ImGui_Separator() end
function M.SameLine(float_offset_from_start_x, float_spacing)
  if float_offset_from_start_x == nil then float_offset_from_start_x = 0 end
  if float_spacing == nil then float_spacing = -1 end
  C.ImGui_SameLine(float_offset_from_start_x, float_spacing)
end
function M.NewLine() C.ImGui_NewLine() end
function M.Spacing() C.ImGui_Spacing() end
function M.Dummy(ImVec2_size) C.ImGui_Dummy(ImVec2_size) end
function M.Indent(float_indent_w)
  if float_indent_w == nil then float_indent_w = 0 end
  C.ImGui_Indent(float_indent_w)
end
function M.Unindent(float_indent_w)
  if float_indent_w == nil then float_indent_w = 0 end
  C.ImGui_Unindent(float_indent_w)
end
function M.BeginGroup() C.ImGui_BeginGroup() end
function M.EndGroup() C.ImGui_EndGroup() end
function M.GetCursorPos() return C.ImGui_GetCursorPos() end
function M.GetCursorPosX() return C.ImGui_GetCursorPosX() end
function M.GetCursorPosY() return C.ImGui_GetCursorPosY() end
function M.SetCursorPos(ImVec2_local_pos) C.ImGui_SetCursorPos(ImVec2_local_pos) end
function M.SetCursorPosX(float_local_x) C.ImGui_SetCursorPosX(float_local_x) end
function M.SetCursorPosY(float_local_y) C.ImGui_SetCursorPosY(float_local_y) end
function M.GetCursorStartPos() return C.ImGui_GetCursorStartPos() end
function M.GetCursorScreenPos() return C.ImGui_GetCursorScreenPos() end
function M.SetCursorScreenPos(ImVec2_pos) C.ImGui_SetCursorScreenPos(ImVec2_pos) end
function M.AlignTextToFramePadding() C.ImGui_AlignTextToFramePadding() end
function M.GetTextLineHeight() return C.ImGui_GetTextLineHeight() end
function M.GetTextLineHeightWithSpacing() return C.ImGui_GetTextLineHeightWithSpacing() end
function M.GetFrameHeight() return C.ImGui_GetFrameHeight() end
function M.GetFrameHeightWithSpacing() return C.ImGui_GetFrameHeightWithSpacing() end
function M.PushID1(string_str_id)
  if string_str_id == nil then  return end
  C.ImGui_PushID1(string_str_id)
end
function M.PushID2(string_str_id_begin, string_str_id_end)
  if string_str_id_begin == nil then  return end
  if string_str_id_end == nil then  return end
  C.ImGui_PushID2(string_str_id_begin, string_str_id_end)
end
function M.PushID3(void_ptr_id)
  if void_ptr_id == nil then  return end
  C.ImGui_PushID3(void_ptr_id)
end
function M.PushID4(int_int_id) C.ImGui_PushID4(int_int_id) end
function M.PopID() C.ImGui_PopID() end
function M.GetID1(string_str_id)
  if string_str_id == nil then  return end
  return C.ImGui_GetID1(string_str_id)
end
function M.GetID2(string_str_id_begin, string_str_id_end)
  if string_str_id_begin == nil then  return end
  if string_str_id_end == nil then  return end
  return C.ImGui_GetID2(string_str_id_begin, string_str_id_end)
end
function M.GetID3(void_ptr_id)
  if void_ptr_id == nil then  return end
  return C.ImGui_GetID3(void_ptr_id)
end
function M.TextUnformatted(string_text, string_text_end)
  -- string_text_end is optional and can be nil
  if string_text == nil then  return end
  C.ImGui_TextUnformatted(string_text, string_text_end)
end
function M.Text(string_fmt, ...)
  if string_fmt == nil then  return end
  C.ImGui_Text(string_fmt, ...)
end
function M.TextV(string_fmt, va_list_args)
  if string_fmt == nil then  return end
  C.ImGui_TextV(string_fmt, va_list_args)
end
function M.TextColored(ImVec4_col, string_fmt, ...)
  if string_fmt == nil then  return end
  C.ImGui_TextColored(ImVec4_col, string_fmt, ...)
end
function M.TextColoredV(ImVec4_col, string_fmt, va_list_args)
  if string_fmt == nil then  return end
  C.ImGui_TextColoredV(ImVec4_col, string_fmt, va_list_args)
end
function M.TextDisabled(string_fmt, ...)
  if string_fmt == nil then  return end
  C.ImGui_TextDisabled(string_fmt, ...)
end
function M.TextDisabledV(string_fmt, va_list_args)
  if string_fmt == nil then  return end
  C.ImGui_TextDisabledV(string_fmt, va_list_args)
end
function M.TextWrapped(string_fmt, ...)
  if string_fmt == nil then  return end
  C.ImGui_TextWrapped(string_fmt, ...)
end
function M.TextWrappedV(string_fmt, va_list_args)
  if string_fmt == nil then  return end
  C.ImGui_TextWrappedV(string_fmt, va_list_args)
end
function M.LabelText(string_label, string_fmt, ...)
  if string_label == nil then  return end
  if string_fmt == nil then  return end
  C.ImGui_LabelText(string_label, string_fmt, ...)
end
function M.LabelTextV(string_label, string_fmt, va_list_args)
  if string_label == nil then  return end
  if string_fmt == nil then  return end
  C.ImGui_LabelTextV(string_label, string_fmt, va_list_args)
end
function M.BulletText(string_fmt, ...)
  if string_fmt == nil then  return end
  C.ImGui_BulletText(string_fmt, ...)
end
function M.BulletTextV(string_fmt, va_list_args)
  if string_fmt == nil then  return end
  C.ImGui_BulletTextV(string_fmt, va_list_args)
end
function M.Button(string_label, ImVec2_size)
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if string_label == nil then  return end
  return C.ImGui_Button(string_label, ImVec2_size)
end
function M.SmallButton(string_label)
  if string_label == nil then  return end
  return C.ImGui_SmallButton(string_label)
end
function M.InvisibleButton(string_str_id, ImVec2_size, ImGuiButtonFlags_flags)
  if ImGuiButtonFlags_flags == nil then ImGuiButtonFlags_flags = 0 end
  if string_str_id == nil then  return end
  return C.ImGui_InvisibleButton(string_str_id, ImVec2_size, ImGuiButtonFlags_flags)
end
function M.ArrowButton(string_str_id, ImGuiDir_dir)
  if string_str_id == nil then  return end
  return C.ImGui_ArrowButton(string_str_id, ImGuiDir_dir)
end
function M.Image(ImTextureID_user_texture_id, ImVec2_size, ImVec2_uv0, ImVec2_uv1, ImVec4_tint_col, ImVec4_border_col)
  if ImVec2_uv0 == nil then ImVec2_uv0 = M.ImVec2(0,0) end
  if ImVec2_uv1 == nil then ImVec2_uv1 = M.ImVec2(1,1) end
  if ImVec4_tint_col == nil then ImVec4_tint_col = M.ImVec4(1,1,1,1) end
  if ImVec4_border_col == nil then ImVec4_border_col = M.ImVec4(0,0,0,0) end
  C.ImGui_Image(ImTextureID_user_texture_id, ImVec2_size, ImVec2_uv0, ImVec2_uv1, ImVec4_tint_col, ImVec4_border_col)
end
function M.ImageButton(ImTextureID_user_texture_id, ImVec2_size, ImVec2_uv0, ImVec2_uv1, int_frame_padding, ImVec4_bg_col, ImVec4_tint_col)
  if ImVec2_uv0 == nil then ImVec2_uv0 = M.ImVec2(0,0) end
  if ImVec2_uv1 == nil then ImVec2_uv1 = M.ImVec2(1,1) end
  if int_frame_padding == nil then int_frame_padding = -1 end
  if ImVec4_bg_col == nil then ImVec4_bg_col = M.ImVec4(0,0,0,0) end
  if ImVec4_tint_col == nil then ImVec4_tint_col = M.ImVec4(1,1,1,1) end
  return C.ImGui_ImageButton(ImTextureID_user_texture_id, ImVec2_size, ImVec2_uv0, ImVec2_uv1, int_frame_padding, ImVec4_bg_col, ImVec4_tint_col)
end
function M.Checkbox(string_label, bool_v)
  if string_label == nil then  return end
  if bool_v == nil then  return end
  return C.ImGui_Checkbox(string_label, bool_v)
end
function M.CheckboxFlags1(string_label, int_flags, int_flags_value)
  if string_label == nil then  return end
  if int_flags == nil then  return end
  return C.ImGui_CheckboxFlags1(string_label, int_flags, int_flags_value)
end
function M.CheckboxFlags2(string_label, int_flags, int_flags_value)
  if string_label == nil then  return end
  if int_flags == nil then  return end
  return C.ImGui_CheckboxFlags2(string_label, int_flags, int_flags_value)
end
function M.RadioButton1(string_label, bool_active)
  if string_label == nil then  return end
  return C.ImGui_RadioButton1(string_label, bool_active)
end
function M.RadioButton2(string_label, int_v, int_v_button)
  if string_label == nil then  return end
  if int_v == nil then  return end
  return C.ImGui_RadioButton2(string_label, int_v, int_v_button)
end
function M.ProgressBar(float_fraction, ImVec2_size_arg, string_overlay)
  if ImVec2_size_arg == nil then ImVec2_size_arg = M.ImVec2(-FLT_MIN,0) end
  -- string_overlay is optional and can be nil
  C.ImGui_ProgressBar(float_fraction, ImVec2_size_arg, string_overlay)
end
function M.Bullet() C.ImGui_Bullet() end
function M.BeginCombo(string_label, string_preview_value, ImGuiComboFlags_flags)
  if ImGuiComboFlags_flags == nil then ImGuiComboFlags_flags = 0 end
  if string_label == nil then  return end
  if string_preview_value == nil then  return end
  return C.ImGui_BeginCombo(string_label, string_preview_value, ImGuiComboFlags_flags)
end
function M.EndCombo() C.ImGui_EndCombo() end
function M.Combo1(string_label, int_current_item, charconstPtr_items, int_items_count, int_popup_max_height_in_items)
  if int_popup_max_height_in_items == nil then int_popup_max_height_in_items = -1 end
  if string_label == nil then  return end
  if int_current_item == nil then  return end
  if charconstPtr_items == nil then  return end
  return C.ImGui_Combo1(string_label, int_current_item, charconstPtr_items, int_items_count, int_popup_max_height_in_items)
end
function M.Combo2(string_label, int_current_item, string_items_separated_by_zeros, int_popup_max_height_in_items)
  if int_popup_max_height_in_items == nil then int_popup_max_height_in_items = -1 end
  if string_label == nil then  return end
  if int_current_item == nil then  return end
  if string_items_separated_by_zeros == nil then  return end
  return C.ImGui_Combo2(string_label, int_current_item, string_items_separated_by_zeros, int_popup_max_height_in_items)
end
function M.Combo3(string_label, int_current_item, functionPtr_items_getter, void_data, int_items_count, int_popup_max_height_in_items)
  if int_popup_max_height_in_items == nil then int_popup_max_height_in_items = -1 end
  if string_label == nil then  return end
  if int_current_item == nil then  return end
  if functionPtr_items_getter == nil then  return end
  if void_data == nil then  return end
  return C.ImGui_Combo3(string_label, int_current_item, functionPtr_items_getter, void_data, int_items_count, int_popup_max_height_in_items)
end
function M.DragFloat(string_label, float_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if float_v_min == nil then float_v_min = 0 end
  if float_v_max == nil then float_v_max = 0 end
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if float_v == nil then  return end
  return C.ImGui_DragFloat(string_label, float_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragFloat2(string_label, floatPtr_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if float_v_min == nil then float_v_min = 0 end
  if float_v_max == nil then float_v_max = 0 end
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_DragFloat2(string_label, floatPtr_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragFloat3(string_label, floatPtr_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if float_v_min == nil then float_v_min = 0 end
  if float_v_max == nil then float_v_max = 0 end
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_DragFloat3(string_label, floatPtr_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragFloat4(string_label, floatPtr_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if float_v_min == nil then float_v_min = 0 end
  if float_v_max == nil then float_v_max = 0 end
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_DragFloat4(string_label, floatPtr_v, float_v_speed, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragFloatRange2(string_label, float_v_current_min, float_v_current_max, float_v_speed, float_v_min, float_v_max, string_format, string_format_max, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if float_v_min == nil then float_v_min = 0 end
  if float_v_max == nil then float_v_max = 0 end
  if string_format == nil then string_format = "%.3f" end
  -- string_format_max is optional and can be nil
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if float_v_current_min == nil then  return end
  if float_v_current_max == nil then  return end
  return C.ImGui_DragFloatRange2(string_label, float_v_current_min, float_v_current_max, float_v_speed, float_v_min, float_v_max, string_format, string_format_max, ImGuiSliderFlags_flags)
end
function M.DragInt(string_label, int_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if int_v_min == nil then int_v_min = 0 end
  if int_v_max == nil then int_v_max = 0 end
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if int_v == nil then  return end
  return C.ImGui_DragInt(string_label, int_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragInt2(string_label, intPtr_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if int_v_min == nil then int_v_min = 0 end
  if int_v_max == nil then int_v_max = 0 end
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_DragInt2(string_label, intPtr_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragInt3(string_label, intPtr_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if int_v_min == nil then int_v_min = 0 end
  if int_v_max == nil then int_v_max = 0 end
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_DragInt3(string_label, intPtr_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragInt4(string_label, intPtr_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if int_v_min == nil then int_v_min = 0 end
  if int_v_max == nil then int_v_max = 0 end
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_DragInt4(string_label, intPtr_v, float_v_speed, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragIntRange2(string_label, int_v_current_min, int_v_current_max, float_v_speed, int_v_min, int_v_max, string_format, string_format_max, ImGuiSliderFlags_flags)
  if float_v_speed == nil then float_v_speed = 1 end
  if int_v_min == nil then int_v_min = 0 end
  if int_v_max == nil then int_v_max = 0 end
  if string_format == nil then string_format = "%d" end
  -- string_format_max is optional and can be nil
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if int_v_current_min == nil then  return end
  if int_v_current_max == nil then  return end
  return C.ImGui_DragIntRange2(string_label, int_v_current_min, int_v_current_max, float_v_speed, int_v_min, int_v_max, string_format, string_format_max, ImGuiSliderFlags_flags)
end
function M.DragScalar(string_label, ImGuiDataType_data_type, void_p_data, float_v_speed, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
  -- void_p_min is optional and can be nil
  -- void_p_max is optional and can be nil
  -- string_format is optional and can be nil
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if void_p_data == nil then  return end
  return C.ImGui_DragScalar(string_label, ImGuiDataType_data_type, void_p_data, float_v_speed, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
end
function M.DragScalarN(string_label, ImGuiDataType_data_type, void_p_data, int_components, float_v_speed, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
  -- void_p_min is optional and can be nil
  -- void_p_max is optional and can be nil
  -- string_format is optional and can be nil
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if void_p_data == nil then  return end
  return C.ImGui_DragScalarN(string_label, ImGuiDataType_data_type, void_p_data, int_components, float_v_speed, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderFloat(string_label, float_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if float_v == nil then  return end
  return C.ImGui_SliderFloat(string_label, float_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderFloat2(string_label, floatPtr_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_SliderFloat2(string_label, floatPtr_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderFloat3(string_label, floatPtr_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_SliderFloat3(string_label, floatPtr_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderFloat4(string_label, floatPtr_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_SliderFloat4(string_label, floatPtr_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderAngle(string_label, float_v_rad, float_v_degrees_min, float_v_degrees_max, string_format, ImGuiSliderFlags_flags)
  if float_v_degrees_min == nil then float_v_degrees_min = -360 end
  if float_v_degrees_max == nil then float_v_degrees_max = 360 end
  if string_format == nil then string_format = "%.0f deg" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if float_v_rad == nil then  return end
  return C.ImGui_SliderAngle(string_label, float_v_rad, float_v_degrees_min, float_v_degrees_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderInt(string_label, int_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if int_v == nil then  return end
  return C.ImGui_SliderInt(string_label, int_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderInt2(string_label, intPtr_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_SliderInt2(string_label, intPtr_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderInt3(string_label, intPtr_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_SliderInt3(string_label, intPtr_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderInt4(string_label, intPtr_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_SliderInt4(string_label, intPtr_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderScalar(string_label, ImGuiDataType_data_type, void_p_data, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
  -- string_format is optional and can be nil
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if void_p_data == nil then  return end
  if void_p_min == nil then  return end
  if void_p_max == nil then  return end
  return C.ImGui_SliderScalar(string_label, ImGuiDataType_data_type, void_p_data, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
end
function M.SliderScalarN(string_label, ImGuiDataType_data_type, void_p_data, int_components, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
  -- string_format is optional and can be nil
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if void_p_data == nil then  return end
  if void_p_min == nil then  return end
  if void_p_max == nil then  return end
  return C.ImGui_SliderScalarN(string_label, ImGuiDataType_data_type, void_p_data, int_components, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
end
function M.VSliderFloat(string_label, ImVec2_size, float_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if float_v == nil then  return end
  return C.ImGui_VSliderFloat(string_label, ImVec2_size, float_v, float_v_min, float_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.VSliderInt(string_label, ImVec2_size, int_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
  if string_format == nil then string_format = "%d" end
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if int_v == nil then  return end
  return C.ImGui_VSliderInt(string_label, ImVec2_size, int_v, int_v_min, int_v_max, string_format, ImGuiSliderFlags_flags)
end
function M.VSliderScalar(string_label, ImVec2_size, ImGuiDataType_data_type, void_p_data, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
  -- string_format is optional and can be nil
  if ImGuiSliderFlags_flags == nil then ImGuiSliderFlags_flags = 0 end
  if string_label == nil then  return end
  if void_p_data == nil then  return end
  if void_p_min == nil then  return end
  if void_p_max == nil then  return end
  return C.ImGui_VSliderScalar(string_label, ImVec2_size, ImGuiDataType_data_type, void_p_data, void_p_min, void_p_max, string_format, ImGuiSliderFlags_flags)
end
function M.InputText(string_label, string_buf, size_t_buf_size, ImGuiInputTextFlags_flags, ImGuiInputTextCallback_callback, void_user_data)
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  -- ImGuiInputTextCallback_callback is optional and can be nil
  -- void_user_data is optional and can be nil
  if string_label == nil then  return end
  if string_buf == nil then  return end
  return C.ImGui_InputText(string_label, string_buf, size_t_buf_size, ImGuiInputTextFlags_flags, ImGuiInputTextCallback_callback, void_user_data)
end
function M.InputTextMultiline(string_label, string_buf, size_t_buf_size, ImVec2_size, ImGuiInputTextFlags_flags, ImGuiInputTextCallback_callback, void_user_data)
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  -- ImGuiInputTextCallback_callback is optional and can be nil
  -- void_user_data is optional and can be nil
  if string_label == nil then  return end
  if string_buf == nil then  return end
  return C.ImGui_InputTextMultiline(string_label, string_buf, size_t_buf_size, ImVec2_size, ImGuiInputTextFlags_flags, ImGuiInputTextCallback_callback, void_user_data)
end
function M.InputTextWithHint(string_label, string_hint, string_buf, size_t_buf_size, ImGuiInputTextFlags_flags, ImGuiInputTextCallback_callback, void_user_data)
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  -- ImGuiInputTextCallback_callback is optional and can be nil
  -- void_user_data is optional and can be nil
  if string_label == nil then  return end
  if string_hint == nil then  return end
  if string_buf == nil then  return end
  return C.ImGui_InputTextWithHint(string_label, string_hint, string_buf, size_t_buf_size, ImGuiInputTextFlags_flags, ImGuiInputTextCallback_callback, void_user_data)
end
function M.InputFloat(string_label, float_v, float_step, float_step_fast, string_format, ImGuiInputTextFlags_flags)
  if float_step == nil then float_step = 0 end
  if float_step_fast == nil then float_step_fast = 0 end
  if string_format == nil then string_format = "%.3f" end
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  if float_v == nil then  return end
  return C.ImGui_InputFloat(string_label, float_v, float_step, float_step_fast, string_format, ImGuiInputTextFlags_flags)
end
function M.InputFloat2(string_label, floatPtr_v, string_format, ImGuiInputTextFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_InputFloat2(string_label, floatPtr_v, string_format, ImGuiInputTextFlags_flags)
end
function M.InputFloat3(string_label, floatPtr_v, string_format, ImGuiInputTextFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_InputFloat3(string_label, floatPtr_v, string_format, ImGuiInputTextFlags_flags)
end
function M.InputFloat4(string_label, floatPtr_v, string_format, ImGuiInputTextFlags_flags)
  if string_format == nil then string_format = "%.3f" end
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_InputFloat4(string_label, floatPtr_v, string_format, ImGuiInputTextFlags_flags)
end
function M.InputInt(string_label, int_v, int_step, int_step_fast, ImGuiInputTextFlags_flags)
  if int_step == nil then int_step = 1 end
  if int_step_fast == nil then int_step_fast = 100 end
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  if int_v == nil then  return end
  return C.ImGui_InputInt(string_label, int_v, int_step, int_step_fast, ImGuiInputTextFlags_flags)
end
function M.InputInt2(string_label, intPtr_v, ImGuiInputTextFlags_flags)
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_InputInt2(string_label, intPtr_v, ImGuiInputTextFlags_flags)
end
function M.InputInt3(string_label, intPtr_v, ImGuiInputTextFlags_flags)
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_InputInt3(string_label, intPtr_v, ImGuiInputTextFlags_flags)
end
function M.InputInt4(string_label, intPtr_v, ImGuiInputTextFlags_flags)
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_InputInt4(string_label, intPtr_v, ImGuiInputTextFlags_flags)
end
function M.InputDouble(string_label, double_v, double_step, double_step_fast, string_format, ImGuiInputTextFlags_flags)
  if double_step == nil then double_step = 0 end
  if double_step_fast == nil then double_step_fast = 0 end
  if string_format == nil then string_format = "%.6f" end
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  if double_v == nil then  return end
  return C.ImGui_InputDouble(string_label, double_v, double_step, double_step_fast, string_format, ImGuiInputTextFlags_flags)
end
function M.InputScalar(string_label, ImGuiDataType_data_type, void_p_data, void_p_step, void_p_step_fast, string_format, ImGuiInputTextFlags_flags)
  -- void_p_step is optional and can be nil
  -- void_p_step_fast is optional and can be nil
  -- string_format is optional and can be nil
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  if void_p_data == nil then  return end
  return C.ImGui_InputScalar(string_label, ImGuiDataType_data_type, void_p_data, void_p_step, void_p_step_fast, string_format, ImGuiInputTextFlags_flags)
end
function M.InputScalarN(string_label, ImGuiDataType_data_type, void_p_data, int_components, void_p_step, void_p_step_fast, string_format, ImGuiInputTextFlags_flags)
  -- void_p_step is optional and can be nil
  -- void_p_step_fast is optional and can be nil
  -- string_format is optional and can be nil
  if ImGuiInputTextFlags_flags == nil then ImGuiInputTextFlags_flags = 0 end
  if string_label == nil then  return end
  if void_p_data == nil then  return end
  return C.ImGui_InputScalarN(string_label, ImGuiDataType_data_type, void_p_data, int_components, void_p_step, void_p_step_fast, string_format, ImGuiInputTextFlags_flags)
end
function M.ColorEdit3(string_label, floatPtr_col, ImGuiColorEditFlags_flags)
  if ImGuiColorEditFlags_flags == nil then ImGuiColorEditFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_ColorEdit3(string_label, floatPtr_col, ImGuiColorEditFlags_flags)
end
function M.ColorEdit4(string_label, floatPtr_col, ImGuiColorEditFlags_flags)
  if ImGuiColorEditFlags_flags == nil then ImGuiColorEditFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_ColorEdit4(string_label, floatPtr_col, ImGuiColorEditFlags_flags)
end
function M.ColorPicker3(string_label, floatPtr_col, ImGuiColorEditFlags_flags)
  if ImGuiColorEditFlags_flags == nil then ImGuiColorEditFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_ColorPicker3(string_label, floatPtr_col, ImGuiColorEditFlags_flags)
end
function M.ColorPicker4(string_label, floatPtr_col, ImGuiColorEditFlags_flags, float_ref_col)
  if ImGuiColorEditFlags_flags == nil then ImGuiColorEditFlags_flags = 0 end
  -- float_ref_col is optional and can be nil
  if string_label == nil then  return end
  return C.ImGui_ColorPicker4(string_label, floatPtr_col, ImGuiColorEditFlags_flags, float_ref_col)
end
function M.ColorButton(string_desc_id, ImVec4_col, ImGuiColorEditFlags_flags, ImVec2_size)
  if ImGuiColorEditFlags_flags == nil then ImGuiColorEditFlags_flags = 0 end
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if string_desc_id == nil then  return end
  return C.ImGui_ColorButton(string_desc_id, ImVec4_col, ImGuiColorEditFlags_flags, ImVec2_size)
end
function M.SetColorEditOptions(ImGuiColorEditFlags_flags) C.ImGui_SetColorEditOptions(ImGuiColorEditFlags_flags) end
function M.TreeNode1(string_label)
  if string_label == nil then  return end
  return C.ImGui_TreeNode1(string_label)
end
function M.TreeNode2(string_str_id, string_fmt, ...)
  if string_str_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNode2(string_str_id, string_fmt, ...)
end
function M.TreeNode3(void_ptr_id, string_fmt, ...)
  if void_ptr_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNode3(void_ptr_id, string_fmt, ...)
end
function M.TreeNodeV1(string_str_id, string_fmt, va_list_args)
  if string_str_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNodeV1(string_str_id, string_fmt, va_list_args)
end
function M.TreeNodeV2(void_ptr_id, string_fmt, va_list_args)
  if void_ptr_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNodeV2(void_ptr_id, string_fmt, va_list_args)
end
function M.TreeNodeEx1(string_label, ImGuiTreeNodeFlags_flags)
  if ImGuiTreeNodeFlags_flags == nil then ImGuiTreeNodeFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_TreeNodeEx1(string_label, ImGuiTreeNodeFlags_flags)
end
function M.TreeNodeEx2(string_str_id, ImGuiTreeNodeFlags_flags, string_fmt, ...)
  if string_str_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNodeEx2(string_str_id, ImGuiTreeNodeFlags_flags, string_fmt, ...)
end
function M.TreeNodeEx3(void_ptr_id, ImGuiTreeNodeFlags_flags, string_fmt, ...)
  if void_ptr_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNodeEx3(void_ptr_id, ImGuiTreeNodeFlags_flags, string_fmt, ...)
end
function M.TreeNodeExV1(string_str_id, ImGuiTreeNodeFlags_flags, string_fmt, va_list_args)
  if string_str_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNodeExV1(string_str_id, ImGuiTreeNodeFlags_flags, string_fmt, va_list_args)
end
function M.TreeNodeExV2(void_ptr_id, ImGuiTreeNodeFlags_flags, string_fmt, va_list_args)
  if void_ptr_id == nil then  return end
  if string_fmt == nil then  return end
  return C.ImGui_TreeNodeExV2(void_ptr_id, ImGuiTreeNodeFlags_flags, string_fmt, va_list_args)
end
function M.TreePush1(string_str_id)
  if string_str_id == nil then  return end
  C.ImGui_TreePush1(string_str_id)
end
function M.TreePush2(void_ptr_id)
  -- void_ptr_id is optional and can be nil
  C.ImGui_TreePush2(void_ptr_id)
end
function M.TreePop() C.ImGui_TreePop() end
function M.GetTreeNodeToLabelSpacing() return C.ImGui_GetTreeNodeToLabelSpacing() end
function M.CollapsingHeader1(string_label, ImGuiTreeNodeFlags_flags)
  if ImGuiTreeNodeFlags_flags == nil then ImGuiTreeNodeFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_CollapsingHeader1(string_label, ImGuiTreeNodeFlags_flags)
end
function M.CollapsingHeader2(string_label, bool_p_visible, ImGuiTreeNodeFlags_flags)
  if ImGuiTreeNodeFlags_flags == nil then ImGuiTreeNodeFlags_flags = 0 end
  if string_label == nil then  return end
  if bool_p_visible == nil then  return end
  return C.ImGui_CollapsingHeader2(string_label, bool_p_visible, ImGuiTreeNodeFlags_flags)
end
function M.SetNextItemOpen(bool_is_open, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  C.ImGui_SetNextItemOpen(bool_is_open, ImGuiCond_cond)
end
function M.Selectable1(string_label, bool_selected, ImGuiSelectableFlags_flags, ImVec2_size)
  if bool_selected == nil then bool_selected = false end
  if ImGuiSelectableFlags_flags == nil then ImGuiSelectableFlags_flags = 0 end
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if string_label == nil then  return end
  return C.ImGui_Selectable1(string_label, bool_selected, ImGuiSelectableFlags_flags, ImVec2_size)
end
function M.Selectable2(string_label, bool_p_selected, ImGuiSelectableFlags_flags, ImVec2_size)
  if ImGuiSelectableFlags_flags == nil then ImGuiSelectableFlags_flags = 0 end
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if string_label == nil then  return end
  if bool_p_selected == nil then  return end
  return C.ImGui_Selectable2(string_label, bool_p_selected, ImGuiSelectableFlags_flags, ImVec2_size)
end
function M.ListBox1(string_label, int_current_item, charconstPtr_items, int_items_count, int_height_in_items)
  if int_height_in_items == nil then int_height_in_items = -1 end
  if string_label == nil then  return end
  if int_current_item == nil then  return end
  if charconstPtr_items == nil then  return end
  return C.ImGui_ListBox1(string_label, int_current_item, charconstPtr_items, int_items_count, int_height_in_items)
end
function M.ListBox2(string_label, int_current_item, functionPtr_items_getter, void_data, int_items_count, int_height_in_items)
  if int_height_in_items == nil then int_height_in_items = -1 end
  if string_label == nil then  return end
  if int_current_item == nil then  return end
  if functionPtr_items_getter == nil then  return end
  if void_data == nil then  return end
  return C.ImGui_ListBox2(string_label, int_current_item, functionPtr_items_getter, void_data, int_items_count, int_height_in_items)
end
function M.ListBoxHeader1(string_label, ImVec2_size)
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if string_label == nil then  return end
  return C.ImGui_ListBoxHeader1(string_label, ImVec2_size)
end
function M.ListBoxHeader2(string_label, int_items_count, int_height_in_items)
  if int_height_in_items == nil then int_height_in_items = -1 end
  if string_label == nil then  return end
  return C.ImGui_ListBoxHeader2(string_label, int_items_count, int_height_in_items)
end
function M.ListBoxFooter() C.ImGui_ListBoxFooter() end
function M.PlotLines1(string_label, float_values, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size, int_stride)
  if int_values_offset == nil then int_values_offset = 0 end
  -- string_overlay_text is optional and can be nil
  if float_scale_min == nil then float_scale_min = FLT_MAX end
  if float_scale_max == nil then float_scale_max = FLT_MAX end
  if ImVec2_graph_size == nil then ImVec2_graph_size = M.ImVec2(0,0) end
  if int_stride == nil then int_stride = ffi.sizeof('float') end
  if string_label == nil then  return end
  if float_values == nil then  return end
  C.ImGui_PlotLines1(string_label, float_values, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size, int_stride)
end
function M.PlotLines2(string_label, functionPtr_values_getter, void_data, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size)
  if int_values_offset == nil then int_values_offset = 0 end
  -- string_overlay_text is optional and can be nil
  if float_scale_min == nil then float_scale_min = FLT_MAX end
  if float_scale_max == nil then float_scale_max = FLT_MAX end
  if ImVec2_graph_size == nil then ImVec2_graph_size = M.ImVec2(0,0) end
  if string_label == nil then  return end
  if functionPtr_values_getter == nil then  return end
  if void_data == nil then  return end
  C.ImGui_PlotLines2(string_label, functionPtr_values_getter, void_data, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size)
end
function M.PlotHistogram1(string_label, float_values, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size, int_stride)
  if int_values_offset == nil then int_values_offset = 0 end
  -- string_overlay_text is optional and can be nil
  if float_scale_min == nil then float_scale_min = FLT_MAX end
  if float_scale_max == nil then float_scale_max = FLT_MAX end
  if ImVec2_graph_size == nil then ImVec2_graph_size = M.ImVec2(0,0) end
  if int_stride == nil then int_stride = ffi.sizeof('float') end
  if string_label == nil then  return end
  if float_values == nil then  return end
  C.ImGui_PlotHistogram1(string_label, float_values, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size, int_stride)
end
function M.PlotHistogram2(string_label, functionPtr_values_getter, void_data, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size)
  if int_values_offset == nil then int_values_offset = 0 end
  -- string_overlay_text is optional and can be nil
  if float_scale_min == nil then float_scale_min = FLT_MAX end
  if float_scale_max == nil then float_scale_max = FLT_MAX end
  if ImVec2_graph_size == nil then ImVec2_graph_size = M.ImVec2(0,0) end
  if string_label == nil then  return end
  if functionPtr_values_getter == nil then  return end
  if void_data == nil then  return end
  C.ImGui_PlotHistogram2(string_label, functionPtr_values_getter, void_data, int_values_count, int_values_offset, string_overlay_text, float_scale_min, float_scale_max, ImVec2_graph_size)
end
function M.Value1(string_prefix, bool_b)
  if string_prefix == nil then  return end
  C.ImGui_Value1(string_prefix, bool_b)
end
function M.Value2(string_prefix, int_v)
  if string_prefix == nil then  return end
  C.ImGui_Value2(string_prefix, int_v)
end
function M.Value3(string_prefix, int_v)
  if string_prefix == nil then  return end
  C.ImGui_Value3(string_prefix, int_v)
end
function M.Value4(string_prefix, float_v, string_float_format)
  -- string_float_format is optional and can be nil
  if string_prefix == nil then  return end
  C.ImGui_Value4(string_prefix, float_v, string_float_format)
end
function M.BeginMenuBar() return C.ImGui_BeginMenuBar() end
function M.EndMenuBar() C.ImGui_EndMenuBar() end
function M.BeginMainMenuBar() return C.ImGui_BeginMainMenuBar() end
function M.EndMainMenuBar() C.ImGui_EndMainMenuBar() end
function M.BeginMenu(string_label, bool_enabled)
  if bool_enabled == nil then bool_enabled = true end
  if string_label == nil then  return end
  return C.ImGui_BeginMenu(string_label, bool_enabled)
end
function M.EndMenu() C.ImGui_EndMenu() end
function M.MenuItem1(string_label, string_shortcut, bool_selected, bool_enabled)
  -- string_shortcut is optional and can be nil
  if bool_selected == nil then bool_selected = false end
  if bool_enabled == nil then bool_enabled = true end
  if string_label == nil then  return end
  return C.ImGui_MenuItem1(string_label, string_shortcut, bool_selected, bool_enabled)
end
function M.MenuItem2(string_label, string_shortcut, bool_p_selected, bool_enabled)
  if bool_enabled == nil then bool_enabled = true end
  if string_label == nil then  return end
  if string_shortcut == nil then  return end
  if bool_p_selected == nil then  return end
  return C.ImGui_MenuItem2(string_label, string_shortcut, bool_p_selected, bool_enabled)
end
function M.BeginTooltip() C.ImGui_BeginTooltip() end
function M.EndTooltip() C.ImGui_EndTooltip() end
function M.SetTooltip(string_fmt, ...)
  if string_fmt == nil then  return end
  C.ImGui_SetTooltip(string_fmt, ...)
end
function M.SetTooltipV(string_fmt, va_list_args)
  if string_fmt == nil then  return end
  C.ImGui_SetTooltipV(string_fmt, va_list_args)
end
function M.BeginPopup(string_str_id, ImGuiWindowFlags_flags)
  if ImGuiWindowFlags_flags == nil then ImGuiWindowFlags_flags = 0 end
  if string_str_id == nil then  return end
  return C.ImGui_BeginPopup(string_str_id, ImGuiWindowFlags_flags)
end
function M.BeginPopupModal(string_name, bool_p_open, ImGuiWindowFlags_flags)
  -- bool_p_open is optional and can be nil
  if ImGuiWindowFlags_flags == nil then ImGuiWindowFlags_flags = 0 end
  if string_name == nil then  return end
  return C.ImGui_BeginPopupModal(string_name, bool_p_open, ImGuiWindowFlags_flags)
end
function M.EndPopup() C.ImGui_EndPopup() end
function M.OpenPopup(string_str_id, ImGuiPopupFlags_popup_flags)
  if ImGuiPopupFlags_popup_flags == nil then ImGuiPopupFlags_popup_flags = 0 end
  if string_str_id == nil then  return end
  C.ImGui_OpenPopup(string_str_id, ImGuiPopupFlags_popup_flags)
end
function M.OpenPopupOnItemClick(string_str_id, ImGuiPopupFlags_popup_flags)
  -- string_str_id is optional and can be nil
  if ImGuiPopupFlags_popup_flags == nil then ImGuiPopupFlags_popup_flags = 1 end
  C.ImGui_OpenPopupOnItemClick(string_str_id, ImGuiPopupFlags_popup_flags)
end
function M.CloseCurrentPopup() C.ImGui_CloseCurrentPopup() end
function M.BeginPopupContextItem(string_str_id, ImGuiPopupFlags_popup_flags)
  -- string_str_id is optional and can be nil
  if ImGuiPopupFlags_popup_flags == nil then ImGuiPopupFlags_popup_flags = 1 end
  return C.ImGui_BeginPopupContextItem(string_str_id, ImGuiPopupFlags_popup_flags)
end
function M.BeginPopupContextWindow(string_str_id, ImGuiPopupFlags_popup_flags)
  -- string_str_id is optional and can be nil
  if ImGuiPopupFlags_popup_flags == nil then ImGuiPopupFlags_popup_flags = 1 end
  return C.ImGui_BeginPopupContextWindow(string_str_id, ImGuiPopupFlags_popup_flags)
end
function M.BeginPopupContextVoid(string_str_id, ImGuiPopupFlags_popup_flags)
  -- string_str_id is optional and can be nil
  if ImGuiPopupFlags_popup_flags == nil then ImGuiPopupFlags_popup_flags = 1 end
  return C.ImGui_BeginPopupContextVoid(string_str_id, ImGuiPopupFlags_popup_flags)
end
function M.IsPopupOpen(string_str_id, ImGuiPopupFlags_flags)
  if ImGuiPopupFlags_flags == nil then ImGuiPopupFlags_flags = 0 end
  if string_str_id == nil then  return end
  return C.ImGui_IsPopupOpen(string_str_id, ImGuiPopupFlags_flags)
end
function M.BeginTable(string_str_id, int_column, ImGuiTableFlags_flags, ImVec2_outer_size, float_inner_width)
  if ImGuiTableFlags_flags == nil then ImGuiTableFlags_flags = 0 end
  if ImVec2_outer_size == nil then ImVec2_outer_size = M.ImVec2(0.0,0.0) end
  if float_inner_width == nil then float_inner_width = 0 end
  if string_str_id == nil then  return end
  return C.ImGui_BeginTable(string_str_id, int_column, ImGuiTableFlags_flags, ImVec2_outer_size, float_inner_width)
end
function M.EndTable() C.ImGui_EndTable() end
function M.TableNextRow(ImGuiTableRowFlags_row_flags, float_min_row_height)
  if ImGuiTableRowFlags_row_flags == nil then ImGuiTableRowFlags_row_flags = 0 end
  if float_min_row_height == nil then float_min_row_height = 0 end
  C.ImGui_TableNextRow(ImGuiTableRowFlags_row_flags, float_min_row_height)
end
function M.TableNextColumn() return C.ImGui_TableNextColumn() end
function M.TableSetColumnIndex(int_column_n) return C.ImGui_TableSetColumnIndex(int_column_n) end
function M.TableSetupColumn(string_label, ImGuiTableColumnFlags_flags, float_init_width_or_weight, ImU32_user_id)
  if ImGuiTableColumnFlags_flags == nil then ImGuiTableColumnFlags_flags = 0 end
  if float_init_width_or_weight == nil then float_init_width_or_weight = 0 end
  if ImU32_user_id == nil then ImU32_user_id = 0 end
  if string_label == nil then  return end
  C.ImGui_TableSetupColumn(string_label, ImGuiTableColumnFlags_flags, float_init_width_or_weight, ImU32_user_id)
end
function M.TableSetupScrollFreeze(int_cols, int_rows) C.ImGui_TableSetupScrollFreeze(int_cols, int_rows) end
function M.TableHeadersRow() C.ImGui_TableHeadersRow() end
function M.TableHeader(string_label)
  if string_label == nil then  return end
  C.ImGui_TableHeader(string_label)
end
function M.TableGetSortSpecs() return C.ImGui_TableGetSortSpecs() end
function M.TableGetColumnCount() return C.ImGui_TableGetColumnCount() end
function M.TableGetColumnIndex() return C.ImGui_TableGetColumnIndex() end
function M.TableGetRowIndex() return C.ImGui_TableGetRowIndex() end
function M.TableGetColumnName(int_column_n)
  if int_column_n == nil then int_column_n = -1 end
  return C.ImGui_TableGetColumnName(int_column_n)
end
function M.TableGetColumnFlags(int_column_n)
  if int_column_n == nil then int_column_n = -1 end
  return C.ImGui_TableGetColumnFlags(int_column_n)
end
function M.TableSetBgColor(ImGuiTableBgTarget_target, ImU32_color, int_column_n)
  if int_column_n == nil then int_column_n = -1 end
  C.ImGui_TableSetBgColor(ImGuiTableBgTarget_target, ImU32_color, int_column_n)
end
function M.Columns(int_count, string_id, bool_border)
  if int_count == nil then int_count = 1 end
  -- string_id is optional and can be nil
  if bool_border == nil then bool_border = true end
  C.ImGui_Columns(int_count, string_id, bool_border)
end
function M.NextColumn() C.ImGui_NextColumn() end
function M.GetColumnIndex() return C.ImGui_GetColumnIndex() end
function M.GetColumnWidth(int_column_index)
  if int_column_index == nil then int_column_index = -1 end
  return C.ImGui_GetColumnWidth(int_column_index)
end
function M.SetColumnWidth(int_column_index, float_width) C.ImGui_SetColumnWidth(int_column_index, float_width) end
function M.GetColumnOffset(int_column_index)
  if int_column_index == nil then int_column_index = -1 end
  return C.ImGui_GetColumnOffset(int_column_index)
end
function M.SetColumnOffset(int_column_index, float_offset_x) C.ImGui_SetColumnOffset(int_column_index, float_offset_x) end
function M.GetColumnsCount() return C.ImGui_GetColumnsCount() end
function M.BeginTabBar(string_str_id, ImGuiTabBarFlags_flags)
  if ImGuiTabBarFlags_flags == nil then ImGuiTabBarFlags_flags = 0 end
  if string_str_id == nil then  return end
  return C.ImGui_BeginTabBar(string_str_id, ImGuiTabBarFlags_flags)
end
function M.EndTabBar() C.ImGui_EndTabBar() end
function M.BeginTabItem(string_label, bool_p_open, ImGuiTabItemFlags_flags)
  -- bool_p_open is optional and can be nil
  if ImGuiTabItemFlags_flags == nil then ImGuiTabItemFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_BeginTabItem(string_label, bool_p_open, ImGuiTabItemFlags_flags)
end
function M.EndTabItem() C.ImGui_EndTabItem() end
function M.TabItemButton(string_label, ImGuiTabItemFlags_flags)
  if ImGuiTabItemFlags_flags == nil then ImGuiTabItemFlags_flags = 0 end
  if string_label == nil then  return end
  return C.ImGui_TabItemButton(string_label, ImGuiTabItemFlags_flags)
end
function M.SetTabItemClosed(string_tab_or_docked_window_label)
  if string_tab_or_docked_window_label == nil then  return end
  C.ImGui_SetTabItemClosed(string_tab_or_docked_window_label)
end
function M.DockSpace(ImGuiID_id, ImVec2_size, ImGuiDockNodeFlags_flags, ImGuiWindowClass_window_class)
  if ImVec2_size == nil then ImVec2_size = M.ImVec2(0,0) end
  if ImGuiDockNodeFlags_flags == nil then ImGuiDockNodeFlags_flags = 0 end
  -- ImGuiWindowClass_window_class is optional and can be nil
  C.ImGui_DockSpace(ImGuiID_id, ImVec2_size, ImGuiDockNodeFlags_flags, ImGuiWindowClass_window_class)
end
function M.DockSpaceOverViewport(ImGuiViewport_viewport, ImGuiDockNodeFlags_flags, ImGuiWindowClass_window_class)
  -- ImGuiViewport_viewport is optional and can be nil
  if ImGuiDockNodeFlags_flags == nil then ImGuiDockNodeFlags_flags = 0 end
  -- ImGuiWindowClass_window_class is optional and can be nil
  return C.ImGui_DockSpaceOverViewport(ImGuiViewport_viewport, ImGuiDockNodeFlags_flags, ImGuiWindowClass_window_class)
end
function M.SetNextWindowDockID(ImGuiID_dock_id, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  C.ImGui_SetNextWindowDockID(ImGuiID_dock_id, ImGuiCond_cond)
end
function M.SetNextWindowClass(ImGuiWindowClass_window_class)
  if ImGuiWindowClass_window_class == nil then  return end
  C.ImGui_SetNextWindowClass(ImGuiWindowClass_window_class)
end
function M.GetWindowDockID() return C.ImGui_GetWindowDockID() end
function M.IsWindowDocked() return C.ImGui_IsWindowDocked() end
function M.LogToTTY(int_auto_open_depth)
  if int_auto_open_depth == nil then int_auto_open_depth = -1 end
  C.ImGui_LogToTTY(int_auto_open_depth)
end
function M.LogToFile(int_auto_open_depth, string_filename)
  if int_auto_open_depth == nil then int_auto_open_depth = -1 end
  -- string_filename is optional and can be nil
  C.ImGui_LogToFile(int_auto_open_depth, string_filename)
end
function M.LogToClipboard(int_auto_open_depth)
  if int_auto_open_depth == nil then int_auto_open_depth = -1 end
  C.ImGui_LogToClipboard(int_auto_open_depth)
end
function M.LogFinish() C.ImGui_LogFinish() end
function M.LogButtons() C.ImGui_LogButtons() end
function M.LogText(string_fmt, ...)
  if string_fmt == nil then  return end
  C.ImGui_LogText(string_fmt, ...)
end
function M.BeginDragDropSource(ImGuiDragDropFlags_flags)
  if ImGuiDragDropFlags_flags == nil then ImGuiDragDropFlags_flags = 0 end
  return C.ImGui_BeginDragDropSource(ImGuiDragDropFlags_flags)
end
function M.SetDragDropPayload(string_type, void_data, size_t_sz, ImGuiCond_cond)
  if ImGuiCond_cond == nil then ImGuiCond_cond = 0 end
  if string_type == nil then  return end
  if void_data == nil then  return end
  return C.ImGui_SetDragDropPayload(string_type, void_data, size_t_sz, ImGuiCond_cond)
end
function M.EndDragDropSource() C.ImGui_EndDragDropSource() end
function M.BeginDragDropTarget() return C.ImGui_BeginDragDropTarget() end
function M.AcceptDragDropPayload(string_type, ImGuiDragDropFlags_flags)
  if ImGuiDragDropFlags_flags == nil then ImGuiDragDropFlags_flags = 0 end
  if string_type == nil then  return end
  return C.ImGui_AcceptDragDropPayload(string_type, ImGuiDragDropFlags_flags)
end
function M.EndDragDropTarget() C.ImGui_EndDragDropTarget() end
function M.GetDragDropPayload() return C.ImGui_GetDragDropPayload() end
function M.PushClipRect(ImVec2_clip_rect_min, ImVec2_clip_rect_max, bool_intersect_with_current_clip_rect) C.ImGui_PushClipRect(ImVec2_clip_rect_min, ImVec2_clip_rect_max, bool_intersect_with_current_clip_rect) end
function M.PopClipRect() C.ImGui_PopClipRect() end
function M.SetItemDefaultFocus() C.ImGui_SetItemDefaultFocus() end
function M.SetKeyboardFocusHere(int_offset)
  if int_offset == nil then int_offset = 0 end
  C.ImGui_SetKeyboardFocusHere(int_offset)
end
function M.IsItemHovered(ImGuiHoveredFlags_flags)
  if ImGuiHoveredFlags_flags == nil then ImGuiHoveredFlags_flags = 0 end
  return C.ImGui_IsItemHovered(ImGuiHoveredFlags_flags)
end
function M.IsItemActive() return C.ImGui_IsItemActive() end
function M.IsItemFocused() return C.ImGui_IsItemFocused() end
function M.IsItemClicked(ImGuiMouseButton_mouse_button)
  if ImGuiMouseButton_mouse_button == nil then ImGuiMouseButton_mouse_button = 0 end
  return C.ImGui_IsItemClicked(ImGuiMouseButton_mouse_button)
end
function M.IsItemVisible() return C.ImGui_IsItemVisible() end
function M.IsItemEdited() return C.ImGui_IsItemEdited() end
function M.IsItemActivated() return C.ImGui_IsItemActivated() end
function M.IsItemDeactivated() return C.ImGui_IsItemDeactivated() end
function M.IsItemDeactivatedAfterEdit() return C.ImGui_IsItemDeactivatedAfterEdit() end
function M.IsItemToggledOpen() return C.ImGui_IsItemToggledOpen() end
function M.IsAnyItemHovered() return C.ImGui_IsAnyItemHovered() end
function M.IsAnyItemActive() return C.ImGui_IsAnyItemActive() end
function M.IsAnyItemFocused() return C.ImGui_IsAnyItemFocused() end
function M.GetItemRectMin() return C.ImGui_GetItemRectMin() end
function M.GetItemRectMax() return C.ImGui_GetItemRectMax() end
function M.GetItemRectSize() return C.ImGui_GetItemRectSize() end
function M.SetItemAllowOverlap() C.ImGui_SetItemAllowOverlap() end
function M.IsRectVisible1(ImVec2_size) return C.ImGui_IsRectVisible1(ImVec2_size) end
function M.IsRectVisible2(ImVec2_rect_min, ImVec2_rect_max) return C.ImGui_IsRectVisible2(ImVec2_rect_min, ImVec2_rect_max) end
function M.GetTime() return C.ImGui_GetTime() end
function M.GetFrameCount() return C.ImGui_GetFrameCount() end
function M.GetBackgroundDrawList1() return C.ImGui_GetBackgroundDrawList1() end
function M.GetForegroundDrawList1() return C.ImGui_GetForegroundDrawList1() end
function M.GetBackgroundDrawList2(ImGuiViewport_viewport)
  if ImGuiViewport_viewport == nil then  return end
  return C.ImGui_GetBackgroundDrawList2(ImGuiViewport_viewport)
end
function M.GetForegroundDrawList2(ImGuiViewport_viewport)
  if ImGuiViewport_viewport == nil then  return end
  return C.ImGui_GetForegroundDrawList2(ImGuiViewport_viewport)
end
function M.GetDrawListSharedData() return C.ImGui_GetDrawListSharedData() end
function M.GetStyleColorName(ImGuiCol_idx) return C.ImGui_GetStyleColorName(ImGuiCol_idx) end
function M.SetStateStorage(ImGuiStorage_storage)
  if ImGuiStorage_storage == nil then  return end
  C.ImGui_SetStateStorage(ImGuiStorage_storage)
end
function M.GetStateStorage() return C.ImGui_GetStateStorage() end
function M.CalcListClipping(int_items_count, float_items_height, int_out_items_display_start, int_out_items_display_end)
  if int_out_items_display_start == nil then  return end
  if int_out_items_display_end == nil then  return end
  C.ImGui_CalcListClipping(int_items_count, float_items_height, int_out_items_display_start, int_out_items_display_end)
end
function M.BeginChildFrame(ImGuiID_id, ImVec2_size, ImGuiWindowFlags_flags)
  if ImGuiWindowFlags_flags == nil then ImGuiWindowFlags_flags = 0 end
  return C.ImGui_BeginChildFrame(ImGuiID_id, ImVec2_size, ImGuiWindowFlags_flags)
end
function M.EndChildFrame() C.ImGui_EndChildFrame() end
function M.CalcTextSize(string_text, string_text_end, bool_hide_text_after_double_hash, float_wrap_width)
  -- string_text_end is optional and can be nil
  if bool_hide_text_after_double_hash == nil then bool_hide_text_after_double_hash = false end
  if float_wrap_width == nil then float_wrap_width = -1 end
  if string_text == nil then  return end
  return C.ImGui_CalcTextSize(string_text, string_text_end, bool_hide_text_after_double_hash, float_wrap_width)
end
function M.ColorConvertU32ToFloat4(_in) return C.ImGui_ColorConvertU32ToFloat4(_in) end
function M.ColorConvertFloat4ToU32(_in) return C.ImGui_ColorConvertFloat4ToU32(_in) end
function M.ColorConvertRGBtoHSV(float_r, float_g, float_b, float_out_h, float_out_s, float_out_v) C.ImGui_ColorConvertRGBtoHSV(float_r, float_g, float_b, float_out_h, float_out_s, float_out_v) end
function M.ColorConvertHSVtoRGB(float_h, float_s, float_v, float_out_r, float_out_g, float_out_b) C.ImGui_ColorConvertHSVtoRGB(float_h, float_s, float_v, float_out_r, float_out_g, float_out_b) end
function M.GetKeyIndex(ImGuiKey_imgui_key) return C.ImGui_GetKeyIndex(ImGuiKey_imgui_key) end
function M.IsKeyDown(int_user_key_index) return C.ImGui_IsKeyDown(int_user_key_index) end
function M.IsKeyPressed(int_user_key_index, _repeat)
  if _repeat == nil then _repeat = true end
  return C.ImGui_IsKeyPressed(int_user_key_index, _repeat)
end
function M.IsKeyReleased(int_user_key_index) return C.ImGui_IsKeyReleased(int_user_key_index) end
function M.GetKeyPressedAmount(int_key_index, float_repeat_delay, float_rate) return C.ImGui_GetKeyPressedAmount(int_key_index, float_repeat_delay, float_rate) end
function M.CaptureKeyboardFromApp(bool_want_capture_keyboard_value)
  if bool_want_capture_keyboard_value == nil then bool_want_capture_keyboard_value = true end
  C.ImGui_CaptureKeyboardFromApp(bool_want_capture_keyboard_value)
end
function M.IsMouseDown(ImGuiMouseButton_button) return C.ImGui_IsMouseDown(ImGuiMouseButton_button) end
function M.IsMouseClicked(ImGuiMouseButton_button, _repeat)
  if _repeat == nil then _repeat = false end
  return C.ImGui_IsMouseClicked(ImGuiMouseButton_button, _repeat)
end
function M.IsMouseReleased(ImGuiMouseButton_button) return C.ImGui_IsMouseReleased(ImGuiMouseButton_button) end
function M.IsMouseDoubleClicked(ImGuiMouseButton_button) return C.ImGui_IsMouseDoubleClicked(ImGuiMouseButton_button) end
function M.IsMouseHoveringRect(ImVec2_r_min, ImVec2_r_max, bool_clip)
  if bool_clip == nil then bool_clip = true end
  return C.ImGui_IsMouseHoveringRect(ImVec2_r_min, ImVec2_r_max, bool_clip)
end
function M.IsMousePosValid(ImVec2_mouse_pos)
  -- ImVec2_mouse_pos is optional and can be nil
  return C.ImGui_IsMousePosValid(ImVec2_mouse_pos)
end
function M.IsAnyMouseDown() return C.ImGui_IsAnyMouseDown() end
function M.GetMousePos() return C.ImGui_GetMousePos() end
function M.GetMousePosOnOpeningCurrentPopup() return C.ImGui_GetMousePosOnOpeningCurrentPopup() end
function M.IsMouseDragging(ImGuiMouseButton_button, float_lock_threshold)
  if float_lock_threshold == nil then float_lock_threshold = -1 end
  return C.ImGui_IsMouseDragging(ImGuiMouseButton_button, float_lock_threshold)
end
function M.GetMouseDragDelta(ImGuiMouseButton_button, float_lock_threshold)
  if ImGuiMouseButton_button == nil then ImGuiMouseButton_button = 0 end
  if float_lock_threshold == nil then float_lock_threshold = -1 end
  return C.ImGui_GetMouseDragDelta(ImGuiMouseButton_button, float_lock_threshold)
end
function M.ResetMouseDragDelta(ImGuiMouseButton_button)
  if ImGuiMouseButton_button == nil then ImGuiMouseButton_button = 0 end
  C.ImGui_ResetMouseDragDelta(ImGuiMouseButton_button)
end
function M.GetMouseCursor() return C.ImGui_GetMouseCursor() end
function M.SetMouseCursor(ImGuiMouseCursor_cursor_type) C.ImGui_SetMouseCursor(ImGuiMouseCursor_cursor_type) end
function M.CaptureMouseFromApp(bool_want_capture_mouse_value)
  if bool_want_capture_mouse_value == nil then bool_want_capture_mouse_value = true end
  C.ImGui_CaptureMouseFromApp(bool_want_capture_mouse_value)
end
function M.GetClipboardText() return C.ImGui_GetClipboardText() end
function M.SetClipboardText(string_text)
  if string_text == nil then  return end
  C.ImGui_SetClipboardText(string_text)
end
function M.DebugCheckVersionAndDataLayout(string_version_str, size_t_sz_io, size_t_sz_style, size_t_sz_vec2, size_t_sz_vec4, size_t_sz_drawvert, size_t_sz_drawidx)
  if string_version_str == nil then  return end
  return C.ImGui_DebugCheckVersionAndDataLayout(string_version_str, size_t_sz_io, size_t_sz_style, size_t_sz_vec2, size_t_sz_vec4, size_t_sz_drawvert, size_t_sz_drawidx)
end
function M.GetPlatformIO() return C.ImGui_GetPlatformIO() end
function M.GetMainViewport() return C.ImGui_GetMainViewport() end
function M.UpdatePlatformWindows() C.ImGui_UpdatePlatformWindows() end
function M.RenderPlatformWindowsDefault(void_platform_render_arg, void_renderer_render_arg)
  -- void_platform_render_arg is optional and can be nil
  -- void_renderer_render_arg is optional and can be nil
  C.ImGui_RenderPlatformWindowsDefault(void_platform_render_arg, void_renderer_render_arg)
end
function M.DestroyPlatformWindows() C.ImGui_DestroyPlatformWindows() end
function M.FindViewportByID(ImGuiID_id) return C.ImGui_FindViewportByID(ImGuiID_id) end
function M.FindViewportByPlatformHandle(void_platform_handle)
  if void_platform_handle == nil then  return end
  return C.ImGui_FindViewportByPlatformHandle(void_platform_handle)
end
--=== enum ImGuiWindowFlags_ ===
M.WindowFlags_None = C.ImGuiWindowFlags_None
M.WindowFlags_NoTitleBar = C.ImGuiWindowFlags_NoTitleBar
M.WindowFlags_NoResize = C.ImGuiWindowFlags_NoResize
M.WindowFlags_NoMove = C.ImGuiWindowFlags_NoMove
M.WindowFlags_NoScrollbar = C.ImGuiWindowFlags_NoScrollbar
M.WindowFlags_NoScrollWithMouse = C.ImGuiWindowFlags_NoScrollWithMouse
M.WindowFlags_NoCollapse = C.ImGuiWindowFlags_NoCollapse
M.WindowFlags_AlwaysAutoResize = C.ImGuiWindowFlags_AlwaysAutoResize
M.WindowFlags_NoBackground = C.ImGuiWindowFlags_NoBackground
M.WindowFlags_NoSavedSettings = C.ImGuiWindowFlags_NoSavedSettings
M.WindowFlags_NoMouseInputs = C.ImGuiWindowFlags_NoMouseInputs
M.WindowFlags_MenuBar = C.ImGuiWindowFlags_MenuBar
M.WindowFlags_HorizontalScrollbar = C.ImGuiWindowFlags_HorizontalScrollbar
M.WindowFlags_NoFocusOnAppearing = C.ImGuiWindowFlags_NoFocusOnAppearing
M.WindowFlags_NoBringToFrontOnFocus = C.ImGuiWindowFlags_NoBringToFrontOnFocus
M.WindowFlags_AlwaysVerticalScrollbar = C.ImGuiWindowFlags_AlwaysVerticalScrollbar
M.WindowFlags_AlwaysHorizontalScrollbar = C.ImGuiWindowFlags_AlwaysHorizontalScrollbar
M.WindowFlags_AlwaysUseWindowPadding = C.ImGuiWindowFlags_AlwaysUseWindowPadding
M.WindowFlags_NoNavInputs = C.ImGuiWindowFlags_NoNavInputs
M.WindowFlags_NoNavFocus = C.ImGuiWindowFlags_NoNavFocus
M.WindowFlags_UnsavedDocument = C.ImGuiWindowFlags_UnsavedDocument
M.WindowFlags_NoDocking = C.ImGuiWindowFlags_NoDocking
M.WindowFlags_NoNav = C.ImGuiWindowFlags_NoNav
M.WindowFlags_NoDecoration = C.ImGuiWindowFlags_NoDecoration
M.WindowFlags_NoInputs = C.ImGuiWindowFlags_NoInputs
M.WindowFlags_NavFlattened = C.ImGuiWindowFlags_NavFlattened
M.WindowFlags_ChildWindow = C.ImGuiWindowFlags_ChildWindow
M.WindowFlags_Tooltip = C.ImGuiWindowFlags_Tooltip
M.WindowFlags_Popup = C.ImGuiWindowFlags_Popup
M.WindowFlags_Modal = C.ImGuiWindowFlags_Modal
M.WindowFlags_ChildMenu = C.ImGuiWindowFlags_ChildMenu
M.WindowFlags_DockNodeHost = C.ImGuiWindowFlags_DockNodeHost
--===
--=== enum ImGuiInputTextFlags_ ===
M.InputTextFlags_None = C.ImGuiInputTextFlags_None
M.InputTextFlags_CharsDecimal = C.ImGuiInputTextFlags_CharsDecimal
M.InputTextFlags_CharsHexadecimal = C.ImGuiInputTextFlags_CharsHexadecimal
M.InputTextFlags_CharsUppercase = C.ImGuiInputTextFlags_CharsUppercase
M.InputTextFlags_CharsNoBlank = C.ImGuiInputTextFlags_CharsNoBlank
M.InputTextFlags_AutoSelectAll = C.ImGuiInputTextFlags_AutoSelectAll
M.InputTextFlags_EnterReturnsTrue = C.ImGuiInputTextFlags_EnterReturnsTrue
M.InputTextFlags_CallbackCompletion = C.ImGuiInputTextFlags_CallbackCompletion
M.InputTextFlags_CallbackHistory = C.ImGuiInputTextFlags_CallbackHistory
M.InputTextFlags_CallbackAlways = C.ImGuiInputTextFlags_CallbackAlways
M.InputTextFlags_CallbackCharFilter = C.ImGuiInputTextFlags_CallbackCharFilter
M.InputTextFlags_AllowTabInput = C.ImGuiInputTextFlags_AllowTabInput
M.InputTextFlags_CtrlEnterForNewLine = C.ImGuiInputTextFlags_CtrlEnterForNewLine
M.InputTextFlags_NoHorizontalScroll = C.ImGuiInputTextFlags_NoHorizontalScroll
M.InputTextFlags_AlwaysInsertMode = C.ImGuiInputTextFlags_AlwaysInsertMode
M.InputTextFlags_ReadOnly = C.ImGuiInputTextFlags_ReadOnly
M.InputTextFlags_Password = C.ImGuiInputTextFlags_Password
M.InputTextFlags_NoUndoRedo = C.ImGuiInputTextFlags_NoUndoRedo
M.InputTextFlags_CharsScientific = C.ImGuiInputTextFlags_CharsScientific
M.InputTextFlags_CallbackResize = C.ImGuiInputTextFlags_CallbackResize
M.InputTextFlags_CallbackEdit = C.ImGuiInputTextFlags_CallbackEdit
M.InputTextFlags_Multiline = C.ImGuiInputTextFlags_Multiline
M.InputTextFlags_NoMarkEdited = C.ImGuiInputTextFlags_NoMarkEdited
--===
--=== enum ImGuiTreeNodeFlags_ ===
M.TreeNodeFlags_None = C.ImGuiTreeNodeFlags_None
M.TreeNodeFlags_Selected = C.ImGuiTreeNodeFlags_Selected
M.TreeNodeFlags_Framed = C.ImGuiTreeNodeFlags_Framed
M.TreeNodeFlags_AllowItemOverlap = C.ImGuiTreeNodeFlags_AllowItemOverlap
M.TreeNodeFlags_NoTreePushOnOpen = C.ImGuiTreeNodeFlags_NoTreePushOnOpen
M.TreeNodeFlags_NoAutoOpenOnLog = C.ImGuiTreeNodeFlags_NoAutoOpenOnLog
M.TreeNodeFlags_DefaultOpen = C.ImGuiTreeNodeFlags_DefaultOpen
M.TreeNodeFlags_OpenOnDoubleClick = C.ImGuiTreeNodeFlags_OpenOnDoubleClick
M.TreeNodeFlags_OpenOnArrow = C.ImGuiTreeNodeFlags_OpenOnArrow
M.TreeNodeFlags_Leaf = C.ImGuiTreeNodeFlags_Leaf
M.TreeNodeFlags_Bullet = C.ImGuiTreeNodeFlags_Bullet
M.TreeNodeFlags_FramePadding = C.ImGuiTreeNodeFlags_FramePadding
M.TreeNodeFlags_SpanAvailWidth = C.ImGuiTreeNodeFlags_SpanAvailWidth
M.TreeNodeFlags_SpanFullWidth = C.ImGuiTreeNodeFlags_SpanFullWidth
M.TreeNodeFlags_NavLeftJumpsBackHere = C.ImGuiTreeNodeFlags_NavLeftJumpsBackHere
M.TreeNodeFlags_CollapsingHeader = C.ImGuiTreeNodeFlags_CollapsingHeader
--===
--=== enum ImGuiPopupFlags_ ===
M.PopupFlags_None = C.ImGuiPopupFlags_None
M.PopupFlags_MouseButtonLeft = C.ImGuiPopupFlags_MouseButtonLeft
M.PopupFlags_MouseButtonRight = C.ImGuiPopupFlags_MouseButtonRight
M.PopupFlags_MouseButtonMiddle = C.ImGuiPopupFlags_MouseButtonMiddle
M.PopupFlags_MouseButtonMask_ = C.ImGuiPopupFlags_MouseButtonMask_
M.PopupFlags_MouseButtonDefault_ = C.ImGuiPopupFlags_MouseButtonDefault_
M.PopupFlags_NoOpenOverExistingPopup = C.ImGuiPopupFlags_NoOpenOverExistingPopup
M.PopupFlags_NoOpenOverItems = C.ImGuiPopupFlags_NoOpenOverItems
M.PopupFlags_AnyPopupId = C.ImGuiPopupFlags_AnyPopupId
M.PopupFlags_AnyPopupLevel = C.ImGuiPopupFlags_AnyPopupLevel
M.PopupFlags_AnyPopup = C.ImGuiPopupFlags_AnyPopup
--===
--=== enum ImGuiSelectableFlags_ ===
M.SelectableFlags_None = C.ImGuiSelectableFlags_None
M.SelectableFlags_DontClosePopups = C.ImGuiSelectableFlags_DontClosePopups
M.SelectableFlags_SpanAllColumns = C.ImGuiSelectableFlags_SpanAllColumns
M.SelectableFlags_AllowDoubleClick = C.ImGuiSelectableFlags_AllowDoubleClick
M.SelectableFlags_Disabled = C.ImGuiSelectableFlags_Disabled
M.SelectableFlags_AllowItemOverlap = C.ImGuiSelectableFlags_AllowItemOverlap
--===
--=== enum ImGuiComboFlags_ ===
M.ComboFlags_None = C.ImGuiComboFlags_None
M.ComboFlags_PopupAlignLeft = C.ImGuiComboFlags_PopupAlignLeft
M.ComboFlags_HeightSmall = C.ImGuiComboFlags_HeightSmall
M.ComboFlags_HeightRegular = C.ImGuiComboFlags_HeightRegular
M.ComboFlags_HeightLarge = C.ImGuiComboFlags_HeightLarge
M.ComboFlags_HeightLargest = C.ImGuiComboFlags_HeightLargest
M.ComboFlags_NoArrowButton = C.ImGuiComboFlags_NoArrowButton
M.ComboFlags_NoPreview = C.ImGuiComboFlags_NoPreview
M.ComboFlags_HeightMask_ = C.ImGuiComboFlags_HeightMask_
--===
--=== enum ImGuiTabBarFlags_ ===
M.TabBarFlags_None = C.ImGuiTabBarFlags_None
M.TabBarFlags_Reorderable = C.ImGuiTabBarFlags_Reorderable
M.TabBarFlags_AutoSelectNewTabs = C.ImGuiTabBarFlags_AutoSelectNewTabs
M.TabBarFlags_TabListPopupButton = C.ImGuiTabBarFlags_TabListPopupButton
M.TabBarFlags_NoCloseWithMiddleMouseButton = C.ImGuiTabBarFlags_NoCloseWithMiddleMouseButton
M.TabBarFlags_NoTabListScrollingButtons = C.ImGuiTabBarFlags_NoTabListScrollingButtons
M.TabBarFlags_NoTooltip = C.ImGuiTabBarFlags_NoTooltip
M.TabBarFlags_FittingPolicyResizeDown = C.ImGuiTabBarFlags_FittingPolicyResizeDown
M.TabBarFlags_FittingPolicyScroll = C.ImGuiTabBarFlags_FittingPolicyScroll
M.TabBarFlags_FittingPolicyMask_ = C.ImGuiTabBarFlags_FittingPolicyMask_
M.TabBarFlags_FittingPolicyDefault_ = C.ImGuiTabBarFlags_FittingPolicyDefault_
--===
--=== enum ImGuiTabItemFlags_ ===
M.TabItemFlags_None = C.ImGuiTabItemFlags_None
M.TabItemFlags_UnsavedDocument = C.ImGuiTabItemFlags_UnsavedDocument
M.TabItemFlags_SetSelected = C.ImGuiTabItemFlags_SetSelected
M.TabItemFlags_NoCloseWithMiddleMouseButton = C.ImGuiTabItemFlags_NoCloseWithMiddleMouseButton
M.TabItemFlags_NoPushId = C.ImGuiTabItemFlags_NoPushId
M.TabItemFlags_NoTooltip = C.ImGuiTabItemFlags_NoTooltip
M.TabItemFlags_NoReorder = C.ImGuiTabItemFlags_NoReorder
M.TabItemFlags_Leading = C.ImGuiTabItemFlags_Leading
M.TabItemFlags_Trailing = C.ImGuiTabItemFlags_Trailing
--===
--=== enum ImGuiTableFlags_ ===
M.TableFlags_None = C.ImGuiTableFlags_None
M.TableFlags_Resizable = C.ImGuiTableFlags_Resizable
M.TableFlags_Reorderable = C.ImGuiTableFlags_Reorderable
M.TableFlags_Hideable = C.ImGuiTableFlags_Hideable
M.TableFlags_Sortable = C.ImGuiTableFlags_Sortable
M.TableFlags_NoSavedSettings = C.ImGuiTableFlags_NoSavedSettings
M.TableFlags_ContextMenuInBody = C.ImGuiTableFlags_ContextMenuInBody
M.TableFlags_RowBg = C.ImGuiTableFlags_RowBg
M.TableFlags_BordersInnerH = C.ImGuiTableFlags_BordersInnerH
M.TableFlags_BordersOuterH = C.ImGuiTableFlags_BordersOuterH
M.TableFlags_BordersInnerV = C.ImGuiTableFlags_BordersInnerV
M.TableFlags_BordersOuterV = C.ImGuiTableFlags_BordersOuterV
M.TableFlags_BordersH = C.ImGuiTableFlags_BordersH
M.TableFlags_BordersV = C.ImGuiTableFlags_BordersV
M.TableFlags_BordersInner = C.ImGuiTableFlags_BordersInner
M.TableFlags_BordersOuter = C.ImGuiTableFlags_BordersOuter
M.TableFlags_Borders = C.ImGuiTableFlags_Borders
M.TableFlags_NoBordersInBody = C.ImGuiTableFlags_NoBordersInBody
M.TableFlags_NoBordersInBodyUntilResize = C.ImGuiTableFlags_NoBordersInBodyUntilResize
M.TableFlags_SizingFixedFit = C.ImGuiTableFlags_SizingFixedFit
M.TableFlags_SizingFixedSame = C.ImGuiTableFlags_SizingFixedSame
M.TableFlags_SizingStretchProp = C.ImGuiTableFlags_SizingStretchProp
M.TableFlags_SizingStretchSame = C.ImGuiTableFlags_SizingStretchSame
M.TableFlags_NoHostExtendX = C.ImGuiTableFlags_NoHostExtendX
M.TableFlags_NoHostExtendY = C.ImGuiTableFlags_NoHostExtendY
M.TableFlags_NoKeepColumnsVisible = C.ImGuiTableFlags_NoKeepColumnsVisible
M.TableFlags_PreciseWidths = C.ImGuiTableFlags_PreciseWidths
M.TableFlags_NoClip = C.ImGuiTableFlags_NoClip
M.TableFlags_PadOuterX = C.ImGuiTableFlags_PadOuterX
M.TableFlags_NoPadOuterX = C.ImGuiTableFlags_NoPadOuterX
M.TableFlags_NoPadInnerX = C.ImGuiTableFlags_NoPadInnerX
M.TableFlags_ScrollX = C.ImGuiTableFlags_ScrollX
M.TableFlags_ScrollY = C.ImGuiTableFlags_ScrollY
M.TableFlags_SortMulti = C.ImGuiTableFlags_SortMulti
M.TableFlags_SortTristate = C.ImGuiTableFlags_SortTristate
M.TableFlags_SizingMask_ = C.ImGuiTableFlags_SizingMask_
--===
--=== enum ImGuiTableColumnFlags_ ===
M.TableColumnFlags_None = C.ImGuiTableColumnFlags_None
M.TableColumnFlags_DefaultHide = C.ImGuiTableColumnFlags_DefaultHide
M.TableColumnFlags_DefaultSort = C.ImGuiTableColumnFlags_DefaultSort
M.TableColumnFlags_WidthStretch = C.ImGuiTableColumnFlags_WidthStretch
M.TableColumnFlags_WidthFixed = C.ImGuiTableColumnFlags_WidthFixed
M.TableColumnFlags_NoResize = C.ImGuiTableColumnFlags_NoResize
M.TableColumnFlags_NoReorder = C.ImGuiTableColumnFlags_NoReorder
M.TableColumnFlags_NoHide = C.ImGuiTableColumnFlags_NoHide
M.TableColumnFlags_NoClip = C.ImGuiTableColumnFlags_NoClip
M.TableColumnFlags_NoSort = C.ImGuiTableColumnFlags_NoSort
M.TableColumnFlags_NoSortAscending = C.ImGuiTableColumnFlags_NoSortAscending
M.TableColumnFlags_NoSortDescending = C.ImGuiTableColumnFlags_NoSortDescending
M.TableColumnFlags_NoHeaderWidth = C.ImGuiTableColumnFlags_NoHeaderWidth
M.TableColumnFlags_PreferSortAscending = C.ImGuiTableColumnFlags_PreferSortAscending
M.TableColumnFlags_PreferSortDescending = C.ImGuiTableColumnFlags_PreferSortDescending
M.TableColumnFlags_IndentEnable = C.ImGuiTableColumnFlags_IndentEnable
M.TableColumnFlags_IndentDisable = C.ImGuiTableColumnFlags_IndentDisable
M.TableColumnFlags_IsEnabled = C.ImGuiTableColumnFlags_IsEnabled
M.TableColumnFlags_IsVisible = C.ImGuiTableColumnFlags_IsVisible
M.TableColumnFlags_IsSorted = C.ImGuiTableColumnFlags_IsSorted
M.TableColumnFlags_IsHovered = C.ImGuiTableColumnFlags_IsHovered
M.TableColumnFlags_WidthMask_ = C.ImGuiTableColumnFlags_WidthMask_
M.TableColumnFlags_IndentMask_ = C.ImGuiTableColumnFlags_IndentMask_
M.TableColumnFlags_StatusMask_ = C.ImGuiTableColumnFlags_StatusMask_
M.TableColumnFlags_NoDirectResize_ = C.ImGuiTableColumnFlags_NoDirectResize_
--===
--=== enum ImGuiTableRowFlags_ ===
M.TableRowFlags_None = C.ImGuiTableRowFlags_None
M.TableRowFlags_Headers = C.ImGuiTableRowFlags_Headers
--===
--=== enum ImGuiTableBgTarget_ ===
M.TableBgTarget_None = C.ImGuiTableBgTarget_None
M.TableBgTarget_RowBg0 = C.ImGuiTableBgTarget_RowBg0
M.TableBgTarget_RowBg1 = C.ImGuiTableBgTarget_RowBg1
M.TableBgTarget_CellBg = C.ImGuiTableBgTarget_CellBg
--===
--=== enum ImGuiFocusedFlags_ ===
M.FocusedFlags_None = C.ImGuiFocusedFlags_None
M.FocusedFlags_ChildWindows = C.ImGuiFocusedFlags_ChildWindows
M.FocusedFlags_RootWindow = C.ImGuiFocusedFlags_RootWindow
M.FocusedFlags_AnyWindow = C.ImGuiFocusedFlags_AnyWindow
M.FocusedFlags_RootAndChildWindows = C.ImGuiFocusedFlags_RootAndChildWindows
--===
--=== enum ImGuiHoveredFlags_ ===
M.HoveredFlags_None = C.ImGuiHoveredFlags_None
M.HoveredFlags_ChildWindows = C.ImGuiHoveredFlags_ChildWindows
M.HoveredFlags_RootWindow = C.ImGuiHoveredFlags_RootWindow
M.HoveredFlags_AnyWindow = C.ImGuiHoveredFlags_AnyWindow
M.HoveredFlags_AllowWhenBlockedByPopup = C.ImGuiHoveredFlags_AllowWhenBlockedByPopup
M.HoveredFlags_AllowWhenBlockedByActiveItem = C.ImGuiHoveredFlags_AllowWhenBlockedByActiveItem
M.HoveredFlags_AllowWhenOverlapped = C.ImGuiHoveredFlags_AllowWhenOverlapped
M.HoveredFlags_AllowWhenDisabled = C.ImGuiHoveredFlags_AllowWhenDisabled
M.HoveredFlags_RectOnly = C.ImGuiHoveredFlags_RectOnly
M.HoveredFlags_RootAndChildWindows = C.ImGuiHoveredFlags_RootAndChildWindows
--===
--=== enum ImGuiDockNodeFlags_ ===
M.DockNodeFlags_None = C.ImGuiDockNodeFlags_None
M.DockNodeFlags_KeepAliveOnly = C.ImGuiDockNodeFlags_KeepAliveOnly
M.DockNodeFlags_NoDockingInCentralNode = C.ImGuiDockNodeFlags_NoDockingInCentralNode
M.DockNodeFlags_PassthruCentralNode = C.ImGuiDockNodeFlags_PassthruCentralNode
M.DockNodeFlags_NoSplit = C.ImGuiDockNodeFlags_NoSplit
M.DockNodeFlags_NoResize = C.ImGuiDockNodeFlags_NoResize
M.DockNodeFlags_AutoHideTabBar = C.ImGuiDockNodeFlags_AutoHideTabBar
--===
--=== enum ImGuiDragDropFlags_ ===
M.DragDropFlags_None = C.ImGuiDragDropFlags_None
M.DragDropFlags_SourceNoPreviewTooltip = C.ImGuiDragDropFlags_SourceNoPreviewTooltip
M.DragDropFlags_SourceNoDisableHover = C.ImGuiDragDropFlags_SourceNoDisableHover
M.DragDropFlags_SourceNoHoldToOpenOthers = C.ImGuiDragDropFlags_SourceNoHoldToOpenOthers
M.DragDropFlags_SourceAllowNullID = C.ImGuiDragDropFlags_SourceAllowNullID
M.DragDropFlags_SourceExtern = C.ImGuiDragDropFlags_SourceExtern
M.DragDropFlags_SourceAutoExpirePayload = C.ImGuiDragDropFlags_SourceAutoExpirePayload
M.DragDropFlags_AcceptBeforeDelivery = C.ImGuiDragDropFlags_AcceptBeforeDelivery
M.DragDropFlags_AcceptNoDrawDefaultRect = C.ImGuiDragDropFlags_AcceptNoDrawDefaultRect
M.DragDropFlags_AcceptNoPreviewTooltip = C.ImGuiDragDropFlags_AcceptNoPreviewTooltip
M.DragDropFlags_AcceptPeekOnly = C.ImGuiDragDropFlags_AcceptPeekOnly
--===
--=== enum ImGuiDataType_ ===
M.DataType_S8 = C.ImGuiDataType_S8
M.DataType_U8 = C.ImGuiDataType_U8
M.DataType_S16 = C.ImGuiDataType_S16
M.DataType_U16 = C.ImGuiDataType_U16
M.DataType_S32 = C.ImGuiDataType_S32
M.DataType_U32 = C.ImGuiDataType_U32
M.DataType_S64 = C.ImGuiDataType_S64
M.DataType_U64 = C.ImGuiDataType_U64
M.DataType_Float = C.ImGuiDataType_Float
M.DataType_Double = C.ImGuiDataType_Double
M.DataType_COUNT = C.ImGuiDataType_COUNT
--===
--=== enum ImGuiDir_ ===
M.Dir_None = C.ImGuiDir_None
M.Dir_Left = C.ImGuiDir_Left
M.Dir_Right = C.ImGuiDir_Right
M.Dir_Up = C.ImGuiDir_Up
M.Dir_Down = C.ImGuiDir_Down
M.Dir_COUNT = C.ImGuiDir_COUNT
--===
--=== enum ImGuiSortDirection_ ===
M.SortDirection_None = C.ImGuiSortDirection_None
M.SortDirection_Ascending = C.ImGuiSortDirection_Ascending
M.SortDirection_Descending = C.ImGuiSortDirection_Descending
--===
--=== enum ImGuiKey_ ===
M.Key_Tab = C.ImGuiKey_Tab
M.Key_LeftArrow = C.ImGuiKey_LeftArrow
M.Key_RightArrow = C.ImGuiKey_RightArrow
M.Key_UpArrow = C.ImGuiKey_UpArrow
M.Key_DownArrow = C.ImGuiKey_DownArrow
M.Key_PageUp = C.ImGuiKey_PageUp
M.Key_PageDown = C.ImGuiKey_PageDown
M.Key_Home = C.ImGuiKey_Home
M.Key_End = C.ImGuiKey_End
M.Key_Insert = C.ImGuiKey_Insert
M.Key_Delete = C.ImGuiKey_Delete
M.Key_Backspace = C.ImGuiKey_Backspace
M.Key_Space = C.ImGuiKey_Space
M.Key_Enter = C.ImGuiKey_Enter
M.Key_Escape = C.ImGuiKey_Escape
M.Key_KeyPadEnter = C.ImGuiKey_KeyPadEnter
M.Key_A = C.ImGuiKey_A
M.Key_C = C.ImGuiKey_C
M.Key_V = C.ImGuiKey_V
M.Key_X = C.ImGuiKey_X
M.Key_Y = C.ImGuiKey_Y
M.Key_Z = C.ImGuiKey_Z
M.Key_COUNT = C.ImGuiKey_COUNT
--===
--=== enum ImGuiKeyModFlags_ ===
M.KeyModFlags_None = C.ImGuiKeyModFlags_None
M.KeyModFlags_Ctrl = C.ImGuiKeyModFlags_Ctrl
M.KeyModFlags_Shift = C.ImGuiKeyModFlags_Shift
M.KeyModFlags_Alt = C.ImGuiKeyModFlags_Alt
M.KeyModFlags_Super = C.ImGuiKeyModFlags_Super
--===
--=== enum ImGuiNavInput_ ===
M.NavInput_Activate = C.ImGuiNavInput_Activate
M.NavInput_Cancel = C.ImGuiNavInput_Cancel
M.NavInput_Input = C.ImGuiNavInput_Input
M.NavInput_Menu = C.ImGuiNavInput_Menu
M.NavInput_DpadLeft = C.ImGuiNavInput_DpadLeft
M.NavInput_DpadRight = C.ImGuiNavInput_DpadRight
M.NavInput_DpadUp = C.ImGuiNavInput_DpadUp
M.NavInput_DpadDown = C.ImGuiNavInput_DpadDown
M.NavInput_LStickLeft = C.ImGuiNavInput_LStickLeft
M.NavInput_LStickRight = C.ImGuiNavInput_LStickRight
M.NavInput_LStickUp = C.ImGuiNavInput_LStickUp
M.NavInput_LStickDown = C.ImGuiNavInput_LStickDown
M.NavInput_FocusPrev = C.ImGuiNavInput_FocusPrev
M.NavInput_FocusNext = C.ImGuiNavInput_FocusNext
M.NavInput_TweakSlow = C.ImGuiNavInput_TweakSlow
M.NavInput_TweakFast = C.ImGuiNavInput_TweakFast
M.NavInput_KeyMenu_ = C.ImGuiNavInput_KeyMenu_
M.NavInput_KeyLeft_ = C.ImGuiNavInput_KeyLeft_
M.NavInput_KeyRight_ = C.ImGuiNavInput_KeyRight_
M.NavInput_KeyUp_ = C.ImGuiNavInput_KeyUp_
M.NavInput_KeyDown_ = C.ImGuiNavInput_KeyDown_
M.NavInput_COUNT = C.ImGuiNavInput_COUNT
M.NavInput_InternalStart_ = C.ImGuiNavInput_InternalStart_
--===
--=== enum ImGuiConfigFlags_ ===
M.ConfigFlags_None = C.ImGuiConfigFlags_None
M.ConfigFlags_NavEnableKeyboard = C.ImGuiConfigFlags_NavEnableKeyboard
M.ConfigFlags_NavEnableGamepad = C.ImGuiConfigFlags_NavEnableGamepad
M.ConfigFlags_NavEnableSetMousePos = C.ImGuiConfigFlags_NavEnableSetMousePos
M.ConfigFlags_NavNoCaptureKeyboard = C.ImGuiConfigFlags_NavNoCaptureKeyboard
M.ConfigFlags_NoMouse = C.ImGuiConfigFlags_NoMouse
M.ConfigFlags_NoMouseCursorChange = C.ImGuiConfigFlags_NoMouseCursorChange
M.ConfigFlags_DockingEnable = C.ImGuiConfigFlags_DockingEnable
M.ConfigFlags_ViewportsEnable = C.ImGuiConfigFlags_ViewportsEnable
M.ConfigFlags_DpiEnableScaleViewports = C.ImGuiConfigFlags_DpiEnableScaleViewports
M.ConfigFlags_DpiEnableScaleFonts = C.ImGuiConfigFlags_DpiEnableScaleFonts
M.ConfigFlags_IsSRGB = C.ImGuiConfigFlags_IsSRGB
M.ConfigFlags_IsTouchScreen = C.ImGuiConfigFlags_IsTouchScreen
--===
--=== enum ImGuiBackendFlags_ ===
M.BackendFlags_None = C.ImGuiBackendFlags_None
M.BackendFlags_HasGamepad = C.ImGuiBackendFlags_HasGamepad
M.BackendFlags_HasMouseCursors = C.ImGuiBackendFlags_HasMouseCursors
M.BackendFlags_HasSetMousePos = C.ImGuiBackendFlags_HasSetMousePos
M.BackendFlags_RendererHasVtxOffset = C.ImGuiBackendFlags_RendererHasVtxOffset
M.BackendFlags_PlatformHasViewports = C.ImGuiBackendFlags_PlatformHasViewports
M.BackendFlags_HasMouseHoveredViewport = C.ImGuiBackendFlags_HasMouseHoveredViewport
M.BackendFlags_RendererHasViewports = C.ImGuiBackendFlags_RendererHasViewports
--===
--=== enum ImGuiCol_ ===
M.Col_Text = C.ImGuiCol_Text
M.Col_TextDisabled = C.ImGuiCol_TextDisabled
M.Col_WindowBg = C.ImGuiCol_WindowBg
M.Col_ChildBg = C.ImGuiCol_ChildBg
M.Col_PopupBg = C.ImGuiCol_PopupBg
M.Col_Border = C.ImGuiCol_Border
M.Col_BorderShadow = C.ImGuiCol_BorderShadow
M.Col_FrameBg = C.ImGuiCol_FrameBg
M.Col_FrameBgHovered = C.ImGuiCol_FrameBgHovered
M.Col_FrameBgActive = C.ImGuiCol_FrameBgActive
M.Col_TitleBg = C.ImGuiCol_TitleBg
M.Col_TitleBgActive = C.ImGuiCol_TitleBgActive
M.Col_TitleBgCollapsed = C.ImGuiCol_TitleBgCollapsed
M.Col_MenuBarBg = C.ImGuiCol_MenuBarBg
M.Col_ScrollbarBg = C.ImGuiCol_ScrollbarBg
M.Col_ScrollbarGrab = C.ImGuiCol_ScrollbarGrab
M.Col_ScrollbarGrabHovered = C.ImGuiCol_ScrollbarGrabHovered
M.Col_ScrollbarGrabActive = C.ImGuiCol_ScrollbarGrabActive
M.Col_CheckMark = C.ImGuiCol_CheckMark
M.Col_SliderGrab = C.ImGuiCol_SliderGrab
M.Col_SliderGrabActive = C.ImGuiCol_SliderGrabActive
M.Col_Button = C.ImGuiCol_Button
M.Col_ButtonHovered = C.ImGuiCol_ButtonHovered
M.Col_ButtonActive = C.ImGuiCol_ButtonActive
M.Col_Header = C.ImGuiCol_Header
M.Col_HeaderHovered = C.ImGuiCol_HeaderHovered
M.Col_HeaderActive = C.ImGuiCol_HeaderActive
M.Col_Separator = C.ImGuiCol_Separator
M.Col_SeparatorHovered = C.ImGuiCol_SeparatorHovered
M.Col_SeparatorActive = C.ImGuiCol_SeparatorActive
M.Col_ResizeGrip = C.ImGuiCol_ResizeGrip
M.Col_ResizeGripHovered = C.ImGuiCol_ResizeGripHovered
M.Col_ResizeGripActive = C.ImGuiCol_ResizeGripActive
M.Col_Tab = C.ImGuiCol_Tab
M.Col_TabHovered = C.ImGuiCol_TabHovered
M.Col_TabActive = C.ImGuiCol_TabActive
M.Col_TabUnfocused = C.ImGuiCol_TabUnfocused
M.Col_TabUnfocusedActive = C.ImGuiCol_TabUnfocusedActive
M.Col_DockingPreview = C.ImGuiCol_DockingPreview
M.Col_DockingEmptyBg = C.ImGuiCol_DockingEmptyBg
M.Col_PlotLines = C.ImGuiCol_PlotLines
M.Col_PlotLinesHovered = C.ImGuiCol_PlotLinesHovered
M.Col_PlotHistogram = C.ImGuiCol_PlotHistogram
M.Col_PlotHistogramHovered = C.ImGuiCol_PlotHistogramHovered
M.Col_TableHeaderBg = C.ImGuiCol_TableHeaderBg
M.Col_TableBorderStrong = C.ImGuiCol_TableBorderStrong
M.Col_TableBorderLight = C.ImGuiCol_TableBorderLight
M.Col_TableRowBg = C.ImGuiCol_TableRowBg
M.Col_TableRowBgAlt = C.ImGuiCol_TableRowBgAlt
M.Col_TextSelectedBg = C.ImGuiCol_TextSelectedBg
M.Col_DragDropTarget = C.ImGuiCol_DragDropTarget
M.Col_NavHighlight = C.ImGuiCol_NavHighlight
M.Col_NavWindowingHighlight = C.ImGuiCol_NavWindowingHighlight
M.Col_NavWindowingDimBg = C.ImGuiCol_NavWindowingDimBg
M.Col_ModalWindowDimBg = C.ImGuiCol_ModalWindowDimBg
M.Col_COUNT = C.ImGuiCol_COUNT
--===
--=== enum ImGuiStyleVar_ ===
M.StyleVar_Alpha = C.ImGuiStyleVar_Alpha
M.StyleVar_WindowPadding = C.ImGuiStyleVar_WindowPadding
M.StyleVar_WindowRounding = C.ImGuiStyleVar_WindowRounding
M.StyleVar_WindowBorderSize = C.ImGuiStyleVar_WindowBorderSize
M.StyleVar_WindowMinSize = C.ImGuiStyleVar_WindowMinSize
M.StyleVar_WindowTitleAlign = C.ImGuiStyleVar_WindowTitleAlign
M.StyleVar_ChildRounding = C.ImGuiStyleVar_ChildRounding
M.StyleVar_ChildBorderSize = C.ImGuiStyleVar_ChildBorderSize
M.StyleVar_PopupRounding = C.ImGuiStyleVar_PopupRounding
M.StyleVar_PopupBorderSize = C.ImGuiStyleVar_PopupBorderSize
M.StyleVar_FramePadding = C.ImGuiStyleVar_FramePadding
M.StyleVar_FrameRounding = C.ImGuiStyleVar_FrameRounding
M.StyleVar_FrameBorderSize = C.ImGuiStyleVar_FrameBorderSize
M.StyleVar_ItemSpacing = C.ImGuiStyleVar_ItemSpacing
M.StyleVar_ItemInnerSpacing = C.ImGuiStyleVar_ItemInnerSpacing
M.StyleVar_IndentSpacing = C.ImGuiStyleVar_IndentSpacing
M.StyleVar_CellPadding = C.ImGuiStyleVar_CellPadding
M.StyleVar_ScrollbarSize = C.ImGuiStyleVar_ScrollbarSize
M.StyleVar_ScrollbarRounding = C.ImGuiStyleVar_ScrollbarRounding
M.StyleVar_GrabMinSize = C.ImGuiStyleVar_GrabMinSize
M.StyleVar_GrabRounding = C.ImGuiStyleVar_GrabRounding
M.StyleVar_TabRounding = C.ImGuiStyleVar_TabRounding
M.StyleVar_ButtonTextAlign = C.ImGuiStyleVar_ButtonTextAlign
M.StyleVar_SelectableTextAlign = C.ImGuiStyleVar_SelectableTextAlign
M.StyleVar_COUNT = C.ImGuiStyleVar_COUNT
--===
--=== enum ImGuiButtonFlags_ ===
M.ButtonFlags_None = C.ImGuiButtonFlags_None
M.ButtonFlags_MouseButtonLeft = C.ImGuiButtonFlags_MouseButtonLeft
M.ButtonFlags_MouseButtonRight = C.ImGuiButtonFlags_MouseButtonRight
M.ButtonFlags_MouseButtonMiddle = C.ImGuiButtonFlags_MouseButtonMiddle
M.ButtonFlags_MouseButtonMask_ = C.ImGuiButtonFlags_MouseButtonMask_
M.ButtonFlags_MouseButtonDefault_ = C.ImGuiButtonFlags_MouseButtonDefault_
--===
--=== enum ImGuiColorEditFlags_ ===
M.ColorEditFlags_None = C.ImGuiColorEditFlags_None
M.ColorEditFlags_NoAlpha = C.ImGuiColorEditFlags_NoAlpha
M.ColorEditFlags_NoPicker = C.ImGuiColorEditFlags_NoPicker
M.ColorEditFlags_NoOptions = C.ImGuiColorEditFlags_NoOptions
M.ColorEditFlags_NoSmallPreview = C.ImGuiColorEditFlags_NoSmallPreview
M.ColorEditFlags_NoInputs = C.ImGuiColorEditFlags_NoInputs
M.ColorEditFlags_NoTooltip = C.ImGuiColorEditFlags_NoTooltip
M.ColorEditFlags_NoLabel = C.ImGuiColorEditFlags_NoLabel
M.ColorEditFlags_NoSidePreview = C.ImGuiColorEditFlags_NoSidePreview
M.ColorEditFlags_NoDragDrop = C.ImGuiColorEditFlags_NoDragDrop
M.ColorEditFlags_NoBorder = C.ImGuiColorEditFlags_NoBorder
M.ColorEditFlags_AlphaBar = C.ImGuiColorEditFlags_AlphaBar
M.ColorEditFlags_AlphaPreview = C.ImGuiColorEditFlags_AlphaPreview
M.ColorEditFlags_AlphaPreviewHalf = C.ImGuiColorEditFlags_AlphaPreviewHalf
M.ColorEditFlags_HDR = C.ImGuiColorEditFlags_HDR
M.ColorEditFlags_DisplayRGB = C.ImGuiColorEditFlags_DisplayRGB
M.ColorEditFlags_DisplayHSV = C.ImGuiColorEditFlags_DisplayHSV
M.ColorEditFlags_DisplayHex = C.ImGuiColorEditFlags_DisplayHex
M.ColorEditFlags_Uint8 = C.ImGuiColorEditFlags_Uint8
M.ColorEditFlags_Float = C.ImGuiColorEditFlags_Float
M.ColorEditFlags_PickerHueBar = C.ImGuiColorEditFlags_PickerHueBar
M.ColorEditFlags_PickerHueWheel = C.ImGuiColorEditFlags_PickerHueWheel
M.ColorEditFlags_InputRGB = C.ImGuiColorEditFlags_InputRGB
M.ColorEditFlags_InputHSV = C.ImGuiColorEditFlags_InputHSV
M.ColorEditFlags__OptionsDefault = C.ImGuiColorEditFlags__OptionsDefault
M.ColorEditFlags__DisplayMask = C.ImGuiColorEditFlags__DisplayMask
M.ColorEditFlags__DataTypeMask = C.ImGuiColorEditFlags__DataTypeMask
M.ColorEditFlags__PickerMask = C.ImGuiColorEditFlags__PickerMask
M.ColorEditFlags__InputMask = C.ImGuiColorEditFlags__InputMask
--===
--=== enum ImGuiSliderFlags_ ===
M.SliderFlags_None = C.ImGuiSliderFlags_None
M.SliderFlags_AlwaysClamp = C.ImGuiSliderFlags_AlwaysClamp
M.SliderFlags_Logarithmic = C.ImGuiSliderFlags_Logarithmic
M.SliderFlags_NoRoundToFormat = C.ImGuiSliderFlags_NoRoundToFormat
M.SliderFlags_NoInput = C.ImGuiSliderFlags_NoInput
M.SliderFlags_InvalidMask_ = C.ImGuiSliderFlags_InvalidMask_
--===
--=== enum ImGuiMouseButton_ ===
M.MouseButton_Left = C.ImGuiMouseButton_Left
M.MouseButton_Right = C.ImGuiMouseButton_Right
M.MouseButton_Middle = C.ImGuiMouseButton_Middle
M.MouseButton_COUNT = C.ImGuiMouseButton_COUNT
--===
--=== enum ImGuiMouseCursor_ ===
M.MouseCursor_None = C.ImGuiMouseCursor_None
M.MouseCursor_Arrow = C.ImGuiMouseCursor_Arrow
M.MouseCursor_TextInput = C.ImGuiMouseCursor_TextInput
M.MouseCursor_ResizeAll = C.ImGuiMouseCursor_ResizeAll
M.MouseCursor_ResizeNS = C.ImGuiMouseCursor_ResizeNS
M.MouseCursor_ResizeEW = C.ImGuiMouseCursor_ResizeEW
M.MouseCursor_ResizeNESW = C.ImGuiMouseCursor_ResizeNESW
M.MouseCursor_ResizeNWSE = C.ImGuiMouseCursor_ResizeNWSE
M.MouseCursor_Hand = C.ImGuiMouseCursor_Hand
M.MouseCursor_NotAllowed = C.ImGuiMouseCursor_NotAllowed
M.MouseCursor_COUNT = C.ImGuiMouseCursor_COUNT
--===
--=== enum ImGuiCond_ ===
M.Cond_None = C.ImGuiCond_None
M.Cond_Always = C.ImGuiCond_Always
M.Cond_Once = C.ImGuiCond_Once
M.Cond_FirstUseEver = C.ImGuiCond_FirstUseEver
M.Cond_Appearing = C.ImGuiCond_Appearing
--===
--=== struct ImNewWrapper ===
--===
--=== struct ImGuiStyle ===
function M.ImGuiStyle() return ffi.new("ImGuiStyle") end
function M.ImGuiStylePtr() return ffi.new("ImGuiStyle[1]") end
function M.ImGuiStyle_ScaleAllSizes(ImGuiStyle_ctx, float_scale_factor) C.ImGui_ImGuiStyle_ScaleAllSizes(ImGuiStyle_ctx, float_scale_factor) end
--===
--=== struct ImGuiIO ===
function M.ImGuiIO_AddInputCharacter(ImGuiIO_ctx, int_c) C.ImGui_ImGuiIO_AddInputCharacter(ImGuiIO_ctx, int_c) end
function M.ImGuiIO_AddInputCharacterUTF16(ImGuiIO_ctx, ImWchar16_c) C.ImGui_ImGuiIO_AddInputCharacterUTF16(ImGuiIO_ctx, ImWchar16_c) end
function M.ImGuiIO_AddInputCharactersUTF8(ImGuiIO_ctx, string_str)
  if string_str == nil then  return end
  C.ImGui_ImGuiIO_AddInputCharactersUTF8(ImGuiIO_ctx, string_str)
end
function M.ImGuiIO_ClearInputCharacters(ImGuiIO_ctx) C.ImGui_ImGuiIO_ClearInputCharacters(ImGuiIO_ctx) end
function M.ImGuiIO() return ffi.new("ImGuiIO") end
function M.ImGuiIOPtr() return ffi.new("ImGuiIO[1]") end
--===
--=== struct ImGuiInputTextCallbackData ===
function M.ImGuiInputTextCallbackData() return ffi.new("ImGuiInputTextCallbackData") end
function M.ImGuiInputTextCallbackDataPtr() return ffi.new("ImGuiInputTextCallbackData[1]") end
function M.ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData_ctx, int_pos, int_bytes_count) C.ImGui_ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData_ctx, int_pos, int_bytes_count) end
function M.ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData_ctx, int_pos, string_text, string_text_end)
  -- string_text_end is optional and can be nil
  if string_text == nil then  return end
  C.ImGui_ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData_ctx, int_pos, string_text, string_text_end)
end
function M.ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData_ctx) C.ImGui_ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData_ctx) end
function M.ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData_ctx) C.ImGui_ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData_ctx) end
function M.ImGuiInputTextCallbackData_HasSelection(ImGuiInputTextCallbackData_ctx) return C.ImGui_ImGuiInputTextCallbackData_HasSelection(ImGuiInputTextCallbackData_ctx) end
--===
--=== struct ImGuiSizeCallbackData ===
--===
--=== struct ImGuiWindowClass ===
function M.ImGuiWindowClass() return ffi.new("ImGuiWindowClass") end
function M.ImGuiWindowClassPtr() return ffi.new("ImGuiWindowClass[1]") end
--===
--=== struct ImGuiPayload ===
function M.ImGuiPayload() return ffi.new("ImGuiPayload") end
function M.ImGuiPayloadPtr() return ffi.new("ImGuiPayload[1]") end
function M.ImGuiPayload_Clear(ImGuiPayload_ctx) C.ImGui_ImGuiPayload_Clear(ImGuiPayload_ctx) end
function M.ImGuiPayload_IsDataType(ImGuiPayload_ctx, string_type)
  if string_type == nil then  return end
  return C.ImGui_ImGuiPayload_IsDataType(ImGuiPayload_ctx, string_type)
end
function M.ImGuiPayload_IsPreview(ImGuiPayload_ctx) return C.ImGui_ImGuiPayload_IsPreview(ImGuiPayload_ctx) end
function M.ImGuiPayload_IsDelivery(ImGuiPayload_ctx) return C.ImGui_ImGuiPayload_IsDelivery(ImGuiPayload_ctx) end
--===
--=== struct ImGuiTableColumnSortSpecs ===
function M.ImGuiTableColumnSortSpecs() return ffi.new("ImGuiTableColumnSortSpecs") end
function M.ImGuiTableColumnSortSpecsPtr() return ffi.new("ImGuiTableColumnSortSpecs[1]") end
--===
--=== struct ImGuiTableSortSpecs ===
function M.ImGuiTableSortSpecs() return ffi.new("ImGuiTableSortSpecs") end
function M.ImGuiTableSortSpecsPtr() return ffi.new("ImGuiTableSortSpecs[1]") end
--===
--=== struct ImGuiTextFilter ===
function M.ImGuiTextFilter_Draw(ImGuiTextFilter_ctx, string_label, float_width)
  if string_label == nil then string_label = "Filter (inc,-exc)" end
  if float_width == nil then float_width = 0 end
  return C.ImGui_ImGuiTextFilter_Draw(ImGuiTextFilter_ctx, string_label, float_width)
end
function M.ImGuiTextFilter_PassFilter(ImGuiTextFilter_ctx, string_text, string_text_end)
  -- string_text_end is optional and can be nil
  if string_text == nil then  return end
  return C.ImGui_ImGuiTextFilter_PassFilter(ImGuiTextFilter_ctx, string_text, string_text_end)
end
function M.ImGuiTextFilter_Build(ImGuiTextFilter_ctx) C.ImGui_ImGuiTextFilter_Build(ImGuiTextFilter_ctx) end
function M.ImGuiTextFilter_Clear(ImGuiTextFilter_ctx) C.ImGui_ImGuiTextFilter_Clear(ImGuiTextFilter_ctx) end
function M.ImGuiTextFilter_IsActive(ImGuiTextFilter_ctx) return C.ImGui_ImGuiTextFilter_IsActive(ImGuiTextFilter_ctx) end
--===
--=== struct ImGuiTextBuffer ===
function M.ImGuiTextBuffer() return ffi.new("ImGuiTextBuffer") end
function M.ImGuiTextBufferPtr() return ffi.new("ImGuiTextBuffer[1]") end
function M.ImGuiTextBuffer_begin(ImGuiTextBuffer_ctx) return C.ImGui_ImGuiTextBuffer_begin(ImGuiTextBuffer_ctx) end
function M.ImGuiTextBuffer_end(ImGuiTextBuffer_ctx) return C.ImGui_ImGuiTextBuffer_end(ImGuiTextBuffer_ctx) end
function M.ImGuiTextBuffer_size(ImGuiTextBuffer_ctx) return C.ImGui_ImGuiTextBuffer_size(ImGuiTextBuffer_ctx) end
function M.ImGuiTextBuffer_empty(ImGuiTextBuffer_ctx) return C.ImGui_ImGuiTextBuffer_empty(ImGuiTextBuffer_ctx) end
function M.ImGuiTextBuffer_clear(ImGuiTextBuffer_ctx) C.ImGui_ImGuiTextBuffer_clear(ImGuiTextBuffer_ctx) end
function M.ImGuiTextBuffer_reserve(ImGuiTextBuffer_ctx, int_capacity) C.ImGui_ImGuiTextBuffer_reserve(ImGuiTextBuffer_ctx, int_capacity) end
function M.ImGuiTextBuffer_c_str(ImGuiTextBuffer_ctx) return C.ImGui_ImGuiTextBuffer_c_str(ImGuiTextBuffer_ctx) end
function M.ImGuiTextBuffer_append(ImGuiTextBuffer_ctx, string_str, string_str_end)
  -- string_str_end is optional and can be nil
  if string_str == nil then  return end
  C.ImGui_ImGuiTextBuffer_append(ImGuiTextBuffer_ctx, string_str, string_str_end)
end
function M.ImGuiTextBuffer_appendfv(ImGuiTextBuffer_ctx, string_fmt, va_list_args)
  if string_fmt == nil then  return end
  C.ImGui_ImGuiTextBuffer_appendfv(ImGuiTextBuffer_ctx, string_fmt, va_list_args)
end
--===
--=== struct ImGuiStorage ===
function M.ImGuiStorage_Clear(ImGuiStorage_ctx) C.ImGui_ImGuiStorage_Clear(ImGuiStorage_ctx) end
function M.ImGuiStorage_GetInt(ImGuiStorage_ctx, ImGuiID_key, int_default_val)
  if int_default_val == nil then int_default_val = 0 end
  return C.ImGui_ImGuiStorage_GetInt(ImGuiStorage_ctx, ImGuiID_key, int_default_val)
end
function M.ImGuiStorage_SetInt(ImGuiStorage_ctx, ImGuiID_key, int_val) C.ImGui_ImGuiStorage_SetInt(ImGuiStorage_ctx, ImGuiID_key, int_val) end
function M.ImGuiStorage_GetBool(ImGuiStorage_ctx, ImGuiID_key, bool_default_val)
  if bool_default_val == nil then bool_default_val = false end
  return C.ImGui_ImGuiStorage_GetBool(ImGuiStorage_ctx, ImGuiID_key, bool_default_val)
end
function M.ImGuiStorage_SetBool(ImGuiStorage_ctx, ImGuiID_key, bool_val) C.ImGui_ImGuiStorage_SetBool(ImGuiStorage_ctx, ImGuiID_key, bool_val) end
function M.ImGuiStorage_GetFloat(ImGuiStorage_ctx, ImGuiID_key, float_default_val)
  if float_default_val == nil then float_default_val = 0 end
  return C.ImGui_ImGuiStorage_GetFloat(ImGuiStorage_ctx, ImGuiID_key, float_default_val)
end
function M.ImGuiStorage_SetFloat(ImGuiStorage_ctx, ImGuiID_key, float_val) C.ImGui_ImGuiStorage_SetFloat(ImGuiStorage_ctx, ImGuiID_key, float_val) end
function M.ImGuiStorage_GetVoidPtr(ImGuiStorage_ctx, ImGuiID_key) return C.ImGui_ImGuiStorage_GetVoidPtr(ImGuiStorage_ctx, ImGuiID_key) end
function M.ImGuiStorage_SetVoidPtr(ImGuiStorage_ctx, ImGuiID_key, void_val)
  if void_val == nil then  return end
  C.ImGui_ImGuiStorage_SetVoidPtr(ImGuiStorage_ctx, ImGuiID_key, void_val)
end
function M.ImGuiStorage_GetIntRef(ImGuiStorage_ctx, ImGuiID_key, int_default_val)
  if int_default_val == nil then int_default_val = 0 end
  return C.ImGui_ImGuiStorage_GetIntRef(ImGuiStorage_ctx, ImGuiID_key, int_default_val)
end
function M.ImGuiStorage_GetBoolRef(ImGuiStorage_ctx, ImGuiID_key, bool_default_val)
  if bool_default_val == nil then bool_default_val = false end
  return C.ImGui_ImGuiStorage_GetBoolRef(ImGuiStorage_ctx, ImGuiID_key, bool_default_val)
end
function M.ImGuiStorage_GetFloatRef(ImGuiStorage_ctx, ImGuiID_key, float_default_val)
  if float_default_val == nil then float_default_val = 0 end
  return C.ImGui_ImGuiStorage_GetFloatRef(ImGuiStorage_ctx, ImGuiID_key, float_default_val)
end
function M.ImGuiStorage_GetVoidPtrRef(ImGuiStorage_ctx, ImGuiID_key, void_default_val)
  -- void_default_val is optional and can be nil
  return C.ImGui_ImGuiStorage_GetVoidPtrRef(ImGuiStorage_ctx, ImGuiID_key, void_default_val)
end
function M.ImGuiStorage_SetAllInt(ImGuiStorage_ctx, int_val) C.ImGui_ImGuiStorage_SetAllInt(ImGuiStorage_ctx, int_val) end
function M.ImGuiStorage_BuildSortByKey(ImGuiStorage_ctx) C.ImGui_ImGuiStorage_BuildSortByKey(ImGuiStorage_ctx) end
--===
--=== struct ImGuiListClipper ===
function M.ImGuiListClipper() return ffi.new("ImGuiListClipper") end
function M.ImGuiListClipperPtr() return ffi.new("ImGuiListClipper[1]") end
function M.ImGuiListClipper_Begin(ImGuiListClipper_ctx, int_items_count, float_items_height)
  if float_items_height == nil then float_items_height = -1 end
  C.ImGui_ImGuiListClipper_Begin(ImGuiListClipper_ctx, int_items_count, float_items_height)
end
function M.ImGuiListClipper_End(ImGuiListClipper_ctx) C.ImGui_ImGuiListClipper_End(ImGuiListClipper_ctx) end
function M.ImGuiListClipper_Step(ImGuiListClipper_ctx) return C.ImGui_ImGuiListClipper_Step(ImGuiListClipper_ctx) end
--===
--=== struct ImColor ===
function M.ImColor() return ffi.new("ImColor") end
function M.ImColorPtr() return ffi.new("ImColor[1]") end
function M.ImColor(r, g, b, a)
  local res = ffi.new("ImColor")
  res.r = r
  res.g = g
  res.b = b
  res.a = a
  return res
end
function M.ImColorPtr(r, g, b, a)end
function M.ImColor(rgba)
  local res = ffi.new("ImColor")
  res.rgba = rgba
  return res
end
function M.ImColorPtr(rgba)end
function M.ImColor(r, g, b, a)
  local res = ffi.new("ImColor")
  res.r = r
  res.g = g
  res.b = b
  res.a = a
  return res
end
function M.ImColorPtr(r, g, b, a)end
function M.ImColor(col)
  local res = ffi.new("ImColor")
  res.col = col
  return res
end
function M.ImColorPtr(col)end
function M.ImColor_SetHSV(ImColor_ctx, float_h, float_s, float_v, float_a)
  if float_a == nil then float_a = 1 end
  C.ImGui_ImColor_SetHSV(ImColor_ctx, float_h, float_s, float_v, float_a)
end
function M.ImColor_HSV(ImColor_ctx, float_h, float_s, float_v, float_a)
  if float_a == nil then float_a = 1 end
  return C.ImGui_ImColor_HSV(ImColor_ctx, float_h, float_s, float_v, float_a)
end
--===
--=== struct ImDrawCmd ===
function M.ImDrawCmd() return ffi.new("ImDrawCmd") end
function M.ImDrawCmdPtr() return ffi.new("ImDrawCmd[1]") end
--===
--=== struct ImDrawVert ===
--===
--=== struct ImDrawCmdHeader ===
--===
--=== struct ImDrawListSplitter ===
function M.ImDrawListSplitter() return ffi.new("ImDrawListSplitter") end
function M.ImDrawListSplitterPtr() return ffi.new("ImDrawListSplitter[1]") end
function M.ImDrawListSplitter_Clear(ImDrawListSplitter_ctx) C.ImGui_ImDrawListSplitter_Clear(ImDrawListSplitter_ctx) end
function M.ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter_ctx) C.ImGui_ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter_ctx) end
function M.ImDrawListSplitter_Split(ImDrawListSplitter_ctx, ImDrawList_draw_list, int_count)
  if ImDrawList_draw_list == nil then  return end
  C.ImGui_ImDrawListSplitter_Split(ImDrawListSplitter_ctx, ImDrawList_draw_list, int_count)
end
function M.ImDrawListSplitter_Merge(ImDrawListSplitter_ctx, ImDrawList_draw_list)
  if ImDrawList_draw_list == nil then  return end
  C.ImGui_ImDrawListSplitter_Merge(ImDrawListSplitter_ctx, ImDrawList_draw_list)
end
function M.ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter_ctx, ImDrawList_draw_list, int_channel_idx)
  if ImDrawList_draw_list == nil then  return end
  C.ImGui_ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter_ctx, ImDrawList_draw_list, int_channel_idx)
end
--===
--=== enum ImDrawCornerFlags_ ===
M.ImDrawCornerFlags_None = C.ImDrawCornerFlags_None
M.ImDrawCornerFlags_TopLeft = C.ImDrawCornerFlags_TopLeft
M.ImDrawCornerFlags_TopRight = C.ImDrawCornerFlags_TopRight
M.ImDrawCornerFlags_BotLeft = C.ImDrawCornerFlags_BotLeft
M.ImDrawCornerFlags_BotRight = C.ImDrawCornerFlags_BotRight
M.ImDrawCornerFlags_Top = C.ImDrawCornerFlags_Top
M.ImDrawCornerFlags_Bot = C.ImDrawCornerFlags_Bot
M.ImDrawCornerFlags_Left = C.ImDrawCornerFlags_Left
M.ImDrawCornerFlags_Right = C.ImDrawCornerFlags_Right
M.ImDrawCornerFlags_All = C.ImDrawCornerFlags_All
--===
--=== enum ImDrawListFlags_ ===
M.ImDrawListFlags_None = C.ImDrawListFlags_None
M.ImDrawListFlags_AntiAliasedLines = C.ImDrawListFlags_AntiAliasedLines
M.ImDrawListFlags_AntiAliasedLinesUseTex = C.ImDrawListFlags_AntiAliasedLinesUseTex
M.ImDrawListFlags_AntiAliasedFill = C.ImDrawListFlags_AntiAliasedFill
M.ImDrawListFlags_AllowVtxOffset = C.ImDrawListFlags_AllowVtxOffset
--===
--=== struct ImDrawList ===
function M.ImDrawList_PushClipRect(ImDrawList_ctx, ImVec2_clip_rect_min, ImVec2_clip_rect_max, bool_intersect_with_current_clip_rect)
  if bool_intersect_with_current_clip_rect == nil then bool_intersect_with_current_clip_rect = false end
  C.ImGui_ImDrawList_PushClipRect(ImDrawList_ctx, ImVec2_clip_rect_min, ImVec2_clip_rect_max, bool_intersect_with_current_clip_rect)
end
function M.ImDrawList_PushClipRectFullScreen(ImDrawList_ctx) C.ImGui_ImDrawList_PushClipRectFullScreen(ImDrawList_ctx) end
function M.ImDrawList_PopClipRect(ImDrawList_ctx) C.ImGui_ImDrawList_PopClipRect(ImDrawList_ctx) end
function M.ImDrawList_PushTextureID(ImDrawList_ctx, ImTextureID_texture_id) C.ImGui_ImDrawList_PushTextureID(ImDrawList_ctx, ImTextureID_texture_id) end
function M.ImDrawList_PopTextureID(ImDrawList_ctx) C.ImGui_ImDrawList_PopTextureID(ImDrawList_ctx) end
function M.ImDrawList_GetClipRectMin(ImDrawList_ctx) return C.ImGui_ImDrawList_GetClipRectMin(ImDrawList_ctx) end
function M.ImDrawList_GetClipRectMax(ImDrawList_ctx) return C.ImGui_ImDrawList_GetClipRectMax(ImDrawList_ctx) end
function M.ImDrawList_AddLine(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImU32_col, float_thickness)
  if float_thickness == nil then float_thickness = 1 end
  C.ImGui_ImDrawList_AddLine(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImU32_col, float_thickness)
end
function M.ImDrawList_AddRect(ImDrawList_ctx, ImVec2_p_min, ImVec2_p_max, ImU32_col, float_rounding, ImDrawCornerFlags_rounding_corners, float_thickness)
  if float_rounding == nil then float_rounding = 0 end
  if ImDrawCornerFlags_rounding_corners == nil then ImDrawCornerFlags_rounding_corners = M.ImDrawCornerFlags_All end
  if float_thickness == nil then float_thickness = 1 end
  C.ImGui_ImDrawList_AddRect(ImDrawList_ctx, ImVec2_p_min, ImVec2_p_max, ImU32_col, float_rounding, ImDrawCornerFlags_rounding_corners, float_thickness)
end
function M.ImDrawList_AddRectFilled(ImDrawList_ctx, ImVec2_p_min, ImVec2_p_max, ImU32_col, float_rounding, ImDrawCornerFlags_rounding_corners)
  if float_rounding == nil then float_rounding = 0 end
  if ImDrawCornerFlags_rounding_corners == nil then ImDrawCornerFlags_rounding_corners = M.ImDrawCornerFlags_All end
  C.ImGui_ImDrawList_AddRectFilled(ImDrawList_ctx, ImVec2_p_min, ImVec2_p_max, ImU32_col, float_rounding, ImDrawCornerFlags_rounding_corners)
end
function M.ImDrawList_AddRectFilledMultiColor(ImDrawList_ctx, ImVec2_p_min, ImVec2_p_max, ImU32_col_upr_left, ImU32_col_upr_right, ImU32_col_bot_right, ImU32_col_bot_left) C.ImGui_ImDrawList_AddRectFilledMultiColor(ImDrawList_ctx, ImVec2_p_min, ImVec2_p_max, ImU32_col_upr_left, ImU32_col_upr_right, ImU32_col_bot_right, ImU32_col_bot_left) end
function M.ImDrawList_AddQuad(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImU32_col, float_thickness)
  if float_thickness == nil then float_thickness = 1 end
  C.ImGui_ImDrawList_AddQuad(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImU32_col, float_thickness)
end
function M.ImDrawList_AddQuadFilled(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImU32_col) C.ImGui_ImDrawList_AddQuadFilled(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImU32_col) end
function M.ImDrawList_AddTriangle(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImU32_col, float_thickness)
  if float_thickness == nil then float_thickness = 1 end
  C.ImGui_ImDrawList_AddTriangle(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImU32_col, float_thickness)
end
function M.ImDrawList_AddTriangleFilled(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImU32_col) C.ImGui_ImDrawList_AddTriangleFilled(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImU32_col) end
function M.ImDrawList_AddCircle(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments, float_thickness)
  if int_num_segments == nil then int_num_segments = 0 end
  if float_thickness == nil then float_thickness = 1 end
  C.ImGui_ImDrawList_AddCircle(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments, float_thickness)
end
function M.ImDrawList_AddCircleFilled(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments)
  if int_num_segments == nil then int_num_segments = 0 end
  C.ImGui_ImDrawList_AddCircleFilled(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments)
end
function M.ImDrawList_AddNgon(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments, float_thickness)
  if float_thickness == nil then float_thickness = 1 end
  C.ImGui_ImDrawList_AddNgon(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments, float_thickness)
end
function M.ImDrawList_AddNgonFilled(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments) C.ImGui_ImDrawList_AddNgonFilled(ImDrawList_ctx, ImVec2_center, float_radius, ImU32_col, int_num_segments) end
function M.ImDrawList_AddText1(ImDrawList_ctx, ImVec2_pos, ImU32_col, string_text_begin, string_text_end)
  -- string_text_end is optional and can be nil
  if string_text_begin == nil then  return end
  C.ImGui_ImDrawList_AddText1(ImDrawList_ctx, ImVec2_pos, ImU32_col, string_text_begin, string_text_end)
end
function M.ImDrawList_AddText2(ImDrawList_ctx, ImFont_font, float_font_size, ImVec2_pos, ImU32_col, string_text_begin, string_text_end, float_wrap_width, ImVec4_cpu_fine_clip_rect)
  -- string_text_end is optional and can be nil
  if float_wrap_width == nil then float_wrap_width = 0 end
  -- ImVec4_cpu_fine_clip_rect is optional and can be nil
  if ImFont_font == nil then  return end
  if string_text_begin == nil then  return end
  C.ImGui_ImDrawList_AddText2(ImDrawList_ctx, ImFont_font, float_font_size, ImVec2_pos, ImU32_col, string_text_begin, string_text_end, float_wrap_width, ImVec4_cpu_fine_clip_rect)
end
function M.ImDrawList_AddPolyline(ImDrawList_ctx, ImVec2_points, int_num_points, ImU32_col, bool_closed, float_thickness)
  if ImVec2_points == nil then  return end
  C.ImGui_ImDrawList_AddPolyline(ImDrawList_ctx, ImVec2_points, int_num_points, ImU32_col, bool_closed, float_thickness)
end
function M.ImDrawList_AddConvexPolyFilled(ImDrawList_ctx, ImVec2_points, int_num_points, ImU32_col)
  if ImVec2_points == nil then  return end
  C.ImGui_ImDrawList_AddConvexPolyFilled(ImDrawList_ctx, ImVec2_points, int_num_points, ImU32_col)
end
function M.ImDrawList_AddBezierCubic(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImU32_col, float_thickness, int_num_segments)
  if int_num_segments == nil then int_num_segments = 0 end
  C.ImGui_ImDrawList_AddBezierCubic(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImU32_col, float_thickness, int_num_segments)
end
function M.ImDrawList_AddBezierQuadratic(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImU32_col, float_thickness, int_num_segments)
  if int_num_segments == nil then int_num_segments = 0 end
  C.ImGui_ImDrawList_AddBezierQuadratic(ImDrawList_ctx, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImU32_col, float_thickness, int_num_segments)
end
function M.ImDrawList_AddImage(ImDrawList_ctx, ImTextureID_user_texture_id, ImVec2_p_min, ImVec2_p_max, ImVec2_uv_min, ImVec2_uv_max, ImU32_col)
  if ImVec2_uv_min == nil then ImVec2_uv_min = M.ImVec2(0,0) end
  if ImVec2_uv_max == nil then ImVec2_uv_max = M.ImVec2(1,1) end
  if ImU32_col == nil then ImU32_col = M.GetColorU322(M.ImVec4(1, 1, 1, 1.0)) end
  C.ImGui_ImDrawList_AddImage(ImDrawList_ctx, ImTextureID_user_texture_id, ImVec2_p_min, ImVec2_p_max, ImVec2_uv_min, ImVec2_uv_max, ImU32_col)
end
function M.ImDrawList_AddImageQuad(ImDrawList_ctx, ImTextureID_user_texture_id, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImVec2_uv1, ImVec2_uv2, ImVec2_uv3, ImVec2_uv4, ImU32_col)
  if ImVec2_uv1 == nil then ImVec2_uv1 = M.ImVec2(0,0) end
  if ImVec2_uv2 == nil then ImVec2_uv2 = M.ImVec2(1,0) end
  if ImVec2_uv3 == nil then ImVec2_uv3 = M.ImVec2(1,1) end
  if ImVec2_uv4 == nil then ImVec2_uv4 = M.ImVec2(0,1) end
  if ImU32_col == nil then ImU32_col = M.GetColorU322(M.ImVec4(1, 1, 1, 1.0)) end
  C.ImGui_ImDrawList_AddImageQuad(ImDrawList_ctx, ImTextureID_user_texture_id, ImVec2_p1, ImVec2_p2, ImVec2_p3, ImVec2_p4, ImVec2_uv1, ImVec2_uv2, ImVec2_uv3, ImVec2_uv4, ImU32_col)
end
function M.ImDrawList_AddImageRounded(ImDrawList_ctx, ImTextureID_user_texture_id, ImVec2_p_min, ImVec2_p_max, ImVec2_uv_min, ImVec2_uv_max, ImU32_col, float_rounding, ImDrawCornerFlags_rounding_corners)
  if ImDrawCornerFlags_rounding_corners == nil then ImDrawCornerFlags_rounding_corners = M.ImDrawCornerFlags_All end
  C.ImGui_ImDrawList_AddImageRounded(ImDrawList_ctx, ImTextureID_user_texture_id, ImVec2_p_min, ImVec2_p_max, ImVec2_uv_min, ImVec2_uv_max, ImU32_col, float_rounding, ImDrawCornerFlags_rounding_corners)
end
function M.ImDrawList_PathClear(ImDrawList_ctx) C.ImGui_ImDrawList_PathClear(ImDrawList_ctx) end
function M.ImDrawList_PathLineTo(ImDrawList_ctx, ImVec2_pos) C.ImGui_ImDrawList_PathLineTo(ImDrawList_ctx, ImVec2_pos) end
function M.ImDrawList_PathLineToMergeDuplicate(ImDrawList_ctx, ImVec2_pos) C.ImGui_ImDrawList_PathLineToMergeDuplicate(ImDrawList_ctx, ImVec2_pos) end
function M.ImDrawList_PathFillConvex(ImDrawList_ctx, ImU32_col) C.ImGui_ImDrawList_PathFillConvex(ImDrawList_ctx, ImU32_col) end
function M.ImDrawList_PathStroke(ImDrawList_ctx, ImU32_col, bool_closed, float_thickness)
  if float_thickness == nil then float_thickness = 1 end
  C.ImGui_ImDrawList_PathStroke(ImDrawList_ctx, ImU32_col, bool_closed, float_thickness)
end
function M.ImDrawList_PathArcTo(ImDrawList_ctx, ImVec2_center, float_radius, float_a_min, float_a_max, int_num_segments)
  if int_num_segments == nil then int_num_segments = 10 end
  C.ImGui_ImDrawList_PathArcTo(ImDrawList_ctx, ImVec2_center, float_radius, float_a_min, float_a_max, int_num_segments)
end
function M.ImDrawList_PathArcToFast(ImDrawList_ctx, ImVec2_center, float_radius, int_a_min_of_12, int_a_max_of_12) C.ImGui_ImDrawList_PathArcToFast(ImDrawList_ctx, ImVec2_center, float_radius, int_a_min_of_12, int_a_max_of_12) end
function M.ImDrawList_PathBezierCubicCurveTo(ImDrawList_ctx, ImVec2_p2, ImVec2_p3, ImVec2_p4, int_num_segments)
  if int_num_segments == nil then int_num_segments = 0 end
  C.ImGui_ImDrawList_PathBezierCubicCurveTo(ImDrawList_ctx, ImVec2_p2, ImVec2_p3, ImVec2_p4, int_num_segments)
end
function M.ImDrawList_PathBezierQuadraticCurveTo(ImDrawList_ctx, ImVec2_p2, ImVec2_p3, int_num_segments)
  if int_num_segments == nil then int_num_segments = 0 end
  C.ImGui_ImDrawList_PathBezierQuadraticCurveTo(ImDrawList_ctx, ImVec2_p2, ImVec2_p3, int_num_segments)
end
function M.ImDrawList_PathRect(ImDrawList_ctx, ImVec2_rect_min, ImVec2_rect_max, float_rounding, ImDrawCornerFlags_rounding_corners)
  if float_rounding == nil then float_rounding = 0 end
  if ImDrawCornerFlags_rounding_corners == nil then ImDrawCornerFlags_rounding_corners = M.ImDrawCornerFlags_All end
  C.ImGui_ImDrawList_PathRect(ImDrawList_ctx, ImVec2_rect_min, ImVec2_rect_max, float_rounding, ImDrawCornerFlags_rounding_corners)
end
function M.ImDrawList_AddCallback(ImDrawList_ctx, ImDrawCallback_callback, void_callback_data)
  if void_callback_data == nil then  return end
  C.ImGui_ImDrawList_AddCallback(ImDrawList_ctx, ImDrawCallback_callback, void_callback_data)
end
function M.ImDrawList_AddDrawCmd(ImDrawList_ctx) C.ImGui_ImDrawList_AddDrawCmd(ImDrawList_ctx) end
function M.ImDrawList_CloneOutput(ImDrawList_ctx) return C.ImGui_ImDrawList_CloneOutput(ImDrawList_ctx) end
function M.ImDrawList_ChannelsSplit(ImDrawList_ctx, int_count) C.ImGui_ImDrawList_ChannelsSplit(ImDrawList_ctx, int_count) end
function M.ImDrawList_ChannelsMerge(ImDrawList_ctx) C.ImGui_ImDrawList_ChannelsMerge(ImDrawList_ctx) end
function M.ImDrawList_ChannelsSetCurrent(ImDrawList_ctx, int_n) C.ImGui_ImDrawList_ChannelsSetCurrent(ImDrawList_ctx, int_n) end
function M.ImDrawList_PrimReserve(ImDrawList_ctx, int_idx_count, int_vtx_count) C.ImGui_ImDrawList_PrimReserve(ImDrawList_ctx, int_idx_count, int_vtx_count) end
function M.ImDrawList_PrimUnreserve(ImDrawList_ctx, int_idx_count, int_vtx_count) C.ImGui_ImDrawList_PrimUnreserve(ImDrawList_ctx, int_idx_count, int_vtx_count) end
function M.ImDrawList_PrimRect(ImDrawList_ctx, ImVec2_a, ImVec2_b, ImU32_col) C.ImGui_ImDrawList_PrimRect(ImDrawList_ctx, ImVec2_a, ImVec2_b, ImU32_col) end
function M.ImDrawList_PrimRectUV(ImDrawList_ctx, ImVec2_a, ImVec2_b, ImVec2_uv_a, ImVec2_uv_b, ImU32_col) C.ImGui_ImDrawList_PrimRectUV(ImDrawList_ctx, ImVec2_a, ImVec2_b, ImVec2_uv_a, ImVec2_uv_b, ImU32_col) end
function M.ImDrawList_PrimQuadUV(ImDrawList_ctx, ImVec2_a, ImVec2_b, ImVec2_c, ImVec2_d, ImVec2_uv_a, ImVec2_uv_b, ImVec2_uv_c, ImVec2_uv_d, ImU32_col) C.ImGui_ImDrawList_PrimQuadUV(ImDrawList_ctx, ImVec2_a, ImVec2_b, ImVec2_c, ImVec2_d, ImVec2_uv_a, ImVec2_uv_b, ImVec2_uv_c, ImVec2_uv_d, ImU32_col) end
function M.ImDrawList_PrimWriteVtx(ImDrawList_ctx, ImVec2_pos, ImVec2_uv, ImU32_col) C.ImGui_ImDrawList_PrimWriteVtx(ImDrawList_ctx, ImVec2_pos, ImVec2_uv, ImU32_col) end
function M.ImDrawList_PrimWriteIdx(ImDrawList_ctx, ImDrawIdx_idx) C.ImGui_ImDrawList_PrimWriteIdx(ImDrawList_ctx, ImDrawIdx_idx) end
function M.ImDrawList_PrimVtx(ImDrawList_ctx, ImVec2_pos, ImVec2_uv, ImU32_col) C.ImGui_ImDrawList_PrimVtx(ImDrawList_ctx, ImVec2_pos, ImVec2_uv, ImU32_col) end
function M.ImDrawList__ResetForNewFrame(ImDrawList_ctx) C.ImGui_ImDrawList__ResetForNewFrame(ImDrawList_ctx) end
function M.ImDrawList__ClearFreeMemory(ImDrawList_ctx) C.ImGui_ImDrawList__ClearFreeMemory(ImDrawList_ctx) end
function M.ImDrawList__PopUnusedDrawCmd(ImDrawList_ctx) C.ImGui_ImDrawList__PopUnusedDrawCmd(ImDrawList_ctx) end
function M.ImDrawList__OnChangedClipRect(ImDrawList_ctx) C.ImGui_ImDrawList__OnChangedClipRect(ImDrawList_ctx) end
function M.ImDrawList__OnChangedTextureID(ImDrawList_ctx) C.ImGui_ImDrawList__OnChangedTextureID(ImDrawList_ctx) end
function M.ImDrawList__OnChangedVtxOffset(ImDrawList_ctx) C.ImGui_ImDrawList__OnChangedVtxOffset(ImDrawList_ctx) end
--===
--=== struct ImDrawData ===
function M.ImDrawData() return ffi.new("ImDrawData") end
function M.ImDrawDataPtr() return ffi.new("ImDrawData[1]") end
function M.ImDrawData_Clear(ImDrawData_ctx) C.ImGui_ImDrawData_Clear(ImDrawData_ctx) end
function M.ImDrawData_DeIndexAllBuffers(ImDrawData_ctx) C.ImGui_ImDrawData_DeIndexAllBuffers(ImDrawData_ctx) end
function M.ImDrawData_ScaleClipRects(ImDrawData_ctx, ImVec2_fb_scale) C.ImGui_ImDrawData_ScaleClipRects(ImDrawData_ctx, ImVec2_fb_scale) end
--===
--=== struct ImFontConfig ===
function M.ImFontConfig() return ffi.new("ImFontConfig") end
function M.ImFontConfigPtr() return ffi.new("ImFontConfig[1]") end
--===
--=== struct ImFontGlyph ===
--===
--=== struct ImFontGlyphRangesBuilder ===
function M.ImFontGlyphRangesBuilder() return ffi.new("ImFontGlyphRangesBuilder") end
function M.ImFontGlyphRangesBuilderPtr() return ffi.new("ImFontGlyphRangesBuilder[1]") end
function M.ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder_ctx) C.ImGui_ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder_ctx) end
function M.ImFontGlyphRangesBuilder_GetBit(ImFontGlyphRangesBuilder_ctx, size_t_n) return C.ImGui_ImFontGlyphRangesBuilder_GetBit(ImFontGlyphRangesBuilder_ctx, size_t_n) end
function M.ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder_ctx, size_t_n) C.ImGui_ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder_ctx, size_t_n) end
function M.ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder_ctx, ImWchar_c) C.ImGui_ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder_ctx, ImWchar_c) end
function M.ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder_ctx, string_text, string_text_end)
  -- string_text_end is optional and can be nil
  if string_text == nil then  return end
  C.ImGui_ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder_ctx, string_text, string_text_end)
end
function M.ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder_ctx, ImWchar_ranges)
  if ImWchar_ranges == nil then  return end
  C.ImGui_ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder_ctx, ImWchar_ranges)
end
--===
--=== struct ImFontAtlasCustomRect ===
function M.ImFontAtlasCustomRect() return ffi.new("ImFontAtlasCustomRect") end
function M.ImFontAtlasCustomRectPtr() return ffi.new("ImFontAtlasCustomRect[1]") end
function M.ImFontAtlasCustomRect_IsPacked(ImFontAtlasCustomRect_ctx) return C.ImGui_ImFontAtlasCustomRect_IsPacked(ImFontAtlasCustomRect_ctx) end
--===
--=== enum ImFontAtlasFlags_ ===
M.ImFontAtlasFlags_None = C.ImFontAtlasFlags_None
M.ImFontAtlasFlags_NoPowerOfTwoHeight = C.ImFontAtlasFlags_NoPowerOfTwoHeight
M.ImFontAtlasFlags_NoMouseCursors = C.ImFontAtlasFlags_NoMouseCursors
M.ImFontAtlasFlags_NoBakedLines = C.ImFontAtlasFlags_NoBakedLines
--===
--=== struct ImFontAtlas ===
function M.ImFontAtlas() return ffi.new("ImFontAtlas") end
function M.ImFontAtlasPtr() return ffi.new("ImFontAtlas[1]") end
function M.ImFontAtlas_AddFont(ImFontAtlas_ctx, ImFontConfig_font_cfg)
  if ImFontConfig_font_cfg == nil then  return end
  return C.ImGui_ImFontAtlas_AddFont(ImFontAtlas_ctx, ImFontConfig_font_cfg)
end
function M.ImFontAtlas_AddFontDefault(ImFontAtlas_ctx, ImFontConfig_font_cfg)
  -- ImFontConfig_font_cfg is optional and can be nil
  return C.ImGui_ImFontAtlas_AddFontDefault(ImFontAtlas_ctx, ImFontConfig_font_cfg)
end
function M.ImFontAtlas_AddFontFromFileTTF(ImFontAtlas_ctx, string_filename, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
  -- ImFontConfig_font_cfg is optional and can be nil
  -- ImWchar_glyph_ranges is optional and can be nil
  if string_filename == nil then  return end
  return C.ImGui_ImFontAtlas_AddFontFromFileTTF(ImFontAtlas_ctx, string_filename, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
end
function M.ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas_ctx, void_font_data, int_font_size, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
  -- ImFontConfig_font_cfg is optional and can be nil
  -- ImWchar_glyph_ranges is optional and can be nil
  if void_font_data == nil then  return end
  return C.ImGui_ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas_ctx, void_font_data, int_font_size, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
end
function M.ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas_ctx, void_compressed_font_data, int_compressed_font_size, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
  -- ImFontConfig_font_cfg is optional and can be nil
  -- ImWchar_glyph_ranges is optional and can be nil
  if void_compressed_font_data == nil then  return end
  return C.ImGui_ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas_ctx, void_compressed_font_data, int_compressed_font_size, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
end
function M.ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas_ctx, string_compressed_font_data_base85, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
  -- ImFontConfig_font_cfg is optional and can be nil
  -- ImWchar_glyph_ranges is optional and can be nil
  if string_compressed_font_data_base85 == nil then  return end
  return C.ImGui_ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas_ctx, string_compressed_font_data_base85, float_size_pixels, ImFontConfig_font_cfg, ImWchar_glyph_ranges)
end
function M.ImFontAtlas_ClearInputData(ImFontAtlas_ctx) C.ImGui_ImFontAtlas_ClearInputData(ImFontAtlas_ctx) end
function M.ImFontAtlas_ClearTexData(ImFontAtlas_ctx) C.ImGui_ImFontAtlas_ClearTexData(ImFontAtlas_ctx) end
function M.ImFontAtlas_ClearFonts(ImFontAtlas_ctx) C.ImGui_ImFontAtlas_ClearFonts(ImFontAtlas_ctx) end
function M.ImFontAtlas_Clear(ImFontAtlas_ctx) C.ImGui_ImFontAtlas_Clear(ImFontAtlas_ctx) end
function M.ImFontAtlas_Build(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_Build(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas_ctx, string_out_pixels, int_out_width, int_out_height, int_out_bytes_per_pixel)
  -- int_out_bytes_per_pixel is optional and can be nil
  if string_out_pixels == nil then  return end
  if int_out_width == nil then  return end
  if int_out_height == nil then  return end
  C.ImGui_ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas_ctx, string_out_pixels, int_out_width, int_out_height, int_out_bytes_per_pixel)
end
function M.ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas_ctx, string_out_pixels, int_out_width, int_out_height, int_out_bytes_per_pixel)
  -- int_out_bytes_per_pixel is optional and can be nil
  if string_out_pixels == nil then  return end
  if int_out_width == nil then  return end
  if int_out_height == nil then  return end
  C.ImGui_ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas_ctx, string_out_pixels, int_out_width, int_out_height, int_out_bytes_per_pixel)
end
function M.ImFontAtlas_IsBuilt(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_IsBuilt(ImFontAtlas_ctx) end
function M.ImFontAtlas_SetTexID(ImFontAtlas_ctx, ImTextureID_id) C.ImGui_ImFontAtlas_SetTexID(ImFontAtlas_ctx, ImTextureID_id) end
function M.ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetGlyphRangesThai(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesThai(ImFontAtlas_ctx) end
function M.ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas_ctx) return C.ImGui_ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas_ctx) end
function M.ImFontAtlas_AddCustomRectRegular(ImFontAtlas_ctx, int_width, int_height) return C.ImGui_ImFontAtlas_AddCustomRectRegular(ImFontAtlas_ctx, int_width, int_height) end
function M.ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas_ctx, ImFont_font, ImWchar_id, int_width, int_height, float_advance_x, ImVec2_offset)
  if ImVec2_offset == nil then ImVec2_offset = M.ImVec2(0,0) end
  if ImFont_font == nil then  return end
  return C.ImGui_ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas_ctx, ImFont_font, ImWchar_id, int_width, int_height, float_advance_x, ImVec2_offset)
end
function M.ImFontAtlas_GetCustomRectByIndex(ImFontAtlas_ctx, int_index) return C.ImGui_ImFontAtlas_GetCustomRectByIndex(ImFontAtlas_ctx, int_index) end
function M.ImFontAtlas_CalcCustomRectUV(ImFontAtlas_ctx, ImFontAtlasCustomRect_rect, ImVec2_out_uv_min, ImVec2_out_uv_max)
  if ImFontAtlasCustomRect_rect == nil then  return end
  if ImVec2_out_uv_min == nil then  return end
  if ImVec2_out_uv_max == nil then  return end
  C.ImGui_ImFontAtlas_CalcCustomRectUV(ImFontAtlas_ctx, ImFontAtlasCustomRect_rect, ImVec2_out_uv_min, ImVec2_out_uv_max)
end
function M.ImFontAtlas_GetMouseCursorTexData(ImFontAtlas_ctx, ImGuiMouseCursor_cursor, ImVec2_out_offset, ImVec2_out_size, ImVec2Ptr_out_uv_border, ImVec2Ptr_out_uv_fill)
  if ImVec2_out_offset == nil then  return end
  if ImVec2_out_size == nil then  return end
  return C.ImGui_ImFontAtlas_GetMouseCursorTexData(ImFontAtlas_ctx, ImGuiMouseCursor_cursor, ImVec2_out_offset, ImVec2_out_size, ImVec2Ptr_out_uv_border, ImVec2Ptr_out_uv_fill)
end
--===
--=== struct ImFont ===
function M.ImFont() return ffi.new("ImFont") end
function M.ImFontPtr() return ffi.new("ImFont[1]") end
function M.ImFont_FindGlyph(ImFont_ctx, ImWchar_c) return C.ImGui_ImFont_FindGlyph(ImFont_ctx, ImWchar_c) end
function M.ImFont_FindGlyphNoFallback(ImFont_ctx, ImWchar_c) return C.ImGui_ImFont_FindGlyphNoFallback(ImFont_ctx, ImWchar_c) end
function M.ImFont_GetCharAdvance(ImFont_ctx, ImWchar_c) return C.ImGui_ImFont_GetCharAdvance(ImFont_ctx, ImWchar_c) end
function M.ImFont_IsLoaded(ImFont_ctx) return C.ImGui_ImFont_IsLoaded(ImFont_ctx) end
function M.ImFont_GetDebugName(ImFont_ctx) return C.ImGui_ImFont_GetDebugName(ImFont_ctx) end
function M.ImFont_CalcTextSizeA(ImFont_ctx, float_size, float_max_width, float_wrap_width, string_text_begin, string_text_end, string_remaining)
  -- string_text_end is optional and can be nil
  -- string_remaining is optional and can be nil
  if string_text_begin == nil then  return end
  return C.ImGui_ImFont_CalcTextSizeA(ImFont_ctx, float_size, float_max_width, float_wrap_width, string_text_begin, string_text_end, string_remaining)
end
function M.ImFont_CalcWordWrapPositionA(ImFont_ctx, float_scale, string_text, string_text_end, float_wrap_width)
  if string_text == nil then  return end
  if string_text_end == nil then  return end
  return C.ImGui_ImFont_CalcWordWrapPositionA(ImFont_ctx, float_scale, string_text, string_text_end, float_wrap_width)
end
function M.ImFont_RenderChar(ImFont_ctx, ImDrawList_draw_list, float_size, ImVec2_pos, ImU32_col, ImWchar_c)
  if ImDrawList_draw_list == nil then  return end
  C.ImGui_ImFont_RenderChar(ImFont_ctx, ImDrawList_draw_list, float_size, ImVec2_pos, ImU32_col, ImWchar_c)
end
function M.ImFont_RenderText(ImFont_ctx, ImDrawList_draw_list, float_size, ImVec2_pos, ImU32_col, ImVec4_clip_rect, string_text_begin, string_text_end, float_wrap_width, bool_cpu_fine_clip)
  if float_wrap_width == nil then float_wrap_width = 0 end
  if bool_cpu_fine_clip == nil then bool_cpu_fine_clip = false end
  if ImDrawList_draw_list == nil then  return end
  if string_text_begin == nil then  return end
  if string_text_end == nil then  return end
  C.ImGui_ImFont_RenderText(ImFont_ctx, ImDrawList_draw_list, float_size, ImVec2_pos, ImU32_col, ImVec4_clip_rect, string_text_begin, string_text_end, float_wrap_width, bool_cpu_fine_clip)
end
function M.ImFont_BuildLookupTable(ImFont_ctx) C.ImGui_ImFont_BuildLookupTable(ImFont_ctx) end
function M.ImFont_ClearOutputData(ImFont_ctx) C.ImGui_ImFont_ClearOutputData(ImFont_ctx) end
function M.ImFont_GrowIndex(ImFont_ctx, int_new_size) C.ImGui_ImFont_GrowIndex(ImFont_ctx, int_new_size) end
function M.ImFont_AddGlyph(ImFont_ctx, ImFontConfig_src_cfg, ImWchar_c, float_x0, float_y0, float_x1, float_y1, float_u0, float_v0, float_u1, float_v1, float_advance_x)
  if ImFontConfig_src_cfg == nil then  return end
  C.ImGui_ImFont_AddGlyph(ImFont_ctx, ImFontConfig_src_cfg, ImWchar_c, float_x0, float_y0, float_x1, float_y1, float_u0, float_v0, float_u1, float_v1, float_advance_x)
end
function M.ImFont_AddRemapChar(ImFont_ctx, ImWchar_dst, ImWchar_src, bool_overwrite_dst)
  if bool_overwrite_dst == nil then bool_overwrite_dst = true end
  C.ImGui_ImFont_AddRemapChar(ImFont_ctx, ImWchar_dst, ImWchar_src, bool_overwrite_dst)
end
function M.ImFont_SetGlyphVisible(ImFont_ctx, ImWchar_c, bool_visible) C.ImGui_ImFont_SetGlyphVisible(ImFont_ctx, ImWchar_c, bool_visible) end
function M.ImFont_SetFallbackChar(ImFont_ctx, ImWchar_c) C.ImGui_ImFont_SetFallbackChar(ImFont_ctx, ImWchar_c) end
function M.ImFont_IsGlyphRangeUnused(ImFont_ctx, int_c_begin, int_c_last) return C.ImGui_ImFont_IsGlyphRangeUnused(ImFont_ctx, int_c_begin, int_c_last) end
--===
--=== struct ImGuiPlatformIO ===
function M.ImGuiPlatformIO() return ffi.new("ImGuiPlatformIO") end
function M.ImGuiPlatformIOPtr() return ffi.new("ImGuiPlatformIO[1]") end
--===
--=== struct ImGuiPlatformMonitor ===
function M.ImGuiPlatformMonitor() return ffi.new("ImGuiPlatformMonitor") end
function M.ImGuiPlatformMonitorPtr() return ffi.new("ImGuiPlatformMonitor[1]") end
--===
--=== enum ImGuiViewportFlags_ ===
M.ViewportFlags_None = C.ImGuiViewportFlags_None
M.ViewportFlags_NoDecoration = C.ImGuiViewportFlags_NoDecoration
M.ViewportFlags_NoTaskBarIcon = C.ImGuiViewportFlags_NoTaskBarIcon
M.ViewportFlags_NoFocusOnAppearing = C.ImGuiViewportFlags_NoFocusOnAppearing
M.ViewportFlags_NoFocusOnClick = C.ImGuiViewportFlags_NoFocusOnClick
M.ViewportFlags_NoInputs = C.ImGuiViewportFlags_NoInputs
M.ViewportFlags_NoRendererClear = C.ImGuiViewportFlags_NoRendererClear
M.ViewportFlags_TopMost = C.ImGuiViewportFlags_TopMost
M.ViewportFlags_Minimized = C.ImGuiViewportFlags_Minimized
M.ViewportFlags_NoAutoMerge = C.ImGuiViewportFlags_NoAutoMerge
M.ViewportFlags_CanHostOtherWindows = C.ImGuiViewportFlags_CanHostOtherWindows
--===
--=== struct ImGuiViewport ===
function M.ImGuiViewport() return ffi.new("ImGuiViewport") end
function M.ImGuiViewportPtr() return ffi.new("ImGuiViewport[1]") end
function M.ImGuiViewport_GetCenter(ImGuiViewport_ctx) return C.ImGui_ImGuiViewport_GetCenter(ImGuiViewport_ctx) end
function M.ImGuiViewport_GetWorkPos(ImGuiViewport_ctx) return C.ImGui_ImGuiViewport_GetWorkPos(ImGuiViewport_ctx) end
function M.ImGuiViewport_GetWorkSize(ImGuiViewport_ctx) return C.ImGui_ImGuiViewport_GetWorkSize(ImGuiViewport_ctx) end
--===

end -- global function close
