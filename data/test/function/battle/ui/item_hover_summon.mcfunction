#> test:battle/ui/item_hover_summon
# @s = 「アイテム」を持っているプレイヤー。持っている消耗品があればトロッコを出して並べ、無ければ actionbar で知らせる。
# トロッコには item_minecart のタグだけを付ける(skill_minecart を付けると test:battle/ui/skill_hover_hide に消される)

execute store result score #item_kinds test.temporary run function test:battle/action/item_list
execute if score #item_kinds test.temporary matches 0 run return run title @s actionbar {text:"使えるアイテムがない",color:"gray"}

execute anchored eyes positioned ^ ^-0.35 ^ run summon chest_minecart ~ ~ ~ {Tags:[item_minecart],NoGravity:1b,Invulnerable:1b}

data modify storage test: registry_work.item_queue set from storage test: battle.temporary.item_slot
scoreboard players set #item_line test.temporary 0
function test:battle/ui/item_minecart_populate_loop
