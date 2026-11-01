#> test:craft/custom/reclaim_drop_one
# @s = 取り返す落ちているアイテム。#cc_left 以下なら消し、多ければ数を減らす

tag @s remove cc_reclaim
execute store result score #cc_cn test.temporary run data get entity @s Item.count
execute if score #cc_cn test.temporary <= #cc_left test.temporary run return run function test:craft/custom/reclaim_drop_kill
scoreboard players operation #cc_cn test.temporary -= #cc_left test.temporary
scoreboard players set #cc_left test.temporary 0
execute store result entity @s Item.count int 1 run scoreboard players get #cc_cn test.temporary
