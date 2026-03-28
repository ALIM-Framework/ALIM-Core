package.path = package.path .. ";./DATA/ALIM/LUA/?.lua"

require("util")
local overlay = require("overlay")
local soundMenu = require("soundMenu")
local ui = require("ui")

local showMenu = false
local showDebugMenu = imgui.BoolPtr(false)

function onInitialize()
    alim:info("Lua Instance Loaded")
    ui.onInitialize()
end

function onRender()
    overlay.onRender(showMenu)

    if not showMenu then return end

    if imgui.BeginMainMenuBar() then
        if imgui.BeginMenu("AI") then
            imgui.MenuItem1("Exit Game")
            imgui.EndMenu()
        end

        if imgui.BeginMenu("Debug") then
            imgui.Checkbox("Show Audio Menu", showDebugMenu)

            imgui.EndMenu()
        end

        imgui.EndMainMenuBar()
    end

    soundMenu.onRender()
    -- imgui.ShowDemoWindow()
end

function onKeyEvent(key, down)
    if key == 0x70 and down then
        showMenu = not showMenu
        alim:enableCursor(showMenu)
        alim:showDebugMenu(showMenu)
    end
end