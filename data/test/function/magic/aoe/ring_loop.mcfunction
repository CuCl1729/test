#> test:magic/aoe/ring_loop
# 半径を1ずつ縮めながら、それぞれの半径でscan/circle/を1回呼ぶ(結果として円盤全体を覆う)
# scan/circle/が1回で円周上の多数の位置を回してくれるため、角度側のループは不要

execute if score #aoe_ring test.temporary matches ..0 run return 0

execute store result storage test: circle.Radius double 1 run scoreboard players get #aoe_ring test.temporary
function test:scan/circle/ with storage test: circle

scoreboard players remove #aoe_ring test.temporary 1
function test:magic/aoe/ring_loop
