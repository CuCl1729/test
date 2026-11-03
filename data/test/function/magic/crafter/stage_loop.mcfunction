#> test:magic/crafter/stage_loop
# @s = クラフター本体。組み立て列(registry_work.stage_seq を末尾から取ると元の順)を前から1つずつ読み、
# つなぎなら今の段を閉じて次の段を始め(test:magic/crafter/stage_link)、それ以外は今の段に積む
execute unless data storage test: registry_work.stage_seq[-1] run return 0
data modify storage test: registry_work.stage_id set from storage test: registry_work.stage_seq[-1]
data remove storage test: registry_work.stage_seq[-1]
function test:magic/crafter/stage_step with storage test: registry_work
function test:magic/crafter/stage_loop
