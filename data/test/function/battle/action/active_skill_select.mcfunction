#> test:battle/action/active_skill_select
# @s = 詠唱者(チャット式)。使用可能な剣スキル+解放済み職業スキルを番号付きで一覧し、選んだものを
# 即座に発動する(魔法のタイプ/効果選択と違い組み合わせを作らないため、トグルではなく単発選択)

data remove storage test: battle.temporary.active_skill_slot

tellraw @s [{text:"使うスキルを選んでください",color:gold}]

execute if score @s test.battle.weapon_aoe matches 1 run function test:battle/action/active_skill_select_sword

function #oh_my_dat:please
data modify storage test: registry_work.active_skill_queue set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order

scoreboard players set #active_slot test.temporary 0
execute if score @s test.battle.weapon_aoe matches 1 run scoreboard players set #active_slot test.temporary 1

function test:battle/action/active_skill_queue_loop

scoreboard players set @s test.battle.active_skill_select 0
scoreboard players enable @s test.battle.active_skill_select
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 6
