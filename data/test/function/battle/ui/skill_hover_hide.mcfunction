#> test:battle/ui/skill_hover_hide
# @s = メインハンドが「スキル」アイテムでなくなったプレイヤー。トロッコを消し、選択待ち状態を解除する

execute as @e[tag=skill_minecart,distance=..8] run data remove entity @s Items
kill @e[tag=skill_minecart,distance=..8]
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0
