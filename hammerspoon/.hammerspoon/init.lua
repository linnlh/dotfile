hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0.1

-- ModalMgr Spoon must be loaded explicitly
hs.loadSpoon("ModalMgr")

-- Define default Spoons which will be loaded later
if not hspoon_list then
    hspoon_list = {
        "WinWin",
    }
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

----------------------------------------------------------------------------------------------------
-- Register lock screen
lock_keys = lock_keys or {"alt", "L"}
spoon.ModalMgr.supervisor:bind(lock_keys[1], lock_keys[2], "Lock Screen", function()
    hs.caffeinate.lockScreen()
end)

----------------------------------------------------------------------------------------------------
-- Register App Management Environment
spoon.ModalMgr:new("app_mgr")
local cmodal = spoon.ModalMgr.modal_list["app_mgr"]
cmodal:bind('', 'escape', 'Deactivate App Managemenet Environment', function() spoon.ModalMgr:deactivate({"app_mgr"}) end)
cmodal:bind('', 'Q', 'Deactivate App Managemenet Environment', function() spoon.ModalMgr:deactivate({"app_mgr"}) end)
cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)

app_list = app_list or {
    {key = 'f', name = 'Finder'},
    {key = 's', name = 'Safari'},
    {key = 't', name = 'Terminal'},
    {key = 'c', name = 'Visual Studio Code'},
    {key = 'y', id = 'com.apple.systempreferences'},
}

for _, v in ipairs(app_list) do
    if v.id then
        local located_name = hs.application.nameForBundleID(v.id)
        if located_name then
            cmodal:bind('', v.key, located_name, function()
                hs.application.launchOrFocusByBundleID(v.id)
                spoon.ModalMgr:deactivate({"app_mgr"})
            end)
        end
    elseif v.name then
        cmodal:bind('', v.key, v.name, function()
            hs.application.launchOrFocus(v.name)
            spoon.ModalMgr:deactivate({"app_mgr"})
        end)
    end
end

app_mgr_keys = app_mgr_keys or {"alt", "A"}
spoon.ModalMgr.supervisor:bind(app_mgr_keys[1], app_mgr_keys[2], "Enter App Management Environment", function()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({"app_mgr"}, "#FFBD2E", true)
end)

----------------------------------------------------------------------------------------------------
-- Register Windows Management
if spoon.WinWin then
    spoon.ModalMgr:new("windows_mgr")
    local cmodal = spoon.ModalMgr.modal_list["windows_mgr"]
    cmodal:bind('', 'escape', 'Deactivate', function() spoon.ModalMgr:deactivate({"windows_mgr"}) end)
    cmodal:bind('', 'Q', 'Deactivate', function() spoon.ModalMgr:deactivate({"windows_mgr"}) end)
    cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
    cmodal:bind('', 'A', 'Move Leftward', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
    cmodal:bind('', 'D', 'Move Rightward', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
    cmodal:bind('', 'W', 'Move Upward', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
    cmodal:bind('', 'S', 'Move Downward', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)
    cmodal:bind('', 'H', 'Lefthalf of Screen', function() spoon.WinWin:moveAndResize("halfleft") end)
    cmodal:bind('', 'L', 'Righthalf of Screen', function() spoon.WinWin:moveAndResize("halfright") end)
    cmodal:bind('', 'K', 'Uphalf of Screen', function() spoon.WinWin:moveAndResize("halfup") end)
    cmodal:bind('', 'J', 'Downhalf of Screen', function() spoon.WinWin:moveAndResize("halfdown") end)
    cmodal:bind('', 'Y', 'NorthWest Corner', function() spoon.WinWin:moveAndResize("cornerNW") end)
    cmodal:bind('', 'O', 'NorthEast Corner', function() spoon.WinWin:moveAndResize("cornerNE") end)
    cmodal:bind('', 'U', 'SouthWest Corner', function() spoon.WinWin:moveAndResize("cornerSW") end)
    cmodal:bind('', 'I', 'SouthEast Corner', function() spoon.WinWin:moveAndResize("cornerSE") end)
    cmodal:bind('', 'F', 'Fullscreen', function() spoon.WinWin:moveAndResize("fullscreen") end)
    cmodal:bind('', 'C', 'Center Window', function() spoon.WinWin:moveAndResize("center") end)
    cmodal:bind('', '=', 'Stretch Outward', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
    cmodal:bind('', '-', 'Shrink Inward', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)
    cmodal:bind('shift', 'H', 'Move Leftward', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
    cmodal:bind('shift', 'L', 'Move Rightward', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
    cmodal:bind('shift', 'K', 'Move Upward', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
    cmodal:bind('shift', 'J', 'Move Downward', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)
    cmodal:bind('', 'left', 'Move to Left Monitor', function() spoon.WinWin:moveToScreen("left") end)
    cmodal:bind('', 'right', 'Move to Right Monitor', function() spoon.WinWin:moveToScreen("right") end)
    cmodal:bind('', 'up', 'Move to Above Monitor', function() spoon.WinWin:moveToScreen("up") end)
    cmodal:bind('', 'down', 'Move to Below Monitor', function() spoon.WinWin:moveToScreen("down") end)
    cmodal:bind('', 'space', 'Move to Next Monitor', function() spoon.WinWin:moveToScreen("next") end)
    cmodal:bind('', '[', 'Undo Window Manipulation', function() spoon.WinWin:undo() end)
    cmodal:bind('', ']', 'Redo Window Manipulation', function() spoon.WinWin:redo() end)
    cmodal:bind('', '`', 'Center Cursor', function() spoon.WinWin:centerCursor() end)

    windows_mgr_keys = windows_mgr_keys or {"alt", "R"}
    spoon.ModalMgr.supervisor:bind(windows_mgr_keys[1], windows_mgr_keys[2], "Enter Windows Management Environment", function()
        spoon.ModalMgr:deactivateAll()
        spoon.ModalMgr:activate({"windows_mgr"}, "#B22222")
    end)
end

----------------------------------------------------------------------------------------------------
-- Start!!!
spoon.ModalMgr.supervisor:enter()