#> test:battle/enemy_ai/gimmick/magic
# @s = 手番の敵。@macro element/power/target/label: 属性(physics/fire/…)・威力(攻撃力の何%)・
# 対象(one=一番近い1人 / all=全員)・魔法の名前。その属性の魔法でプレイヤーを攻撃する(魔法なので会心は出ない)。
# プレイヤーの魔法の処理(MP・反動・神秘)は敵に合わないので使わず、ここで #damage を作る

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

# 攻撃力 × power% × その属性の与ダメ倍率
$scoreboard players set #magic_power test.temporary $(power)
$scoreboard players operation #damage test.$(element)_damage = @s test.status.atk
$scoreboard players operation #damage test.$(element)_damage *= #magic_power test.temporary
$scoreboard players operation #damage test.$(element)_damage /= #100 test.constant
$scoreboard players operation #damage test.$(element)_damage *= @s test.$(element)_damage.bonus
$scoreboard players operation #damage test.$(element)_damage /= #100 test.constant
$scoreboard players operation #damage test.$(element)_resist.pene = @s test.$(element)_resist.pene
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.status.crit_rate 0
scoreboard players set #damage test.status.crit_damage 100

$tellraw @a[distance=..64] ["",{selector:"@s"},{text:" の$(label)！",color:light_purple}]

tag @s add battle_caster
scoreboard players operation #target_battle test.battle.id = @s test.battle.id
$function test:battle/enemy_ai/part/target_$(target) {fn:"magic_hit"}
tag @e remove battle_caster

function test:battle/turn_end
