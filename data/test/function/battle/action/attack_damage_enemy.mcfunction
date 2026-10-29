#> test:battle/action/attack_damage_enemy
# @s = 攻撃する敵。攻撃力をそのまま、その敵の攻撃属性(data.attack_element。シートの「攻撃属性」、無ければ物理)の
# ダメージとして #damage に載せる

scoreboard players set #damage test.physics_damage 0
scoreboard players set #damage test.fire_damage 0
scoreboard players set #damage test.water_damage 0
scoreboard players set #damage test.wood_damage 0
scoreboard players set #damage test.metal_damage 0
scoreboard players set #damage test.earth_damage 0
scoreboard players set #damage test.physics_resist.pene 0
scoreboard players set #damage test.fire_resist.pene 0
scoreboard players set #damage test.water_resist.pene 0
scoreboard players set #damage test.wood_resist.pene 0
scoreboard players set #damage test.metal_resist.pene 0
scoreboard players set #damage test.earth_resist.pene 0

data modify storage test: enemy_attack set value {element:"physics"}
data modify storage test: enemy_attack.element set from entity @s data.attack_element
function test:battle/action/attack_damage_enemy_element with storage test: enemy_attack

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant
