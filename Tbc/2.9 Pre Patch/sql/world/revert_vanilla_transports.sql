UPDATE `gameobject_template` SET `Data0` = 967  WHERE `entry` = 176310; -- The Bravery
UPDATE `gameobject_template` SET `Data0` = 964 WHERE `entry` = 181688; -- The Northspear

UPDATE `transports` SET `name` = 'Auberdine, Darkshore and Stormwind Harbor (Boat, Alliance ("The Bravery"))' WHERE `guid` = 2;
UPDATE `transports` SET `name` = 'Menethil Harbor, Wetlands and Valgarde, Howling Fjord (Boat, Alliance ("Northspear"))' WHERE `guid` = 10;

-- update text for harbormasters
UPDATE `npc_text` SET `text0_0` = 'On the northern dock, you can board a ship that will carry you to Rut'theran Village and Darnassus.  From the southern dock, you can find passage across the Great Sea to Stormwind Harbor.  The dock to the west, at the end of the pier, leads to Azuremyst Isle, near the Exodar. Safe journeys to you!' WHERE `ID` = 5480;
UPDATE `npc_text` SET `text0_1` = 'We've sworn to do our very best to protect the passengers of The Bravery. The sea lane between Auberdine to Stormwind Harbor must remain safe.' WHERE `ID` = 12270;
UPDATE `npc_text` SET `text0_0` = 'The steam-powered Alliance icebreaker Northspear sails from here to Menethil Harbor in the Wetlands, across the sea in the Eastern Kingdoms.' WHERE `ID` = 12638;
UPDATE `npc_text` SET `text0_1` = 'From this dock, The Bravery travels back and forth between Stormwind and Auberdine.' WHERE `ID` = 13321;

UPDATE `broadcast_text` SET `MaleText` = 'On the northern dock, you can board a ship that will carry you to Rut'theran Village and Darnassus.  From the southern dock, you can find passage across the Great Sea to Stormwind Harbor.  The dock to the west, at the end of the pier, leads to Azuremyst Isle, near the Exodar. Safe journeys to you!' WHERE `ID` = 8106;
UPDATE `broadcast_text` SET `FemaleText` = 'We've sworn to do our very best to protect the passengers of The Bravery. The sea lane between Rut'theran Village and Stormwind Harbor must remain safe.' WHERE `ID` = 24118;
UPDATE `broadcast_text` SET `MaleText` = 'The steam-powered Alliance icebreaker Northspear sails from here to Menethil Harbor in the Wetlands, across the sea in the Eastern Kingdoms.' WHERE `ID` = 25748;
UPDATE `broadcast_text` SET `FemaleText` = 'From this dock, The Bravery travels back and forth between Stormwind and Rut'theran Village.' WHERE `ID` = 28636;

-- replace Auberdine Sentinels with Menethil guards
UPDATE `creature` SET `id` = 1434 WHERE `guid` IN (9449, 9518);         

-- restore Auberdine Sentinels from Stormwind Harbor
INSERT INTO acore_world.creature (guid, id, `map`, zoneId, areaId, spawnMask, phaseMask, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, wander_distance, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags, ScriptName, VerifiedBuild, CreateObject, Comment) VALUES(203462, 6086, 0, 0, 0, 1, 1, 1, -8606.82, 1239.39, 5.33124, 0.6379, 275, 0.0, 0, 3048, 0, 0, 0, 0, 0, '', 0, 0, NULL);
INSERT INTO acore_world.creature (guid, id, `map`, zoneId, areaId, spawnMask, phaseMask, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, wander_distance, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags, ScriptName, VerifiedBuild, CreateObject, Comment) VALUES(203463, 6086, 0, 0, 0, 1, 1, 1, -8592.74, 1246.62, 5.3304, 3.63, 275, 0.0, 0, 3048, 0, 0, 0, 0, 0, '', 0, 0, NULL);
INSERT INTO acore_world.creature (guid, id, `map`, zoneId, areaId, spawnMask, phaseMask, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, wander_distance, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags, ScriptName, VerifiedBuild, CreateObject, Comment) VALUES(203464, 6086, 0, 0, 0, 1, 1, 1, -8645.35, 1314.62, 5.33226, 0.43, 275, 0.0, 0, 3048, 0, 0, 0, 0, 0, '', 0, 0, NULL);
INSERT INTO acore_world.creature (guid, id, `map`, zoneId, areaId, spawnMask, phaseMask, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, wander_distance, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags, ScriptName, VerifiedBuild, CreateObject, Comment) VALUES(203465, 6086, 0, 0, 0, 1, 1, 1, -8633.03, 1322.93, 5.33226, 3.8, 275, 0.0, 0, 3048, 0, 0, 0, 0, 0, '', 0, 0, NULL);

UPDATE `gameobject_template` SET `name` = "Boat to Stormwind" WHERE `entry` = 176364; -- sign

-- remove taxi path nodes
DELETE FROM `taxipath_dbc` WHERE `ID` = 1981;
DELETE FROM `taxipathnode_dbc` WHERE `PathID` = 1981;
