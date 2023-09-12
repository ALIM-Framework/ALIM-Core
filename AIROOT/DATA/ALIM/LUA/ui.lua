local M = {}

local function onInitialize()
    local style = imgui.GetStyle()
    style.Colors[imgui.Col_Text]                   = imgui.ImVec4(0.8, 0.8, 0.83, 1.0)
    style.Colors[imgui.Col_TextDisabled]           = imgui.ImVec4(0.24, 0.23, 0.29, 1.0)
    style.Colors[imgui.Col_WindowBg]               = imgui.ImVec4(0.06, 0.05, 0.07, 1.0)
    style.Colors[imgui.Col_ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.09, 1.0)
    style.Colors[imgui.Col_PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.09, 1.0)
    style.Colors[imgui.Col_Border]                 = imgui.ImVec4(0.8, 0.8, 0.83, 0.88)
    style.Colors[imgui.Col_BorderShadow]           = imgui.ImVec4(0.92, 0.91, 0.88, 0.0)
    style.Colors[imgui.Col_FrameBg]                = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_FrameBgHovered]         = imgui.ImVec4(0.24, 0.23, 0.29, 1.0)
    style.Colors[imgui.Col_FrameBgActive]          = imgui.ImVec4(0.56, 0.56, 0.58, 1.0)
    style.Colors[imgui.Col_TitleBg]                = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_TitleBgActive]          = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_TitleBgCollapsed]       = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_MenuBarBg]              = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_ScrollbarBg]            = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_ScrollbarGrab]          = imgui.ImVec4(0.8, 0.8, 0.83, 0.31)
    style.Colors[imgui.Col_ScrollbarGrabHovered]   = imgui.ImVec4(0.56, 0.56, 0.58, 1.0)
    style.Colors[imgui.Col_ScrollbarGrabActive]    = imgui.ImVec4(0.06, 0.05, 0.07, 1.0)
    style.Colors[imgui.Col_CheckMark]              = imgui.ImVec4(0.8, 0.8, 0.83, 0.31)
    style.Colors[imgui.Col_SliderGrab]             = imgui.ImVec4(0.8, 0.8, 0.83, 0.31)
    style.Colors[imgui.Col_SliderGrabActive]       = imgui.ImVec4(0.06, 0.05, 0.07, 1.0)
    style.Colors[imgui.Col_Button]                 = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_ButtonHovered]          = imgui.ImVec4(0.24, 0.23, 0.29, 1.0)
    style.Colors[imgui.Col_ButtonActive]           = imgui.ImVec4(0.56, 0.56, 0.58, 1.0)
    style.Colors[imgui.Col_Header]                 = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_HeaderHovered]          = imgui.ImVec4(0.56, 0.56, 0.58, 1.0)
    style.Colors[imgui.Col_HeaderActive]           = imgui.ImVec4(0.06, 0.05, 0.07, 1.0)
    style.Colors[imgui.Col_Separator]              = imgui.ImVec4(0.8, 0.8, 0.83, 0.31)
    style.Colors[imgui.Col_SeparatorHovered]       = imgui.ImVec4(0.56, 0.56, 0.58, 1.0)
    style.Colors[imgui.Col_SeparatorActive]        = imgui.ImVec4(0.06, 0.05, 0.07, 1.0)
    style.Colors[imgui.Col_ResizeGrip]             = imgui.ImVec4(0.0, 0.0, 0.0, 0.0)
    style.Colors[imgui.Col_ResizeGripHovered]      = imgui.ImVec4(0.56, 0.56, 0.58, 1.0)
    style.Colors[imgui.Col_ResizeGripActive]       = imgui.ImVec4(0.06, 0.05, 0.07, 1.0)
    style.Colors[imgui.Col_Tab]                    = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_TabHovered]             = imgui.ImVec4(0.56, 0.56, 0.58, 1.0)
    style.Colors[imgui.Col_TabActive]              = imgui.ImVec4(0.06, 0.05, 0.07, 1.0)
    style.Colors[imgui.Col_TabUnfocused]           = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_TabUnfocusedActive]     = imgui.ImVec4(0.1, 0.09, 0.12, 1.0)
    style.Colors[imgui.Col_PlotLines]              = imgui.ImVec4(0.4, 0.39, 0.38, 0.63)
    style.Colors[imgui.Col_PlotLinesHovered]       = imgui.ImVec4(0.25, 1.0, 0.0, 1.0)
    style.Colors[imgui.Col_PlotHistogram]          = imgui.ImVec4(0.4, 0.39, 0.38, 0.63)
    style.Colors[imgui.Col_PlotHistogramHovered]   = imgui.ImVec4(0.25, 1.0, 0.0, 1.0)
    style.Colors[imgui.Col_TextSelectedBg]         = imgui.ImVec4(0.25, 1.0, 0.0, 0.43)
    style.Colors[imgui.Col_DragDropTarget]         = imgui.ImVec4(1.0, 1.0, 0.0, 0.9)

    style.WindowPadding        = imgui.ImVec2(8, 8)
    style.WindowRounding       = 0.0
    style.WindowBorderSize     = 0.0
    style.FramePadding         = imgui.ImVec2(5, 5)
    style.FrameRounding        = 0.0
    style.ItemSpacing          = imgui.ImVec2(12, 4)
    style.ItemInnerSpacing     = imgui.ImVec2(8, 6)
    style.IndentSpacing        = 21.0
    style.ScrollbarSize        = 16.0
    style.ScrollbarRounding    = 9.0
    style.GrabMinSize          = 10.0
    style.GrabRounding         = 0.0
    style.TabRounding          = 4.0
    style.ButtonTextAlign      = imgui.ImVec2(0.5, 0.5)
    style.SelectableTextAlign  = imgui.ImVec2(0.0, 0.0)
end

M.onInitialize = onInitialize

return M