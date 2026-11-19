#> test:magic/homing/acquire
# @s = 狙う側(弾・ビーム。at @s)。@macro radius: 相手を探す距離(ほかのキーも渡ってくるが使わない)。
# 狙える相手のうち一番近いものを選び、その番号を @s test.homing.target に覚える。見つかれば 1 を返す
#
# 狙えるのは「HPのある、ターン制の戦闘に入っていない敵」だけ。詠唱者・ほかのプレイヤー・味方・
# 戦闘中の相手は選ばない(プレイヤーは tag=enemy を持たないので、この条件だけで外れる)
scoreboard players set #homing_found test.temporary 0
$execute as @e[tag=enemy,tag=!battle_member,scores={test.status.hp=1..},distance=..$(radius),sort=nearest,limit=1] run function test:magic/homing/mark
execute if score #homing_found test.temporary matches 1 run scoreboard players operation @s test.homing.target = #homing_eid test.temporary
return run scoreboard players get #homing_found test.temporary
