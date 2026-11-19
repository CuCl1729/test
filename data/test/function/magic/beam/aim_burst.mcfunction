#> test:magic/beam/aim_burst
# @s = 持ち主。狙いを付けた相手(homing_target)へ、散らさずに本数ぶん出す
scoreboard players set #beam_index test.temporary 0
execute facing entity @e[tag=homing_target,limit=1] eyes run function test:magic/beam/aim_loop
tag @e remove homing_target
