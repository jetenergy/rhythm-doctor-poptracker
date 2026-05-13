RD_Maps = {}

-- levels required for act bosses
RD_Maps.BossLevels = {
    ["1"] = {"1", "2", "3", "4", "5", "6"},
    ["2"] = {"13", "14", "15", "16", "17", "18", "19", "20", "21"},
    ["3"] = {"7", "8", "9", "10", "11", "12"},
    ["4"] = {"23", "24", "25", "26", "27", "28", "29", "30"},
    ["5"] = {"31", "32", "33", "34", "35", "36"},
    ["6"] = {"38", "39"},
    ["7"] = {"22", "40"},
}

-- Level 22 is 2-XN, this has boss locations but is considered a normal level for chapter 7
RD_Maps.HasBossLocations = {
    ["22"] = true
}

-- This map needs to stay in line with items/items.json
RD_Maps.LevelNames = {
    ["1"] = "1-1 - Samurai Techno",
    ["2"] = "1-1N - Samurai Dubstep",
    ["3"] = "1-2 - Intimate",
    ["4"] = "1-2N - Intimate (Night)",
    ["5"] = "1-CNY - Chinese New Year",
    ["6"] = "1-BOO - theme of really spooky bird",
    ["7"] = "3-1 - Sleepy Garden",
    ["8"] = "3-1N - Lounge",
    ["9"] = "3-2 - Classy",
    ["10"] = "3-2N - Classy (Night)",
    ["11"] = "3-3 - Distant Duet",
    ["12"] = "3-3N - Distant Duet (Night)",
    ["13"] = "2-1 - Lo-fi Hip-Hop Beats To Treat Patients To",
    ["14"] = "2-1N - wish i could care less",
    ["15"] = "2-2 - Supraventricular Tachycardia",
    ["16"] = "2-2N - Unreachable",
    ["17"] = "2-3 - Puff Piece",
    ["18"] = "2-3N - Bomb-Sniffing Pomeranian",
    ["19"] = "2-4 - Song of the Sea",
    ["20"] = "2-4N - Song of the Sea (Night)",
    ["21"] = "2-B1 - Beans Hopper",
    ["22"] = "2-XN - Bitter Times",
    ["23"] = "4-1 - Training Doctor's Train Ride Performance",
    ["24"] = "4-1N - Rollerdisco Rumble",
    ["25"] = "4-2 - Invisible",
    ["26"] = "4-2N - Invisible (Night)",
    ["27"] = "4-3 - Steinway",
    ["28"] = "4-3N - Steinway Reprise",
    ["29"] = "4-4 - Know You",
    ["30"] = "4-4N - Murmurs",
    ["31"] = "5-1 - Lucky Break",
    ["32"] = "5-1N - One Slip Too Late",
    ["33"] = "5-2 - Lo-fi Beats For Patients To Chill To",
    ["34"] = "5-2N - Unsustainable Inconsolable",
    ["35"] = "5-3 - Seventh-Inning Stretch",
    ["36"] = "5-3N - Corazones Viejos",
    ["37"] = "5-B1 - Rhythm Weightlifter",
    ["38"] = "6-1 - Something To Tell You",
    ["39"] = "6-2 - Welcome Back",
    ["40"] = "7-1 - Blurred",
    ["41"] = "X-FTS - Fixations Towards the Stars",
    ["42"] = "X-KOB - Kingdom of Balloons",
    ["43"] = "X-WOT - Worn Out Tapes",
    ["44"] = "X-MAT - Meet and Tweet",
    ["45"] = "MD-1 - Blackest Luxury Car",
    ["46"] = "MD-2 - tape/stop/night",
    ["47"] = "MD-3 - The 90's Decision",
    ["48"] = "X-0 - Helping Hands",
    ["49"] = "X-1 - Art Exercise",
    ["50"] = "SVT Ward Key",
    ["51"] = "Train Key",
    ["52"] = "Physiotherapy Ward Key",
    ["53"] = "Basement Key",
    ["54"] = "Garden Room Key",
    ["55"] = "Records Room Key",
    ["67"] = "X-PBC - público cautivo",
}

RD_Maps.LevelRanks = {
    [0] = "B Rank",
    [1] = "A Rank",
    [2] = "S Rank"
}

RD_Maps.BossRanks = {
    [0] = "Clear",
    [1] = "Complete+ Without Checkpoints",
    [2] = "Perfect Clear"
}
