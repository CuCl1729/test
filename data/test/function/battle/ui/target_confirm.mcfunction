#> test:battle/ui/target_confirm
# @s = 決定ボタンを押したプレイヤー。@e[tag=battle_target]に選択済みの対象が1体以上いる

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_target 0

execute if score @s test.battle.pending_target_action matches 1 run function test:battle/action/attack_resolve
execute if score @s test.battle.pending_target_action matches 2 run function test:battle/action/skill_cast/projectile_resolve
