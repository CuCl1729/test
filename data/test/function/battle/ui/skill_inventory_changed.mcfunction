#> test:battle/ui/skill_inventory_changed
# @s = インベントリが変化したプレイヤー。トロッコから魔法アイテムを取っていないか即座に確認する

execute as @e[tag=battle_marker,distance=..64] run function test:battle/ui/skill_minecart_poll

advancement revoke @s only test:battle/skill_pick
