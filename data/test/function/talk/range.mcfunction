#> test:talk/range
# @s = 会話中のプレイヤー(test:tick の1秒クロックから)。話している NPC から8ブロックより遠ければ、会話を終える

function #oh_my_dat:please
data modify storage test: talk_work.r set value {npc:""}
data modify storage test: talk_work.r.npc set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.npc
function test:talk/range_check with storage test: talk_work.r
