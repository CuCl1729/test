#> test:craft/magic/research/click_top_learn
# @s = 研究しようとしているプレイヤー。@macro id: 習得したい要素id
# 旧・素材アイテム式のcraft/magic/research/craft.mcfunctionが持っていた
# 「スキルポイント不足なら消費しない」ガードをここで再現する

$execute if score @s test.status.skill_point matches 1.. run function test:craft/magic/research/learn {id:"$(id)"}
execute unless score @s test.status.skill_point matches 1.. run tellraw @s [{text:"スキルポイントが足りません",color:red}]
