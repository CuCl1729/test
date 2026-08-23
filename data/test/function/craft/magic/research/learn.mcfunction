#> test:craft/magic/research/learn
# @s = 研究するプレイヤー
# @macro id: 習得する魔法要素id(タイプ/効果/ステータスで共通)
# 習得状況はoh_my_datの個別ストレージへ保持する(スコアボードだとタイプ・効果を増やすたびに
# objectiveを足す必要があるため)

function #oh_my_dat:please

scoreboard players set #newly_learned test.temporary 0
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.known{$(id):1b} run scoreboard players set #newly_learned test.temporary 1

execute if score #newly_learned test.temporary matches 1 run scoreboard players remove @s test.status.skill_point 1
$execute if score #newly_learned test.temporary matches 1 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.known.$(id) set value 1b
$execute if score #newly_learned test.temporary matches 1 run tellraw @s [{text:"魔法要素「",color:gold},{text:"$(id)",color:aqua},{text:"」を習得した！",color:gold}]
$execute if score #newly_learned test.temporary matches 0 run tellraw @s [{text:"魔法要素「",color:gray},{text:"$(id)",color:aqua},{text:"」はすでに習得済みです",color:gray}]
