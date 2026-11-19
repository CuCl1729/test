#> test:magic/beam/aim_loop
# 狙いを付けた向きのまま、本数ぶん1本ずつ出す
function test:magic/beam/spawn
scoreboard players add #beam_index test.temporary 1
execute if score #beam_index test.temporary < #beam_count test.temporary run function test:magic/beam/aim_loop
