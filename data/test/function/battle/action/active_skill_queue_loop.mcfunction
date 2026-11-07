#> test:battle/action/active_skill_queue_loop
# registry_work.active_skill_queue(test.job.skill_orderのコピー)を末尾から取り出しつつ、
# #active_slot test.temporaryを1つずつ進めて番号を振る

execute unless data storage test: registry_work.active_skill_queue[-1] run return 0

data modify storage test: registry_work.active_skill_entry set from storage test: registry_work.active_skill_queue[-1]
data remove storage test: registry_work.active_skill_queue[-1]

# パッシブは番号を振らずに飛ばす(番号と data.turn.active_skill_slot の並びをずらさないため)
execute store result score #job_active test.job.work run function test:job/skill/is_active with storage test: registry_work.active_skill_entry
execute if score #job_active test.job.work matches 1 run scoreboard players add #active_slot test.temporary 1
execute store result storage test: registry_work.active_skill_entry.index int 1 run scoreboard players get #active_slot test.temporary
execute if score #job_active test.job.work matches 1 run function test:battle/action/active_skill_queue_entry with storage test: registry_work.active_skill_entry

function test:battle/action/active_skill_queue_loop
