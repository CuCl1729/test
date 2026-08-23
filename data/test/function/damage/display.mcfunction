#> test:damage/display
# @s = ダメージを受けた対象。攻撃者は一時タグdamage_attackerで参照する
# @macro verb: メッセージの文言(剣は" の攻撃！ "、魔法は" の魔法！ ")
# 攻撃者の設定(test.settings.damage_display: 1=チャット 2=頭上ポップアップ 3=両方)に応じて表示する
# (プレイヤーが敵に与えるダメージのみ表示するため、対象が敵でなければ何もしない)

execute unless entity @s[tag=enemy] run return 0

scoreboard players set #total_damage test.temporary 0
scoreboard players operation #total_damage test.temporary += #victim test.fire_damage
scoreboard players operation #total_damage test.temporary += #victim test.water_damage
scoreboard players operation #total_damage test.temporary += #victim test.wood_damage
scoreboard players operation #total_damage test.temporary += #victim test.metal_damage
scoreboard players operation #total_damage test.temporary += #victim test.earth_damage
scoreboard players operation #total_damage test.temporary += #victim test.physics_damage
scoreboard players operation #total_damage test.temporary /= #100 test.constant

$execute if score @e[tag=damage_attacker,limit=1] test.settings.damage_display matches 1 run tellraw @a ["",{selector:"@e[tag=damage_attacker,limit=1]"},{text:"$(verb)",color:gray},{selector:"@s"},{text:" に",color:gray},{score:{name:"#total_damage",objective:"test.temporary"},color:red},{text:"ダメージ！",color:gray}]
$execute if score @e[tag=damage_attacker,limit=1] test.settings.damage_display matches 3 run tellraw @a ["",{selector:"@e[tag=damage_attacker,limit=1]"},{text:"$(verb)",color:gray},{selector:"@s"},{text:" に",color:gray},{score:{name:"#total_damage",objective:"test.temporary"},color:red},{text:"ダメージ！",color:gray}]

execute if score @e[tag=damage_attacker,limit=1] test.settings.damage_display matches 2 at @s run function test:damage/display_pop
execute if score @e[tag=damage_attacker,limit=1] test.settings.damage_display matches 3 at @s run function test:damage/display_pop
