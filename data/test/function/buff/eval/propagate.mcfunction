#> test:buff/eval/propagate
# 1列の繰り上げ(floor)をa0から順にa12へ伝える。a12自体は最上位桁で、符号を保つため%・/はしない

scoreboard players operation #be_c test.buff.work = #be_a0 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a0 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a1 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a1 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a1 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a2 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a2 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a2 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a3 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a3 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a3 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a4 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a4 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a4 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a5 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a5 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a5 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a6 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a6 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a6 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a7 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a7 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a7 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a8 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a8 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a8 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a9 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a9 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a9 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a10 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a10 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a10 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a11 test.buff.work += #be_c test.buff.work

scoreboard players operation #be_c test.buff.work = #be_a11 test.buff.work
scoreboard players operation #be_c test.buff.work /= #be_100 test.buff.work
scoreboard players operation #be_a11 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_a12 test.buff.work += #be_c test.buff.work
