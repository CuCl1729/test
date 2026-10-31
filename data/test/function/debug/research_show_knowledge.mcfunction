#> test:debug/research_show_knowledge
# @s = プレイヤー。debug_work.kt(asset.knowledge_types のコピー)を1件ずつ出す

execute unless data storage test: debug_work.kt[0] run return 0
function test:debug/research_show_knowledge_one with storage test: debug_work.kt[0]
data remove storage test: debug_work.kt[0]
function test:debug/research_show_knowledge
