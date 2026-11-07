#> test:talk/skip
# 線形の次へだけを進む。分岐の選択はプレイヤーへ戻す。
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.next run return 0
tag @s add talk_skipping
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.skip_left set value 32
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.visited set value []
data modify storage test: talk_work.skip set value {node:"",npc:""}
data modify storage test: talk_work.skip.node set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.node
function test:talk/skip_visit with storage test: talk_work.skip
function test:talk/skip_continue
