#> test:talk/btn
# @s = プレイヤー。@macro i/label/node: 選択肢の番号(1〜9)・ラベル・進む先。押すと /trigger test.talk set <通し番号×10+番号> になるボタンを @s にだけ出し、
# 番号と進む先を test.talk.opts.o<番号> に記録する

scoreboard players operation #tv test.temporary = @s test.talk_seq
scoreboard players operation #tv test.temporary *= #10 test.constant
$scoreboard players add #tv test.temporary $(i)
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.opts.o$(i) set value "$(node)"
$data modify storage test: talk_work.b set value {v:0,label:"$(label)"}
execute store result storage test: talk_work.b.v int 1 run scoreboard players get #tv test.temporary
function test:talk/btn_show with storage test: talk_work.b
