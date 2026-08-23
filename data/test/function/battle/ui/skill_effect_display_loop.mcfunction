#> test:battle/ui/skill_effect_display_loop
# @s = 効果選択中のプレイヤー。effect_queueを末尾から取り出し、表示条件を満たす効果だけ1行ずつ出す
# (#effect_indexがその効果のトリガー値。条件を満たさない効果でも番号は進めることで、
#  習得状況や選択中のタイプが変わってもレジストリ内での番号が動かないようにする)

execute unless data storage test: registry_work.effect_queue[-1] run return 0

data modify storage test: registry_work.effect_entry set from storage test: registry_work.effect_queue[-1]
data remove storage test: registry_work.effect_queue[-1]

execute store result storage test: registry_work.effect_entry.index int 1 run scoreboard players get #effect_index test.temporary
function test:battle/ui/skill_effect_visible with storage test: registry_work.effect_entry
execute if score #effect_visible test.temporary matches 1 run function test:battle/ui/skill_effect_display_line with storage test: registry_work.effect_entry

scoreboard players add #effect_index test.temporary 1
function test:battle/ui/skill_effect_display_loop
