#> test:battle/ui/clear_items
# @s = プレイヤー。ターン制の行動UIで配ったアイテムと、トロッコから取ったアイコンを手元からすべて消し、
# 行動選択用のトリガーを閉じる。手番の時間切れ(test:battle/ui/cleanup)と、戦闘中にログアウトして
# 戻ったとき(test:battle/rejoin)に使う。行動アイテムを持ったままだとskill_hover_tickがトロッコを出し直して
# 戦闘マーカーを選択待ちにしてしまうので、必ず消す

clear @s minecraft:iron_sword[custom_data~{test:{battle_action:"attack"}}]
clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]
clear @s minecraft:potion[custom_data~{test:{battle_action:"item"}}]
clear @s minecraft:shield[custom_data~{test:{battle_action:"defend"}}]
clear @s *[custom_data~{test:{active_skill:1b}}]
clear @s *[custom_data~{test:{skill_category:"magic"}}]
clear @s *[custom_data~{test:{skill_category:"active"}}]
clear @s *[custom_data~{test:{skill_choice:"confirm"}}]
clear @s *[custom_data~{test:{skill_effect:"cast"}}]
clear @s *[custom_data~{test:{target_pick:"confirm"}}]

# 効果アイコン(skill_effect:"<効果id>")とタイプアイコン(skill_choice:"<タイプid>")はレジストリを走査して消す
function test:battle/ui/skill_effect_minecart_clear
function test:magic/registry/queue_types
function test:battle/ui/clear_items_type_loop

# 対象アイコン(target_pick:<敵のturn_order>)
scoreboard players set #clear_pick test.temporary 1
function test:battle/ui/clear_items_pick_loop

scoreboard players reset @s test.battle.chat_select
scoreboard players reset @s test.battle.skill_select
scoreboard players reset @s test.battle.skill_effect
scoreboard players reset @s test.battle.skill_category
scoreboard players reset @s test.battle.active_skill_select
scoreboard players reset @s test.battle.target_select
