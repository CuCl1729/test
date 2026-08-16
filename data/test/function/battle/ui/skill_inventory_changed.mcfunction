#> test:battle/ui/skill_inventory_changed
# @s = インベントリが変化したプレイヤー。トロッコから魔法アイテムを取っていないか即座に確認する

execute as @e[tag=skill_minecart,tag=!skill_effect_minecart,distance=..3] at @s run function test:battle/ui/skill_type_cart_tick
execute as @e[tag=skill_effect_minecart,distance=..3] at @s run function test:battle/ui/skill_effect_cart_tick

advancement revoke @s only test:battle/skill_pick
