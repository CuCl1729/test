#> test:battle/ui/target_display_target
# @s = 表示対象の敵(1体)。自身のturn_orderをストレージへ控えてから表示行を組み立てる

execute store result storage test: battle.temporary.turn_order int 1 run scoreboard players get @s test.battle.turn_order

function test:battle/ui/target_display_line with storage test: battle.temporary
