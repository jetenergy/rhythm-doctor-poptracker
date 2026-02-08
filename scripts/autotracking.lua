
local slotData = {
    act_1_boss_unlock_requirement = 2,
    act_2_boss_unlock_requirement = 4,
    act_3_boss_unlock_requirement = 3,
    act_4_boss_unlock_requirement = 4,
    act_5_boss_unlock_requirement = 3,
    act_6_boss_unlock_requirement = 2,
    act_7_boss_unlock_requirement = 2,
    boss_unlock_requirement = 0,
    end_goal = 0,
}

-- Level items per chapter
local levelItems = {
    ["1"] = {"1", "2", "3", "4", "5", "6"},
    ["2"] = {"13", "14", "15", "16", "17", "18", "19", "20"},
    ["3"] = {"7", "8", "9", "10", "11", "12"},
    ["4"] = {},
    ["5"] = {},
    ["6"] = {},
    ["7"] = {},
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
        if slotData[key] ~= nil then
            slotData[key] = value
        end
    end
end

---@param chapter string
function CheckBossRequirement(chapter)
    local requirement = slotData["act_" .. chapter .. "_boss_unlock_requirement"]

    local levelsUnlocked = 0
    for _, item in pairs(levelItems[chapter]) do
        local count = Tracker:ProviderCountForCode(item)
        if count == 1 then
            levelsUnlocked = levelsUnlocked + 1
        end

    end

    return levelsUnlocked >= requirement;

end

Archipelago:AddClearHandler("Clear", onClear)
Archipelago:AddItemHandler("Item", onItem)
Archipelago:AddLocationHandler("Location", onLocation)
print("Rhythm-Doctor archipelago setup completed")
