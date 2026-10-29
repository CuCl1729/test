#> test:battle/enemy_ai/part/magic_hit
# @s = 敵の魔法を受けるプレイヤー。#damage(test:battle/enemy_ai/gimmick/magic が作る)でダメージを与えて表示する

function test:damage/

scoreboard players set #total_damage test.temporary 0
scoreboard players operation #total_damage test.temporary += #victim test.physics_damage
scoreboard players operation #total_damage test.temporary += #victim test.fire_damage
scoreboard players operation #total_damage test.temporary += #victim test.water_damage
scoreboard players operation #total_damage test.temporary += #victim test.wood_damage
scoreboard players operation #total_damage test.temporary += #victim test.metal_damage
scoreboard players operation #total_damage test.temporary += #victim test.earth_damage
scoreboard players operation #total_damage test.temporary /= #100 test.constant

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" に",color:gray},{score:{name:"#total_damage",objective:"test.temporary"},color:light_purple},{text:"ダメージ！",color:gray}]
