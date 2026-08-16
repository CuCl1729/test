#> test:battle/ui/skill_hover_hide
# @s = メインハンドが「スキル」アイテムでなくなったプレイヤー。トロッコを消し、選択待ち状態を解除する
# (チャット式のプレイヤーは常にこの分岐を通るため、カートが無ければ何もしない=状態を巻き戻さない)

execute if entity @e[tag=skill_minecart,distance=..8] run scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0
execute as @e[tag=skill_minecart,distance=..8] run data remove entity @s Items
kill @e[tag=skill_minecart,distance=..8]
