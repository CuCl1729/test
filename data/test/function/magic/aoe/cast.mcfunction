#> test:magic/aoe/cast
# @s = 詠唱者。自分を中心とした円状に、組み合わせた効果を適用する(リアルタイム戦闘)
# ダメージ量は詠唱者に乗っている値をprojectile/move.mcfunctionと同じ要領で#damageへ移す

scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage
scoreboard players set #damage test.physics_damage 0

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.def.pene = @s test.def.pene

scoreboard players operation #damage test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation #damage test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation #damage test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation #damage test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation #damage test.earth_resist.pene = @s test.earth_resist.pene

execute store result score #aoe_radius test.temporary run data get storage test: magic.player.aoe.radius

scoreboard players set #aoe_heal test.temporary 0
execute if data storage test: magic.player.heal run scoreboard players set #aoe_heal test.temporary 1

# 詠唱者を含むプレイヤーはダメージ側の対象から外れる(apply側でtype=!playerに絞っている)ため、
# 自分を巻き込む心配はない。逆に回復効果は円内の味方として自分にも掛かる
# ダメージ表示(test:damage/display)が詠唱者を引けるよう一時タグを付けておく
tag @s add damage_attacker

execute at @s run function test:magic/aoe/scan
execute at @s run function test:magic/aoe/apply

tag @s remove damage_attacker
