#> test:magic/dash/spawn
# @s = 詠唱者(プレイヤー)。#dash_owner / #dash_dx / #dash_dz test.temporary = test:magic/dash/start
# と .../vector が残した今回のベクトル。
# 同じ次元に、自分が持ち主で・まだ ready していない代理が既にいれば(同じgametimeで生まれた
# = 同じtickの重ね掛け)そこへベクトルを合成する。無ければ新しく代理を生む。
# 既に ready(ネイティブimpulseが解決済み)な古い代理が残っていたら、新しい組を始める前に
# 先に降ろして始末する(プレイヤーの視点はtick側が ~ ~ のteleportで変えないので壊れない)。
execute store result score #dash_now test.temporary run time query gametime

execute as @e[type=mannequin,tag=magic_dash_proxy,distance=0..] if score @s test.owner = #dash_owner test.temporary if score @s test.dash.ready matches 1 at @s run function test:magic/dash/tick

execute as @e[type=mannequin,tag=magic_dash_proxy,distance=0..] if score @s test.owner = #dash_owner test.temporary if score @s test.dash.birth = #dash_now test.temporary if score @s test.dash.ready matches 0 run tag @s add dash_join
execute store success score #dash_joined test.temporary if entity @e[tag=dash_join]

execute if score #dash_joined test.temporary matches 1 as @e[tag=dash_join] run scoreboard players operation @s test.impulse.x += #dash_dx test.temporary
execute if score #dash_joined test.temporary matches 1 as @e[tag=dash_join] run scoreboard players operation @s test.impulse.z += #dash_dz test.temporary
tag @e[tag=dash_join] remove dash_join

execute unless score #dash_joined test.temporary matches 1 at @s rotated 0 0 summon mannequin run function test:magic/dash/spawn_new
