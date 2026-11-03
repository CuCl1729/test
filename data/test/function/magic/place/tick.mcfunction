#> test:magic/place/tick
# @s = 設置物(test:tick から、at @s)。残る時間が切れた・持ち主がいなければ消える。時間で / 接触で の起動を見る
# (再使用での起動は唱えたとき。test:magic/place/recast)
scoreboard players remove @s test.device.life 1
execute if score @s test.device.life matches ..0 run return run kill @s
tag @a remove device_owner
scoreboard players operation #device_owner test.temporary = @s test.owner
execute as @a if score @s OhMyDatID = #device_owner test.temporary run tag @s add device_owner
execute unless entity @a[tag=device_owner] run return run kill @s

particle minecraft:electric_spark ~ ~0.6 ~ 0.1 0.1 0.1 0 1 normal @a

execute if entity @s[tag=device_timer] run scoreboard players remove @s test.device.timer 1
execute if entity @s[tag=device_timer] if score @s test.device.timer matches ..0 run return run function test:magic/place/fire
execute if entity @s[tag=device_touch] run function test:magic/place/touch with entity @s data
tag @a remove device_owner
