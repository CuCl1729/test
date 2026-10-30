#> test:machine/port/out/place_try_loop
# @s = 機械のマーカー。machine_work.stack の残り(#stack_left 個)を、(out_rr + #out_try) 番目の搬出口から順に入れてみる

execute if score #stack_left test.temporary matches ..0 run return 0
execute if score #out_try test.temporary >= #out_n test.temporary run return 0

scoreboard players operation #out_i test.temporary = @s test.machine.out_rr
scoreboard players operation #out_i test.temporary += #out_try test.temporary
scoreboard players operation #out_i test.temporary %= #out_n test.temporary
data modify storage test: machine_work.out_arg set value {i:0}
execute store result storage test: machine_work.out_arg.i int 1 run scoreboard players get #out_i test.temporary
function test:machine/port/out/pick with storage test: machine_work.out_arg
function test:machine/port/out/place_into with storage test: machine_work.out_pos

scoreboard players add #out_try test.temporary 1
function test:machine/port/out/place_try_loop
