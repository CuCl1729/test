#> test:money/give_kind
# @s = プレイヤー。@macro value: コインの値。#gk 枚を、64枚ずつ足元に落とす

execute unless score #gk test.temporary matches 1.. run return 0
scoreboard players operation #gc test.temporary = #gk test.temporary
execute if score #gc test.temporary > #64 test.constant run scoreboard players operation #gc test.temporary = #64 test.constant
$function test:item/coin/build {value:$(value)}
execute store result storage test: loot.item.count int 1 run scoreboard players get #gc test.temporary
execute at @s run function test:item/drop_at
scoreboard players operation #gk test.temporary -= #gc test.temporary
$function test:money/give_kind {value:$(value)}
