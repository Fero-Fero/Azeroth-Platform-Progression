/* Vanilla (infinite) */
DELETE FROM `spell_cooldown_overrides` WHERE `Id` IN (11479, 11480, 17187, 17559, 17560, 17561, 17562, 17563, 17564, 17565, 17566, 18560, 25146);

/* Salt Shaker (infinite) */
UPDATE `item_template` SET `spellcooldown_1` = 0, `spellcategorycooldown_1` = 0 WHERE entry = 15846;

/* TBC (infinite) */
DELETE FROM `spell_cooldown_overrides` WHERE `Id` IN (26751, 28566, 28567, 28568, 28569, 29688, 32765, 32766, 31373, 36686);
