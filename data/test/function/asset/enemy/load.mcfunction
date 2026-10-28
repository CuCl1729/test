#> test:asset/enemy/load
# @macro id: 敵のid(asset.enemy.<id>。スプレッドシートの「敵」タブから生成)。
# 定義から、test:asset/enemy/summon が読む storage test: enemy(Tags・名前・data)と #enemy のスコアを作る。
# HP・MP は最大値と同じで始まる。被ダメージ増加率・与ダメージ倍率は100、貫通・デバフは0で固定

data remove storage test: enemy
$data modify storage test: enemy.Tags set value ["$(id)"]
data modify storage test: enemy.id set value armor_stand
$execute if data storage test: asset.enemy.$(id).name run data modify storage test: enemy.name set from storage test: asset.enemy.$(id).name
$data modify storage test: enemy.data set from storage test: asset.enemy.$(id).data

$execute store result score #enemy test.status.hp_max run data get storage test: asset.enemy.$(id).stats.hp
scoreboard players operation #enemy test.status.hp = #enemy test.status.hp_max
$execute store result score #enemy test.status.mp_max run data get storage test: asset.enemy.$(id).stats.mp
scoreboard players operation #enemy test.status.mp = #enemy test.status.mp_max
$execute store result score #enemy test.status.atk run data get storage test: asset.enemy.$(id).stats.atk
$execute store result score #enemy test.status.def run data get storage test: asset.enemy.$(id).stats.def
$execute store result score #enemy test.def.coefficient run data get storage test: asset.enemy.$(id).stats.coef
$execute store result score #enemy test.status.crit_rate run data get storage test: asset.enemy.$(id).stats.crit_rate
$execute store result score #enemy test.status.crit_damage run data get storage test: asset.enemy.$(id).stats.crit_damage
$execute store result score #enemy test.status.exp run data get storage test: asset.enemy.$(id).stats.exp
scoreboard players set #enemy test.status.divergence 0
scoreboard players set #enemy test.status.effect_damage 0
scoreboard players set #enemy test.status.magic_efficiency 0
scoreboard players set #enemy test.def.debuff 0
scoreboard players set #enemy test.def.pene 0

$execute store result score #enemy test.physics_resist run data get storage test: asset.enemy.$(id).resist.physics
$execute store result score #enemy test.fire_resist run data get storage test: asset.enemy.$(id).resist.fire
$execute store result score #enemy test.water_resist run data get storage test: asset.enemy.$(id).resist.water
$execute store result score #enemy test.wood_resist run data get storage test: asset.enemy.$(id).resist.wood
$execute store result score #enemy test.metal_resist run data get storage test: asset.enemy.$(id).resist.metal
$execute store result score #enemy test.earth_resist run data get storage test: asset.enemy.$(id).resist.earth

scoreboard players set #enemy test.fire_damage_inc.bonus 100
scoreboard players set #enemy test.water_damage_inc.bonus 100
scoreboard players set #enemy test.wood_damage_inc.bonus 100
scoreboard players set #enemy test.metal_damage_inc.bonus 100
scoreboard players set #enemy test.earth_damage_inc.bonus 100
scoreboard players set #enemy test.physics_damage_inc.bonus 100

scoreboard players set #enemy test.fire_damage.bonus 100
scoreboard players set #enemy test.water_damage.bonus 100
scoreboard players set #enemy test.wood_damage.bonus 100
scoreboard players set #enemy test.metal_damage.bonus 100
scoreboard players set #enemy test.earth_damage.bonus 100
scoreboard players set #enemy test.physics_damage.bonus 100

scoreboard players set #enemy test.fire_resist.pene 0
scoreboard players set #enemy test.water_resist.pene 0
scoreboard players set #enemy test.wood_resist.pene 0
scoreboard players set #enemy test.metal_resist.pene 0
scoreboard players set #enemy test.earth_resist.pene 0
scoreboard players set #enemy test.physics_resist.pene 0
