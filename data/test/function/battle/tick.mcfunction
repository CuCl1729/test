#> test:battle/tick
# @s = 戦闘マーカー
# test.battle.awaiting_skill: 0=なし 1=スキルのタイプ選択待ち(チャット式) 2=同(トロッコ式)
#                             3=効果の組み合わせ選択待ち(チャット式) 4=同(トロッコ式)
# test.battle.awaiting_target: 0=なし 1=対象選択待ち(チャット式) 2=同(トロッコ式)
# トロッコ式の実際の検知はトロッコ本体が自分でtickするtest:battle/ui/skill_type_cart_tick /
# skill_effect_cart_tick / target_cart_tickで行う(test:tick参照)。ここでのawaiting_skill/awaiting_targetは
# 他の処理(敵ターン等)を止めるための状態管理としてのみ使う

execute at @s as @a[tag=battle_member,distance=..64] at @s run function test:battle/ui/skill_hover_tick

execute unless score @s test.battle.acting matches 1 run function test:battle/turn_start
execute if score @s test.battle.acting matches 1 if score @s test.battle.awaiting_skill matches 1 run function test:battle/ui/skill_poll
execute if score @s test.battle.acting matches 1 if score @s test.battle.awaiting_skill matches 3 run function test:battle/ui/skill_effect_poll
execute if score @s test.battle.acting matches 1 if score @s test.battle.awaiting_target matches 1 run function test:battle/ui/target_poll
execute if score @s test.battle.acting matches 1 unless score @s test.battle.awaiting_skill matches 1.. unless score @s test.battle.awaiting_target matches 1.. if score @s test.battle.enemy_delay matches 1.. run function test:battle/enemy_delay_tick
execute if score @s test.battle.acting matches 1 unless score @s test.battle.awaiting_skill matches 1.. unless score @s test.battle.awaiting_target matches 1.. unless score @s test.battle.enemy_delay matches 1.. run function test:battle/ui/chat_poll
