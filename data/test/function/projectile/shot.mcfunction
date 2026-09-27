
scoreboard players operation @s test.temporary = @s test.multi_shot
scoreboard players add @s test.temporary 1

scoreboard players operation #angle test.temporary = #12000 test.constant
scoreboard players operation #angle test.temporary /= @s test.temporary

scoreboard players reset @s test.repeat

# tan(#angle)をcomputeで求める(定義はcontext_float_provider/projectile/spread_tan)。
# #dummyはtan×100、storage test: outはtest:projectile/summonが$(out)として使うtanの値
execute store result score #dummy test.temporary run compute default float test:projectile/spread_tan 100
execute store result storage test: out double 0.0001 run compute default float test:projectile/spread_tan 10000

scoreboard players remove @s test.temporary 2
scoreboard players operation @s test.temporary *= #5 test.constant

execute store result storage test: teleport float -0.001 run scoreboard players operation #dummy test.temporary *= @s test.temporary

function test:projectile/pre_summon with storage test:

