#> test:gather/take
# @s = 採るプレイヤー。対象は tag=gather_target の採取ポイント。
# 1. 復活待ちなら「まだ採れない」と出して終える
# 2. 手に持っている道具のランクを決める(その採取物の道具の種類なら、そのランク。それ以外は0)
# 3. 中身の行を1行ずつ抽選する(test:gather/drop/loop)
# 4. 何も当たらなくても採った扱いにし、復活の時刻を決めて、見た目を採った後のものに変える

data modify storage test: gather_work.t set from entity @n[type=interaction,tag=gather_target] data.gather
execute store result score #gather_now test.temporary run time query gametime
scoreboard players set #gather_ready test.temporary 0
function test:gather/ready_at with storage test: gather_work.t
execute if score #gather_ready test.temporary > #gather_now test.temporary run return run tellraw @s {text:"まだ採れない",color:"gray"}

scoreboard players set #gather_rank test.temporary 0
function test:gather/rank with storage test: gather_work.t
function test:gather/drop/start with storage test: gather_work.t
function test:gather/used with storage test: gather_work.t

execute as @n[type=interaction,tag=gather_target] run tag @s add gather_used
execute as @n[type=interaction,tag=gather_target] run function test:gather/look_after_of with entity @s data.gather
execute at @n[type=interaction,tag=gather_target] run playsound minecraft:block.grass.break block @a ~ ~0.5 ~ 1 1
execute at @n[type=interaction,tag=gather_target] run particle minecraft:happy_villager ~ ~0.5 ~ 0.3 0.3 0.3 0 8
