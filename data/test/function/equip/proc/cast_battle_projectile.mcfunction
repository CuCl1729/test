#> test:equip/proc/cast_battle_projectile
# @s = 防具の投射の魔法を唱えるプレイヤー(at @s)。当たった敵(equip_proc_target。test:equip/proc/queue が付ける)が
# 生きていればその1体、いなければ一番近い生きている敵を狙う(どちらも同じ戦闘のものだけ)

function test:battle/target/clear
scoreboard players operation #proc_cast_battle test.battle.id = @s test.battle.id
function test:equip/proc/cast_battle_pick_hit
execute store result score #has_target test.temporary run function test:battle/target/exists
execute if score #has_target test.temporary matches 0 run function test:equip/proc/cast_battle_pick_nearest

function test:battle/action/skill_cast/apply_projectile
function test:battle/target/clear
