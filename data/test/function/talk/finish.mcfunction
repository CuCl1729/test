#> test:talk/finish
# @s = プレイヤー。ノードを出し終えた。ボタンが1つも無ければ(次も選択肢も無い・選択肢の条件を全部満たさない)会話を終える

execute store result score #to test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.opts
execute if score #to test.temporary matches 0 run function test:talk/end
