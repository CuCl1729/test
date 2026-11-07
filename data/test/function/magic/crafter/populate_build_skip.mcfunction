#> test:magic/crafter/populate_build_skip
# registry_work.build_render_queue の先頭から #b_skip 件を捨てる(中段のページ送り)
execute unless score #b_skip test.buff.work matches 1.. run return 0
execute unless data storage test: registry_work.build_render_queue[0] run return 0
data remove storage test: registry_work.build_render_queue[0]
scoreboard players remove #b_skip test.buff.work 1
function test:magic/crafter/populate_build_skip
