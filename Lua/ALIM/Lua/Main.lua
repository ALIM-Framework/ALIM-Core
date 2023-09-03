local showMenu = false

function onRender()
    if not showMenu then return end

    if imgui.Begin("Window") then
        imgui.Text("Some text")
        imgui.End()
    end
end

function onKeyEvent(key, down)
    if key == 0x70 and down then
        showMenu = not showMenu
        ALIM_EnableCursor(showMenu)
    end

    -- print((down and "Pressed" or "Released") .. ": " .. tostring(key))
end