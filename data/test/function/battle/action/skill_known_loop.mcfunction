#> test:battle/action/skill_known_loop
# @s = 詠唱者。習得済みのタイプ数を数え、1つだけの場合に備えてそのidも控える

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

function test:battle/action/skill_known_entry with storage test: registry_work.type_entry

function test:battle/action/skill_known_loop
