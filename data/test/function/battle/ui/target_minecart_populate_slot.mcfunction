#> test:battle/ui/target_minecart_populate_slot
# @s = 表示対象の敵(1体)。#target_slot test.temporaryが現在の詰め先スロット番号(0始まり、最大7)
# スロットが表す対象のturn_orderをbattle.temporary.target_slotリストへ控えておく
# (取られた時にどの対象かを引けるようにするため)

execute if score #target_slot test.temporary matches 8.. run return 0

data modify storage test: battle.temporary.target_slot append value 0
execute store result storage test: battle.temporary.target_slot[-1] int 1 run scoreboard players get @s test.battle.turn_order

execute store result storage test: battle.temporary.turn_order int 1 run scoreboard players get @s test.battle.turn_order
execute store result storage test: battle.temporary.item_slot int 1 run scoreboard players get #target_slot test.temporary
scoreboard players add #target_slot test.temporary 1

function test:battle/ui/target_minecart_populate_slot_item with storage test: battle.temporary
