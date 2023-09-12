local M = {}

local soundEvents = {
    {
        "Motion Tracker",
        {
            "Play_Motion_Tracker_Blip",
            "Play_MOTIONTRACKER_On",
            "Play_MOTIONTRACKER_Off",
            "Play_Motiontracker_ObjectInRange",
        }
    },
    {
        "Minigame",
        {
            "Play_Success_Minigame",
            "Play_Fail_Minigame",
            "Play_Start_Minigame",
            "Play_Stop_Minigame",
        }
    },
    {
        "User Interface",
        {
            "Play_Tooltip",
            "Pause",
            "Play_Credits",
            "Stop_Credits",
            "Play_Popup_Cancel",
            "Play_Popup_Confirm",
            "Resume_game",
        }
    },
    {
        "Other",
        {
            "KEYPAD_access_granted",
            "Start_Inventory_Wheel",
            "Stop_Inventory_Wheel",
            "stop_ui_interaction_sounds",
            "Play_Popup_Save_Load"   
        }
    }
}

function onRender()
    imgui.PushStyleVar2(imgui.StyleVar_WindowPadding, imgui.ImVec2(0, 0))
    imgui.PushStyleVar2(imgui.StyleVar_ItemSpacing, imgui.ImVec2(0, 0))
    imgui.SetNextWindowSize(imgui.ImVec2(300, 400), imgui.Cond_Once);
    if imgui.Begin("ALIM-Core Audio") then
        for _, group in ipairs(soundEvents) do
            if imgui.CollapsingHeader1(group[1]) then
                imgui.PushStyleVar2(imgui.StyleVar_ItemSpacing, imgui.ImVec2(0, 5))
                for _, soundEvent in ipairs(group[2]) do
                    if imgui.Button(soundEvent, imgui.ImVec2(imgui.GetWindowWidth(), 0)) then
                        alim:triggerSoundEvent(soundEvent, 0)
                    end
                end
                imgui.PopStyleVar(1)
            end
        end
    end
    imgui.End()

    imgui.PopStyleVar(2)
end

M.onRender = onRender

return M