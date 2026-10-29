#> test:battle/ui/active_skill_minecart_populate
# @s = アクティブスキル選択中のプレイヤー(トロッコ式)。使用可能な剣スキル+解放済み職業スキルを
# 1スロット1件で並べ、クリックで即座に発動する(トロッコの27スロットのうち0〜25に並べる。
# 26件を超える分は飛ばす)

tag @n[tag=skill_minecart,tag=!target_minecart,tag=!skill_effect_minecart] add active_skill_minecart

data modify entity @n[tag=active_skill_minecart] Items set value []
data remove storage test: battle.temporary.active_skill_slot

scoreboard players set #active_slot test.temporary 0

execute if score @s test.battle.weapon_aoe matches 1 run function test:battle/ui/active_skill_minecart_populate_sword

function #oh_my_dat:please
data modify storage test: registry_work.active_skill_queue set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order

function test:battle/ui/active_skill_minecart_populate_loop
