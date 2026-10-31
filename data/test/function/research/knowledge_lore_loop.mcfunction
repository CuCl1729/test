#> test:research/knowledge_lore_loop
# research_work.kt(asset.knowledge_types のコピー)を1件ずつ、「火 12」の行にする

execute unless data storage test: research_work.kt[0] run return 0
data modify storage test: research_work.kh set value {el:"",label:""}
data modify storage test: research_work.kh.el set from storage test: research_work.kt[0].id
data modify storage test: research_work.kh.label set from storage test: research_work.kt[0].label
function test:research/eval_know_have with storage test: research_work.kh
function test:research/knowledge_lore_line with storage test: research_work.kh
data remove storage test: research_work.kt[0]
function test:research/knowledge_lore_loop
