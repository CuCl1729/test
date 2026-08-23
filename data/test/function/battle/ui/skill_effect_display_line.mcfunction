#> test:battle/ui/skill_effect_display_line
# @s = 効果選択中のプレイヤー(#oh_my_dat:pleaseは呼び出し元で実行済み)
# @macro id/label/color/max/index: レジストリの1件ぶん
# maxが2ならON/OFF、3以上なら重ねがけ段階(×1〜)として表示する

scoreboard players set #select test.temporary 0
$execute store result score #select test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect.$(id)

$execute if score #select test.temporary matches 0 run tellraw @s [{text:"[無効] ",color:dark_gray},{text:"$(label)",color:"$(color)"},{text:" (クリックで選択)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set $(index)"}}]
$execute if score #select test.temporary matches 1.. if data storage test: asset.magic.effects[{id:"$(id)",max:2}] run tellraw @s [{text:"[有効] ",color:green},{text:"$(label)",color:"$(color)"},{text:" (クリックで解除)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set $(index)"}}]
$execute if score #select test.temporary matches 1.. unless data storage test: asset.magic.effects[{id:"$(id)",max:2}] run tellraw @s [{text:"[有効] ",color:green},{text:"$(label) ×",color:"$(color)"},{score:{name:"#select",objective:"test.temporary"},color:"$(color)"},{text:" (クリックで重ねる)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set $(index)"}}]
