#> test:talk/press
# @s = /trigger test.talk を押したプレイヤー(test:tick から)。会話中で、押された値の通し番号が今のノードのもので、
# その番号の選択肢があり、NPC から8ブロック以内なら、次のノードへ進む。違えば何もしない(値は0に戻して、また押せるようにする)

function #oh_my_dat:please
scoreboard players operation #tp test.temporary = @s test.talk
scoreboard players set @s test.talk 0
scoreboard players enable @s test.talk
execute unless entity @s[tag=talking] run return 0
scoreboard players operation #tseq test.temporary = #tp test.temporary
scoreboard players operation #tseq test.temporary /= #10 test.constant
scoreboard players operation #tp test.temporary %= #10 test.constant
execute unless score #tseq test.temporary = @s test.talk_seq run return 0
data modify storage test: talk_work.p set value {i:0,npc:""}
execute store result storage test: talk_work.p.i int 1 run scoreboard players get #tp test.temporary
data modify storage test: talk_work.p.npc set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.npc
function test:talk/press_go with storage test: talk_work.p
