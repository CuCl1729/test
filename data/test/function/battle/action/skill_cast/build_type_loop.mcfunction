#> test:battle/action/skill_cast/build_type_loop
# 選択中のタイプについて、クラフト時と同じアセット関数を呼んで魔法を組み立てる

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

function test:battle/action/skill_cast/build_type with storage test: registry_work.type_entry

function test:battle/action/skill_cast/build_type_loop
