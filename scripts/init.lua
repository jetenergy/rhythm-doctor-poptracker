
Tracker:AddItems("items/items.json")

Tracker:AddLocations("locations/locations.json")

Tracker:AddMaps("maps/maps.json")

Tracker:AddLayouts("layouts/standard.json")

Tracker:AddLayouts("layouts/items.json")

Tracker:AddLayouts("layouts/maps.json")
Tracker:AddLayouts("layouts/maps/main.json")
Tracker:AddLayouts("layouts/maps/svt.json")


if Archipelago then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
