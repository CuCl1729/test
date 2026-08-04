#> test:battle/action/attack
# @s = 行動を選んだ攻撃者。同じ戦闘エリア内の生存している相手陣営を1体選び、物理ダメージを与える。
# 簡易実装: test.status.atk をそのまま物理ダメージ量として扱う（武器固有の倍率は今後のクラフト実装で拡張予定）

execute if entity @s[type=player] as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add hit
execute unless entity @s[type=player] as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add hit

function test:status/update {status:"atk"}

scoreboard players set #damage test.fire_damage 0
scoreboard players set #damage test.water_damage 0
scoreboard players set #damage test.wood_damage 0
scoreboard players set #damage test.metal_damage 0
scoreboard players set #damage test.earth_damage 0

scoreboard players operation #damage test.physics_damage = @s test.status.atk
scoreboard players operation #damage test.physics_damage *= @s test.physics_damage.bonus
scoreboard players operation #damage test.physics_damage /= #100 test.constant

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.physics_resist.pene 0
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

execute as @e[tag=hit] run function test:damage/
tag @e remove hit

function test:battle/turn_end
