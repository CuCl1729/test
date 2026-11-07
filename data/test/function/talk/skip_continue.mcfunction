#> test:talk/skip_continue
function #oh_my_dat:please
execute unless entity @s[tag=talking] run return run function test:talk/skip_stop
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.next run return run function test:talk/skip_stop
data modify storage test: talk_work.skip set value {npc:"",node:""}
data modify storage test: talk_work.skip.npc set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.npc
data modify storage test: talk_work.skip.node set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.next
function test:talk/skip_go with storage test: talk_work.skip
