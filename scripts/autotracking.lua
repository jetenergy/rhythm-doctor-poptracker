-- TODO: reset all items on AP connect?

ScriptHost:LoadScript("scripts/itemMaps.lua")

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
            local rankLocObj = Tracker:FindObjectForCode("perfect_rank")
            --@cast rankLocObj LocationSection
            if rankLocObj ~= nil then
                rankLocObj.Active = value == 1
            end
        end

        if key == "boss_unlock_requirement" then
            local bossReqObject = Tracker:FindObjectForCode("boss_requirement")
            --@cast bossReqObject LocationSection
            if bossReqObject ~= nil then
                bossReqObject.CurrentStage = value
            end
        end
    end

end

---@param chapter string
function GetChapterLevelInfo(chapter)
    local requirement = Tracker:ProviderCountForCode("act" .. chapter .. "req")

    local bossReqObj = Tracker:FindObjectForCode("boss_requirement")
    --@cast bossReqObject LocationSection
    local rankBeatRequirement = 0
    if bossReqObj ~= nil then
        rankBeatRequirement = bossReqObj.CurrentStage
    end

    local levelsUnlocked = 0
    local levelsCompleted = 0
    for _, levelCode in pairs(RD_Maps.BossLevels[chapter]) do
        local levelName = RD_Maps.LevelNames[levelCode]
        local rankName = RD_Maps.LevelRanks[rankBeatRequirement]
        if RD_Maps.HasBossLocations[levelCode] then
            rankName = RD_Maps.BossRanks[rankBeatRequirement]
        end

        local levelRankLocation = Tracker:FindObjectForCode("@" .. levelName .. "/" .. rankName)
        --@cast levelRankLocation LocationSection
        if levelRankLocation ~= nil then
            if levelRankLocation.AccessibilityLevel == AccessibilityLevel.Cleared then
                levelsCompleted = levelsCompleted + 1
                levelsUnlocked = levelsUnlocked + 1
            end
            if levelRankLocation.AccessibilityLevel == AccessibilityLevel.Normal then
                levelsUnlocked = levelsUnlocked + 1
            end
        end
    end

    return {
        isInLogic = levelsUnlocked >= requirement,
        hasRequirementCompleted = levelsCompleted >= requirement,
    };
end

---@param chapter string
function IsBossInLogic(chapter)
    local info = GetChapterLevelInfo(chapter)
    return info.isInLogic
end

---@param chapter string
function IsBossUnlocked(chapter)
    local info = GetChapterLevelInfo(chapter)
    return info.hasRequirementCompleted
end

function HasAllBossesInLogic()
    return IsBossInLogic("1") and
        IsBossInLogic("2") and
        IsBossInLogic("3") and
        IsBossInLogic("4") and
        IsBossInLogic("5") and
        IsBossInLogic("6") and
        IsBossInLogic("7")
end

function HasAllBossesUnlocked()
    return IsBossUnlocked("1") and
        IsBossUnlocked("2") and
        IsBossUnlocked("3") and
        IsBossUnlocked("4") and
        IsBossUnlocked("5") and
        IsBossUnlocked("6") and
        IsBossUnlocked("7")
end

Archipelago:AddClearHandler("Clear", onClear)
Archipelago:AddItemHandler("Item", onItem)
Archipelago:AddLocationHandler("Location", onLocation)
print("Rhythm-Doctor archipelago setup completed")
