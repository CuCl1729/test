#> test:buff/eval/split
# #be_v -> #be_s(符号) + #be_d0..d4(大きさの桁)。absを計算しないのはINT_MINのabsが
# int32に収まらないため。floorの%・/はスコアボード演算がそのまま与える

scoreboard players set #be_s test.buff.work 1
execute if score #be_v test.buff.work matches ..-1 run scoreboard players set #be_s test.buff.work -1

scoreboard players operation #be_r test.buff.work = #be_v test.buff.work
scoreboard players operation #be_r test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_m test.buff.work = #be_v test.buff.work
scoreboard players operation #be_m test.buff.work /= #be_100 test.buff.work

scoreboard players operation #be_d0 test.buff.work = #be_r test.buff.work

# v<0: d0は100-r(r=0ならそのまま0)。残りの大きさは符号反転し、rが0でなければさらに1減らす
execute if score #be_s test.buff.work matches -1 unless score #be_r test.buff.work matches 0 run scoreboard players set #be_d0 test.buff.work 100
execute if score #be_s test.buff.work matches -1 unless score #be_r test.buff.work matches 0 run scoreboard players operation #be_d0 test.buff.work -= #be_r test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_m test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 unless score #be_r test.buff.work matches 0 run scoreboard players remove #be_m test.buff.work 1

# 残りの大きさは非負なので、digit1..4は普通の%100・/100で良い
scoreboard players operation #be_d1 test.buff.work = #be_m test.buff.work
scoreboard players operation #be_d1 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_m test.buff.work /= #be_100 test.buff.work

scoreboard players operation #be_d2 test.buff.work = #be_m test.buff.work
scoreboard players operation #be_d2 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_m test.buff.work /= #be_100 test.buff.work

scoreboard players operation #be_d3 test.buff.work = #be_m test.buff.work
scoreboard players operation #be_d3 test.buff.work %= #be_100 test.buff.work
scoreboard players operation #be_m test.buff.work /= #be_100 test.buff.work

scoreboard players operation #be_d4 test.buff.work = #be_m test.buff.work
