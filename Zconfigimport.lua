-- Zconfigimport.lua —— 公共逻辑：键位绑定 + 按职业加载宏/技能摆放
-- 用法: 
--   /mkb        - 执行全部（键位 + 宏创建 + 放置）
--   /mkb bind   - 仅执行键位导入
--   /mkb macro  - 仅创建当前职业的宏
--   /mkb place  - 仅放置当前职业的宏与技能

local ADDON_PREFIX = "|cff33ff99MyKeybinds|r"
local ACTION_BUTTONS_PER_PAGE = 12

-- 兼容层：部分客户端（如 1.12 系列）没有全局 print，这里做个兜底
local print = (type(print) == "function") and print or function(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(msg)
    end
end

--------------------------------------------------------------------------
-- 键位绑定数据
--------------------------------------------------------------------------

local RAW_BINDINGS = [[
bind BUTTON3 TOGGLEAUTORUN
bind NUMPAD0 RAIDTARGET8
bind X ACTIONBUTTON11
bind Z ACTIONBUTTON12
bind BUTTON4 NONE
bind R ACTIONBUTTON8
bind 0 NONE
bind - NONE
bind SHIFT-1 NONE
bind SHIFT-2 NONE
bind SHIFT-3 NONE
bind SHIFT-4 NONE
bind SHIFT-5 NONE
bind SHIFT-6 NONE
bind SHIFT-MOUSEWHEELUP ACTIONPAGE1
bind SHIFT-MOUSEWHEELDOWN ACTIONPAGE2
bind G ACTIONBUTTON10
bind F ACTIONBUTTON7
bind T ACTIONBUTTON9
bind B OPENALLBAGS
bind SHIFT-B NONE
bind F12 TOGGLECHATTAB
bind O ACTIONBUTTON6
bind NUMPADPLUS RAIDTARGETNONE
bind CTRL-R REPLY
bind NUMPAD5 RAIDTARGET3
bind NUMPAD1 RAIDTARGET7
bind NUMPAD3 RAIDTARGET5
bind NUMPAD2 RAIDTARGET6
bind NUMPAD4 RAIDTARGET4
bind NUMPAD6 RAIDTARGET2
bind NUMPAD7 RAIDTARGET1
bind NUMPAD8 NONE
bind BUTTON5 CLICK BT4Button60:Keybind
]]

--------------------------------------------------------------------------
-- 工具函数
--------------------------------------------------------------------------

local function GetActionSlot(row, col)
    return (row - 1) * ACTION_BUTTONS_PER_PAGE + col
end

local function ParseBindingLine(line)
    local key, command = line:match("^bind%s+(%S+)%s+(.+)$")
    if not key then
        return nil
    end
    if command == "NONE" then
        command = nil
    end
    return key, command
end

--------------------------------------------------------------------------
-- 1. 键位绑定模块
--------------------------------------------------------------------------

local function ApplyBindings()
    local okCount, failCount, pluginDependentCount = 0, 0, 0
    local failedList = {}

    for line in RAW_BINDINGS:gmatch("[^\r\n]+") do
        local key, command = ParseBindingLine(line)
        if key then
            local isClickBinding = command and command:match("^CLICK ") ~= nil
            local success = SetBinding(key, command)

            if success then
                okCount = okCount + 1
            else
                failCount = failCount + 1
                failedList[#failedList + 1] = key .. " -> " .. tostring(command)
                if isClickBinding then
                    pluginDependentCount = pluginDependentCount + 1
                end
            end
        end
    end

    SaveBindings(1)

    print(string.format("%s 键位导入完成：成功 %d 条，失败 %d 条", ADDON_PREFIX, okCount, failCount))

    if failCount > 0 then
        print("|cffff5555失败明细：|r")
        for _, line in ipairs(failedList) do
            print("  " .. line)
        end
        if pluginDependentCount > 0 then
            print(string.format(
                "|cffffaa00其中 %d 条是 CLICK 绑定，若失败请确认对应插件按钮是否存在|r",
                pluginDependentCount
            ))
        end
    end
end

--------------------------------------------------------------------------
-- 2. 宏创建模块
--------------------------------------------------------------------------

local function CreateMacroFromEntry(entry)
    local name, icon, body, bIsLocal, bIsPerCharacter =
        entry[1], entry[2], entry[3], entry[4], entry[5]
    return CreateMacro(name, icon, body, bIsLocal, bIsPerCharacter)
end

local function CreateClassMacros(macroTable)
    local okCount, failCount = 0, 0
    for _, entry in ipairs(macroTable) do
        local index = CreateMacroFromEntry(entry)
        if index and index > 0 then
            okCount = okCount + 1
        else
            failCount = failCount + 1
        end
    end
    return okCount, failCount
end

local function ApplyClassMacros()
    local _, classToken = UnitClass("player")
    local macroTable = _G["MACROS_BY_CLASS_" .. classToken]

    if not macroTable then
        print(string.format("%s 没找到职业 %s 对应的宏数据", ADDON_PREFIX, classToken))
        return
    end

    local macroOk, macroFail = CreateClassMacros(macroTable)
    print(string.format("%s [%s] 宏创建完成：成功 %d / 失败 %d", ADDON_PREFIX, classToken, macroOk, macroFail))
end

--------------------------------------------------------------------------
-- 3. 宏与技能放置模块
--------------------------------------------------------------------------

local function PlaceClassMacros(placementTable)
    local okCount, failCount = 0, 0
    if not placementTable then
        return okCount, failCount
    end

    for macroName, place in pairs(placementTable) do
        local index = GetMacroIndexByName(macroName)
        if index and index > 0 then
            PickupMacro(index)
            PlaceAction(GetActionSlot(place[1], place[2]))
            okCount = okCount + 1
        else
            failCount = failCount + 1
        end
    end
    return okCount, failCount
end

local function FindSpellBookIndex(spellName)
    local index = 1
    while true do
        local name = GetSpellName(index, "spell")
        if not name then
            return nil
        end
        if name == spellName then
            return index
        end
        index = index + 1
    end
end

local function PlaceClassSpells(spellTable)
    local okCount, failCount = 0, 0
    if not spellTable then
        return okCount, failCount
    end

    for _, spell in ipairs(spellTable) do
        local spellName, row, col = spell[1], spell[2], spell[3]
        local spellIndex = FindSpellBookIndex(spellName)
        if spellIndex then
            PickupSpell(spellIndex, "spell")
            PlaceAction(GetActionSlot(row, col))
            okCount = okCount + 1
        else
            failCount = failCount + 1
        end
    end
    return okCount, failCount
end

local function ApplyClassPlacement()
    local _, classToken = UnitClass("player")
    local placementTable = _G["MACRO_PLACEMENT_" .. classToken]
    local spellTable = _G["SPELLS_BY_CLASS_" .. classToken]

    if not placementTable and not spellTable then
        print(string.format("%s 没找到职业 %s 对应的摆放数据", ADDON_PREFIX, classToken))
        return
    end

    local placeOk, placeFail = PlaceClassMacros(placementTable)
    local spellOk, spellFail = PlaceClassSpells(spellTable)

    print(string.format(
        "%s [%s] 摆放完成 -> 宏摆放：成功 %d / 失败 %d，技能摆放：成功 %d / 失败 %d",
        ADDON_PREFIX, classToken, placeOk, placeFail, spellOk, spellFail
    ))
end

--------------------------------------------------------------------------
-- 入口与子命令分发
--------------------------------------------------------------------------

SLASH_MYKEYBINDS1 = "/mkb"
SlashCmdList["MYKEYBINDS"] = function(msg)
    msg = string.lower(string.gsub(msg or "", "^%s*(.-)%s*$", "%1"))

    if msg == "bind" then
        ApplyBindings()
    elseif msg == "macro" then
        ApplyClassMacros()
    elseif msg == "place" then
        ApplyClassPlacement()
    else
        ApplyBindings()
        ApplyClassMacros()
        ApplyClassPlacement()
    end
end