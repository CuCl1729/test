#> test:debug/research_knowledge_loop
# debug_work.kt(asset.knowledge_types のコピー)を1件ずつ +10 する

execute unless data storage test: debug_work.kt[0] run return 0
data modify storage test: debug_work.ka set value {el:"",n:10}
data modify storage test: debug_work.ka.el set from storage test: debug_work.kt[0].id
function test:research/knowledge_add with storage test: debug_work.ka
data remove storage test: debug_work.kt[0]
function test:debug/research_knowledge_loop
