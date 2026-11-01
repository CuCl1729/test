#> test:talk/begin
# @s = プレイヤー。@macro node: 今から出すノード。通し番号を増やし(古い会話のボタンを効かなくする)、選択肢の記録を空にして、ボタンを受け取れるようにする

scoreboard players add @s test.talk_seq 1
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.node set value "$(node)"
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.opts set value {}
scoreboard players set @s test.talk 0
scoreboard players enable @s test.talk
