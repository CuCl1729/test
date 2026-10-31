#> test:research/knowledge_add_loop
# research_work.kq([{el, n}])を1件ずつ、oh_my_dat が指すプレイヤーの知識に足す

execute unless data storage test: research_work.kq[0] run return 0
function test:research/knowledge_add with storage test: research_work.kq[0]
data remove storage test: research_work.kq[0]
function test:research/knowledge_add_loop
