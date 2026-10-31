#> test:gather/tick_second
# 1秒ごと(test:tick の1秒クロック)。5秒ごとに採取ポイントを置き直し(test:gather/place/all)、
# 毎秒、読み込まれている採取ポイントの見た目を状態(復活待ちか)に合わせる(test:gather/refresh)

scoreboard players add #gather_clock test.time 1
execute if score #gather_clock test.time matches 5.. run function test:gather/place/all
execute store result score #gather_now test.temporary run time query gametime
execute as @e[type=interaction,tag=gather_point] run function test:gather/refresh with entity @s data.gather
