#> test:magic/dash/tick
# @s = ダッシュ代理(mannequin, tag=magic_dash_proxy)。at @s で呼ぶこと。
# 持ち主がまだ使える状態(同じ次元・ダウンしておらず・HP1以上・ターン制の戦闘外)かを、
# 共用の magic_owner タグは使わずに専用の magic_dash_owner タグで確かめる。
# 使えない状態なら即始末。使える状態でも、ネイティブimpulseがそのtickで解決した
# (test.dash.ready=1、test:magic/dash_ack が立てる)まではここでは何もしない。
tag @a remove magic_dash_owner
scoreboard players operation #dash_owner test.temporary = @s test.owner
execute as @a[distance=0..,tag=!downed,scores={test.status.hp=1..}] if score @s OhMyDatID = #dash_owner test.temporary run tag @s add magic_dash_owner
execute if entity @a[tag=magic_dash_owner,scores={test.battle.id=1..}] run tag @a remove magic_dash_owner

execute unless entity @a[tag=magic_dash_owner] run return run function test:magic/dash/discard
execute unless score @s test.dash.ready matches 1 run tag @a[tag=magic_dash_owner] remove magic_dash_owner
execute unless score @s test.dash.ready matches 1 run return 0

data remove storage test: dash_work
data modify storage test: dash_work.x set from entity @s Pos[0]
data modify storage test: dash_work.y set from entity @s Pos[1]
data modify storage test: dash_work.z set from entity @s Pos[2]
execute as @a[tag=magic_dash_owner] at @s run function test:magic/dash/land with storage test: dash_work

function test:magic/dash/discard
