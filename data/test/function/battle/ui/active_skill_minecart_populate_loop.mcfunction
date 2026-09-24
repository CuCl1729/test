#> test:battle/ui/active_skill_minecart_populate_loop
# registry_work.active_skill_queue(test.job.skill_orderのコピー)を末尾から取り出しつつ詰める

execute unless data storage test: registry_work.active_skill_queue[-1] run return 0

data modify storage test: registry_work.active_skill_entry set from storage test: registry_work.active_skill_queue[-1]
data remove storage test: registry_work.active_skill_queue[-1]

function test:battle/ui/active_skill_minecart_populate_slot with storage test: registry_work.active_skill_entry

function test:battle/ui/active_skill_minecart_populate_loop
