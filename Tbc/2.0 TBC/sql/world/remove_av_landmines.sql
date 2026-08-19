/*
    This optional file adds landmines to the vanilla version of Alterac Valley
    Please note that bots are not aware of the existence of these mines. They will not avoid areas that have many mines.
    You can only see the landmines of your own faction.
*/

SET @OGUID    := 657000;

/* FROSTWOLF LANDMINES */
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+101 AND @OGUID+299;

/* STORMPIKE LANDMINES */
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+301 AND @OGUID+499;

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (179324, 179325);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `ConditionTypeOrReference` = 6 AND `SourceEntry` IN (179324, 179325);
