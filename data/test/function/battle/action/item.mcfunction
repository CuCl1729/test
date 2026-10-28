#> test:battle/action/item
# @s = 手番のプレイヤー(チャット式)。持っている消耗品を番号付きで並べ、選んだものを使う(test:battle/ui/item_poll)。
# アイテム式UIは「アイテム」を持つとトロッコが出る(test:battle/ui/item_hover_show)ので、ここは通らない

execute store result score #item_kinds test.temporary run function test:battle/action/item_list
execute if score #item_kinds test.temporary matches 0 run tellraw @s [{text:"使えるアイテムがない",color:gray}]
execute if score #item_kinds test.temporary matches 0 run return run function test:battle/ui/chat

tellraw @s [{text:"使うアイテムを選んでください",color:gold}]
data modify storage test: registry_work.item_queue set from storage test: battle.temporary.item_slot
scoreboard players set #item_line test.temporary 0
function test:battle/action/item_line_loop

scoreboard players set @s test.battle.item_select 0
scoreboard players enable @s test.battle.item_select
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 7
