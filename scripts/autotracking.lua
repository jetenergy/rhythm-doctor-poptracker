-- TODO: reset all items on AP connect?
-- TODO: make boss's blue when available but levels not scored

-- levels required for act bosses
local levelItems = {
    ["1"] = {"1", "2", "3", "4", "5", "6"},
    ["2"] = {"13", "14", "15", "16", "17", "18", "19", "20", "21"},
    ["3"] = {"7", "8", "9", "10", "11", "12"},
    ["4"] = {"23", "24", "25", "26", "27", "28", "29", "30"},
    ["5"] = {"31", "32", "33", "34", "35", "36"},
    ["6"] = {"38", "39"},
    ["7"] = {"22", "40"},
}

local reqKeyItemMap = {
    act_1_boss_unlock_requirement = "act1req",
    act_2_boss_unlock_requirement = "act2req",
    act_3_boss_unlock_requirement = "act3req",
    act_4_boss_unlock_requirement = "act4req",
    act_5_boss_unlock_requirement = "act5req",
    act_6_boss_unlock_requirement = "act6req",
    act_7_boss_unlock_requirement = "act7req",
}

function string.trim(str)
    return str:match("^%s*(.-)%s*$")

end

---@param index integer
---@param itemID integer
---@param itemName string
local onItem = function(index, itemID, itemName)
    print("RD: received item: id:" .. itemID .. "; name:" .. itemName)

    local item = Tracker:FindObjectForCode(tostring(itemID))
    ---@cast item JsonItem
    if item ~= nil then
        item.Active = true
    end

end

local onLocation = function(locationId, locationName)
    print("RD: Location received: " .. locationName)

    local location, rank = locationName:match("^(.*)%-(.-)$")
    local levelRank = Tracker:FindObjectForCode("@" .. location:trim() .. "/" .. rank:trim())
    ---@cast levelRank LocationSection
    if levelRank ~= nil then
        levelRank.AvailableChestCount = 0
    end

end

---@param data { [string]: any }
local onClear = function(data)
    for key, value in pairs(data) do
        print("RD: slot data: key: " .. key .. "; value: " .. tostring(value))

        if key == "end_goal" then
            local goalSelector = Tracker:FindObjectForCode("end_goal")
            --@cast goalSelector LocationSection
            if goalSelector ~= nil then
                -- 0 = Helping Hands, 1 = All B Rank, 2 = All A Rank, 3 = All S Rank
                goalSelector.CurrentStage = value
            end

        end

        if reqKeyItemMap[key] ~= nil then
            local reqObject = Tracker:FindObjectForCode(reqKeyItemMap[key])
            --@cast reqObject LocationSection
            if reqObject ~= nil then
                reqObject.AcquiredCount = value
            end
        end

        if key == "perfect_rank_locations" then
            local reqObject = Tracker:FindObjectForCode("perfect_rank")
            --@cast reqObject LocationSection
            if reqObject ~= nil then
                reqObject.Active = value == 1
            end
        end
    end

end

---@param chapter string
function CheckBossRequirement(chapter)
    local requirement = Tracker:ProviderCountForCode("act" .. chapter .. "req")

    local levelsUnlocked = 0
    for _, item in pairs(levelItems[chapter]) do
        local count = Tracker:ProviderCountForCode(item)
        if count == 1 then
            levelsUnlocked = levelsUnlocked + 1
        end
    end

    return levelsUnlocked >= requirement;

end

function HasAllBossesUnlocked()
    return CheckBossRequirement("1") and
        CheckBossRequirement("2") and
        CheckBossRequirement("3") and
        CheckBossRequirement("4") and
        CheckBossRequirement("5") and
        CheckBossRequirement("6") and
        CheckBossRequirement("7")
end

Archipelago:AddClearHandler("Clear", onClear)
Archipelago:AddItemHandler("Item", onItem)
Archipelago:AddLocationHandler("Location", onLocation)
print("Rhythm-Doctor archipelago setup completed")
