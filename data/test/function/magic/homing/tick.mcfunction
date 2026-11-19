#> test:magic/homing/tick
# @s = 追尾する側(弾・自動ビーム。at @s)。@macro radius: 探す距離 / turn: 回る速さ(度/秒) /
# delay_ticks: 発射から向きを変え始めるまでのtick数(それまでは相手を選んでおくだけで向きは変えない)。
# 覚えている相手が居なければ選び直し(飛びながら探す)、相手が居れば 1 tick ぶんだけその方へ回る。
# 相手が1つも見つからなければ今の向きのまま進む
execute store result score #homing_has test.temporary run function test:magic/homing/look

$execute if score #homing_has test.temporary matches 0 run function test:magic/homing/acquire {radius:$(radius)}
execute if score #homing_has test.temporary matches 0 store result score #homing_has test.temporary run function test:magic/homing/look

execute store result score #homing_elapsed test.temporary run time query gametime
scoreboard players operation #homing_elapsed test.temporary -= @s test.homing.launch
$execute if score #homing_has test.temporary matches 1 if score #homing_elapsed test.temporary matches $(delay_ticks).. run function test:magic/homing/steer {turn:$(turn)}
tag @e remove homing_target
