#> test:battle/action/skill_category_count
# @s = 手番のプレイヤー。習得済み魔法タイプの有無(#has_magic)と使用可能なアクティブスキルの有無
# (#has_active_skill、剣スキル+解放済み職業スキル)を判定する(どちらもtest.temporaryへ0/1で返す)。
# チャット式・アイテム式どちらの「スキル」メニューからも共通で呼ぶ

function #oh_my_dat:please

scoreboard players set #known_type_count test.temporary 0
data remove storage test: registry_work.only_type
function test:magic/registry/queue_types
function test:battle/action/skill_known_loop

scoreboard players set #has_magic test.temporary 0
execute if score #known_type_count test.temporary matches 1.. run scoreboard players set #has_magic test.temporary 1

scoreboard players set #has_active_skill test.temporary 0
execute if score @s test.battle.weapon_aoe matches 1 run scoreboard players set #has_active_skill test.temporary 1
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order[0] run scoreboard players set #has_active_skill test.temporary 1
