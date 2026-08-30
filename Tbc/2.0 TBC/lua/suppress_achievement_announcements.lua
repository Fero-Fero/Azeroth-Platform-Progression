--[[
    suppress_achievement_announcements.lua

    Classic and TBC have no achievement UI. Stock AzerothCore still awards
    Wrath achievements and broadcasts them in chat / as toast packets.
    There is no worldserver.conf switch for that, so this script drops the
    packets before they reach any client.

    Requires ALE (AzerothCore Lua Engine / mod-ale).

    Wrath patch 3.0 replaces this file with a no-op so achievements work again.
]]

local PACKET_EVENT_ON_PACKET_SEND = 7

-- Opcodes from 3.3.5a Opcodes.h
local SMSG_MESSAGECHAT = 150            -- 0x096
local SMSG_ACHIEVEMENT_EARNED = 1128    -- 0x468
local SMSG_SERVER_FIRST_ACHIEVEMENT = 1176 -- 0x498

-- ChatMsg from SharedDefines.h
local CHAT_MSG_ACHIEVEMENT = 48         -- 0x30
local CHAT_MSG_GUILD_ACHIEVEMENT = 51   -- 0x33

local function dropPacket()
    return false
end

local function dropAchievementChat(event, packet, player)
    if not packet or packet:GetSize() < 1 then
        return
    end

    local chatType = packet:ReadUByte()
    if chatType == CHAT_MSG_ACHIEVEMENT or chatType == CHAT_MSG_GUILD_ACHIEVEMENT then
        return false
    end
end

RegisterPacketEvent(SMSG_ACHIEVEMENT_EARNED, PACKET_EVENT_ON_PACKET_SEND, dropPacket)
RegisterPacketEvent(SMSG_SERVER_FIRST_ACHIEVEMENT, PACKET_EVENT_ON_PACKET_SEND, dropPacket)
RegisterPacketEvent(SMSG_MESSAGECHAT, PACKET_EVENT_ON_PACKET_SEND, dropAchievementChat)