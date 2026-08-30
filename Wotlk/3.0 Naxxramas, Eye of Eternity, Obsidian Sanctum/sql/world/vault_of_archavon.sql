-- remove Emalon the Storm Watcher, Koralon the Flame Watcher, Toravon the Ice Watcher
-- introduces in patch 3.1, 3.2 and 3.3 respectively
delete from acore_world.creature where id in (33993, 35013, 38433);
