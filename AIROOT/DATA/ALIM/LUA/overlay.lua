local M = {}

local location = 0
local p_open = imgui.BoolPtr(true)

local function onRender(showMenu)
    local io = imgui.GetIO()

    local windowFlags = bit.bor(imgui.WindowFlags_NoDecoration, imgui.WindowFlags_AlwaysAutoResize, imgui.WindowFlags_NoSavedSettings, imgui.WindowFlags_NoFocusOnAppearing, imgui.WindowFlags_NoNav)
    
    if location >= 0 then
        local PAD = 5
        local viewport = imgui.GetMainViewport()
        local work_pos = viewport.WorkPos
        local work_size = viewport.WorkSize
        local windowPos = imgui.ImVec2(0, 0)
        local windowPosPivot = imgui.ImVec2(0, 0)
    
        windowPos.x = (bit.band(location, 1) ~= 0) and (work_pos.x + work_size.x - PAD) or (work_pos.x + PAD)
        windowPos.y = (bit.band(location, 2) ~= 0) and (work_pos.y + work_size.y - PAD) or (work_pos.y + PAD)
        windowPosPivot.x = (bit.band(location, 1) ~= 0) and 1.0 or 0.0
        windowPosPivot.y = (bit.band(location, 2) ~= 0) and 1.0 or 0.0
    
        imgui.SetNextWindowPos(windowPos, imgui.Cond_Always, windowPosPivot)
        windowFlags = bit.bor(windowFlags, imgui.WindowFlags_NoMove)
    elseif location == -2 then
        local vp = imgui.GetMainViewport().WorkSize
        imgui.SetNextWindowPos(imgui.ImVec2(vp.x / 2, vp.y / 2), imgui.Cond_Always, imgui.ImVec2(0.5, 0.5))
        windowFlags = bit.bor(windowFlags, imgui.WindowFlags_NoMove)
    end
    
    imgui.SetNextWindowBgAlpha(0.35)
    imgui.SetNextWindowSize(imgui.ImVec2(0, 0))
    if imgui.Begin("##alim-core_overlay", p_open, windowFlags) then
        imgui.PushStyleColor2(imgui.Col_Text, imgui.ImVec4(0.98, 0.95, 0.65, 1))
        imgui.Text("ALIM-Core 1.0.0")
        imgui.PopStyleColor()

        imgui.Text("Version: 1.0.0")
        imgui.Text("Menu Open: " .. (showMenu and "Yes" or "No"))
        imgui.Separator()
    
        if imgui.IsMousePosValid() then
            imgui.Text("Mouse Position: (%.1f,%.1f)", io.MousePos.x, io.MousePos.y)
        else
            imgui.Text("Mouse Position: <invalid>")
        end
    
        if imgui.BeginPopupContextWindow("##alim-core_overlay_popup") then
            if imgui.MenuItem1("Custom", nil, location == -1) then location = -1 end
            if imgui.MenuItem1("Center", nil, location == -2) then location = -2 end
            if imgui.MenuItem1("Top-left", nil, location == 0) then location = 0 end
            if imgui.MenuItem1("Top-right", nil, location == 1) then location = 1 end
            if imgui.MenuItem1("Bottom-left", nil, location == 2) then location = 2 end
            if imgui.MenuItem1("Bottom-right", nil, location == 3) then location = 3 end
            if p_open and imgui.MenuItem1("Close") then p_open[0] = false end

            imgui.EndPopup()
        end
    end
    
    imgui.End()
end

M.onRender = onRender

return M