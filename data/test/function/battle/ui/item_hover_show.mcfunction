#> test:battle/ui/item_hover_show
# @s = メインハンドに「アイテム」(行動アイテム)を持っているプレイヤー(at @s)。目線の位置にトロッコを追従させ、
# 持っている消耗品を並べる(スキルの test:battle/ui/skill_hover_show と同じ形)。取ると使う(test:battle/ui/item_cart_tick)

execute unless entity @e[tag=item_minecart,distance=..3] run function test:battle/ui/item_hover_summon

execute anchored eyes positioned ^ ^-0.35 ^ run tp @e[tag=item_minecart,sort=nearest,limit=1] ~ ~ ~
