#> test:battle/ui/skill_hover_show
# @s = メインハンドに「スキル」アイテムを持っているプレイヤー。目線の位置にトロッコを追従させ、
# 選択待ち状態(トロッコ式)にする。右クリックは経由しない

execute unless entity @e[tag=skill_minecart,distance=..3] run function test:battle/ui/skill_hover_summon

execute anchored eyes positioned ^ ^-0.35 ^ run tp @e[tag=skill_minecart,sort=nearest,limit=1] ~ ~ ~

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 2
