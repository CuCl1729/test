#> test:buff/native/unit_loop
# 内部。buff_native.work.units の先頭の段を1回だけ数える。
# 同じ行が二重に宣言されていても寄与は1回(行の有無だけを見る)。
# 行が合うのに per_stack が無い段は、黙って飛ばさずに断る(半端な量を入れてしまわないため)

scoreboard players set #bn_hit test.buff.work 0
execute if data storage test: buff_native.work.units[0].eff.effects[{kind:"function",event:"apply",tag:false,path:"test:buff/on/apply/speed_up"}] run scoreboard players set #bn_hit test.buff.work 1
execute if score #bn_hit test.buff.work matches 1 unless data storage test: buff_native.work.units[0].eff.params.per_stack run scoreboard players set #bn_bad test.buff.work 1
execute if score #bn_hit test.buff.work matches 1 if data storage test: buff_native.work.units[0].eff.params.per_stack run data modify storage test: buff_native.work.speed append from storage test: buff_native.work.units[0].eff.params.per_stack
execute if score #bn_hit test.buff.work matches 1 run scoreboard players add #bn_speed_n test.buff.work 1

scoreboard players set #bn_hit test.buff.work 0
execute if data storage test: buff_native.work.units[0].eff.effects[{kind:"function",event:"apply",tag:false,path:"test:buff/on/apply/jump_up"}] run scoreboard players set #bn_hit test.buff.work 1
execute if score #bn_hit test.buff.work matches 1 unless data storage test: buff_native.work.units[0].eff.params.per_stack run scoreboard players set #bn_bad test.buff.work 1
execute if score #bn_hit test.buff.work matches 1 if data storage test: buff_native.work.units[0].eff.params.per_stack run data modify storage test: buff_native.work.jump append from storage test: buff_native.work.units[0].eff.params.per_stack
execute if score #bn_hit test.buff.work matches 1 run scoreboard players add #bn_jump_n test.buff.work 1

data remove storage test: buff_native.work.units[0]
execute if data storage test: buff_native.work.units[0] run function test:buff/native/unit_loop
