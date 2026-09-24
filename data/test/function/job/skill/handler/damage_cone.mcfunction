#> test:job/skill/handler/damage_cone
# @s = 発動するプレイヤー(職業スキル、リアルタイム)。@macro angle/multiplier/mp_cost/reach:
# このスキルのparamsがそのままmacro展開されている。test.status.atkを基準に物理ダメージを組み立て、
# 扇状範囲へ当てる(test:attack/aoeと同じ流れ)。武器固有の属性ダメージ式(damage/pre_attack)は
# 装備武器のdamageコンポーネントに依存するため使わず、通常攻撃(battle/action/attack_resolve)と
# 同じ「atk×倍率」の単純な式を職業レベル由来の火力として使う

function test:status/update {status:"atk"}
function test:status/update {status:"crit_rate"}
function test:status/update {status:"crit_damage"}

$scoreboard players set #mp_cost test.job.work $(mp_cost)

execute if score @s test.status.mp < #mp_cost test.job.work run tellraw @s [{text:"MPが足りません",color:gray}]
execute if score @s test.status.mp < #mp_cost test.job.work run return 0

scoreboard players operation @s test.status.mp -= #mp_cost test.job.work

scoreboard players set #damage test.fire_damage 0
scoreboard players set #damage test.water_damage 0
scoreboard players set #damage test.wood_damage 0
scoreboard players set #damage test.metal_damage 0
scoreboard players set #damage test.earth_damage 0

scoreboard players operation #damage test.physics_damage = @s test.status.atk
$scoreboard players set #multiplier test.job.work $(multiplier)
scoreboard players operation #damage test.physics_damage *= #multiplier test.job.work
scoreboard players operation #damage test.physics_damage /= #100 test.constant

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.physics_resist.pene 0
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant

$scoreboard players set #aoe_half_angle test.temporary $(angle)
scoreboard players operation #aoe_half_angle test.temporary /= #2 test.constant
$scoreboard players set #aoe_reach test.temporary $(reach)
scoreboard players operation @s test.repeat = #aoe_reach test.temporary

execute anchored eyes positioned ^ ^ ^0.5 run function test:scan/aoe/
