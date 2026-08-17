#> test:battle/ui/attack_hover_hide
# @s = メインハンドが「攻撃」アイテムでなくなったプレイヤー。攻撃用に事前召喚していた対象選択トロッコを消す
# (投射魔法側の対象選択(pending_target_action=2)はここでは巻き込まない。カートが無ければ何もしない=状態を巻き戻さない)

execute if score @s test.battle.pending_target_action matches 1 run scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_target 0
execute if score @s test.battle.pending_target_action matches 1 as @e[tag=target_minecart,distance=..8] run data remove entity @s Items
execute if score @s test.battle.pending_target_action matches 1 run kill @e[tag=target_minecart,distance=..8]
