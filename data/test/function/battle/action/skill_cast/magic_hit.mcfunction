#> test:battle/action/skill_cast/magic_hit
# @s = ダメージを受ける対象(1体)。詠唱者は一時タグbattle_casterで参照する。
# 範囲魔法で複数体を同時にループ処理する場合でも、対象ごとに個別のダメージ計算・メッセージ表示を行う

function test:damage/

scoreboard players set #total_damage test.temporary 0
scoreboard players operation #total_damage test.temporary += #victim test.fire_damage
scoreboard players operation #total_damage test.temporary += #victim test.water_damage
scoreboard players operation #total_damage test.temporary += #victim test.wood_damage
scoreboard players operation #total_damage test.temporary += #victim test.metal_damage
scoreboard players operation #total_damage test.temporary += #victim test.earth_damage
scoreboard players operation #total_damage test.temporary /= #100 test.constant

tellraw @a ["",{selector:"@e[tag=battle_caster,limit=1]"},{text:" の魔法！ ",color:light_purple},{selector:"@s"},{text:" に",color:gray},{score:{name:"#total_damage",objective:"test.temporary"},color:light_purple},{text:"ダメージ！",color:gray}]

execute if entity @s[tag=enemy,scores={test.status.hp=..0}] run tellraw @a ["",{selector:"@s"},{text:"を倒した！",color:gold}]
