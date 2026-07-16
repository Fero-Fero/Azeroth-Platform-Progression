--[[
    interrupt_area_trigger.lua

    Blocks walking through raid entrance area triggers (Molten Core, Onyxia's
    Lair, Blackwing Lair, and every other raid in WoW 3.3.5).

    Requires ALE (AzerothCore Lua Engine / mod-ale).

    ALE cannot cancel the default areatrigger_teleport from the trigger hook
    alone, so this script:
      1. Detects raid entrance area triggers before the server teleports.
      2. Saves the player's position.
      3. Ejects them on the next map change if they land in a raid instance.

    Game Masters are exempt.
]]

local TRIGGER_EVENT_ON_TRIGGER = 24
local PLAYER_EVENT_ON_MAP_CHANGE = 28
local WORLD_EVENT_ON_STARTUP = 14

-- All raid instance map IDs in Wrath of the Lich King 3.3.5
local RAID_MAP_IDS = {
    --409,  -- Molten Core
    --249,  -- Onyxia's Lair
    309,  -- Zul'Gurub
    469,  -- Blackwing Lair
    509,  -- Ruins of Ahn'Qiraj
    531,  -- Ahn'Qiraj Temple
    532,  -- Karazhan
    533,  -- Naxxramas
    534,  -- The Battle for Mount Hyjal
    544,  -- Magtheridon's Lair
    548,  -- Serpentshrine Cavern
    550,  -- Tempest Keep (The Eye)
    564,  -- Black Temple
    565,  -- Gruul's Lair
    568,  -- Zul'Aman
    580,  -- Sunwell Plateau
    603,  -- Ulduar
    615,  -- The Obsidian Sanctum
    616,  -- The Eye of Eternity
    624,  -- Vault of Archavon
    631,  -- Icecrown Citadel
    649,  -- Trial of the Crusader
    724,  -- The Ruby Sanctum
}

local RAID_MAP_LOOKUP = {}
for _, mapId in ipairs(RAID_MAP_IDS) do
    RAID_MAP_LOOKUP[mapId] = true
end

-- triggerId -> target raid mapId
local RAID_ENTRANCE_TRIGGERS = {}

-- player low GUID -> saved outdoor position before a blocked teleport
local pendingEject = {}

local BLOCKED_MSG = "|cffff0000This raid is not yet available.|r"

local function isRaidMap(mapId)
    return RAID_MAP_LOOKUP[mapId] == true
end

local function shouldBypass(player)
    return not player or player:IsGM()
end

local function savePlayerPosition(player)
    pendingEject[player:GetGUIDLow()] = {
        map = player:GetMapId(),
        x = player:GetX(),
        y = player:GetY(),
        z = player:GetZ(),
        o = player:GetO(),
    }
end

local function loadRaidEntranceTriggers()
    RAID_ENTRANCE_TRIGGERS = {}

    local idList = table.concat(RAID_MAP_IDS, ",")
    local query = WorldDBQuery(string.format([[
        SELECT ID, target_map, Name
        FROM areatrigger_teleport
        WHERE target_map IN (%s)
    ]], idList))

    if not query then
        print("[interrupt_area_trigger] Failed to load raid entrance triggers from areatrigger_teleport.")
        return
    end

    repeat
        local triggerId = query:GetUInt32(0)
        local targetMap = query:GetUInt32(1)
        local name = query:GetString(2) or "unknown"
        RAID_ENTRANCE_TRIGGERS[triggerId] = targetMap
        print(string.format(
            "[interrupt_area_trigger] Blocking raid entrance trigger %u -> map %u (%s)",
            triggerId, targetMap, name
        ))
    until not query:NextRow()
end

local function onRaidEntranceTrigger(event, player, triggerId)
    if shouldBypass(player) then
        return
    end

    local targetMap = RAID_ENTRANCE_TRIGGERS[triggerId]
    if not targetMap then
        return
    end

    savePlayerPosition(player)
    player:SendBroadcastMessage(BLOCKED_MSG)
    return true
end

local function onMapChange(event, player)
    if shouldBypass(player) then
        return
    end

    local guid = player:GetGUIDLow()
    local saved = pendingEject[guid]
    if not saved then
        return
    end

    if not isRaidMap(player:GetMapId()) then
        pendingEject[guid] = nil
        return
    end

    player:Teleport(saved.map, saved.x, saved.y, saved.z, saved.o)
    player:SendBroadcastMessage(BLOCKED_MSG)
    pendingEject[guid] = nil
end

local function onStartup(event)
    loadRaidEntranceTriggers()
end

RegisterServerEvent(WORLD_EVENT_ON_STARTUP, onStartup)
RegisterServerEvent(TRIGGER_EVENT_ON_TRIGGER, onRaidEntranceTrigger)
RegisterPlayerEvent(PLAYER_EVENT_ON_MAP_CHANGE, onMapChange)
