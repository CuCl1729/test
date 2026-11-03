#> test:magic/place/cast
# @s = 詠唱者(1段目が設置の魔法)。視線の先5ブロック以内で最初に当たるブロックの手前に置く。当たらなければ足元に置く
scoreboard players set #place_found test.temporary 0
scoreboard players set #place_step test.temporary 0
execute at @s anchored eyes positioned ^ ^ ^ run function test:magic/place/ray
execute if score #place_found test.temporary matches 0 at @s run function test:magic/place/put
