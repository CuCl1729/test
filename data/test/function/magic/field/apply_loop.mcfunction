#> test:magic/field/apply_loop
# @s = 場に入った者。この場が掛けるバフを1件ずつ処理する
execute unless data storage test: field_work.apply_queue[0] run return 0

data modify storage test: field_work.pending_one set from storage test: field_work.apply_queue[0]
data remove storage test: field_work.apply_queue[0]
function test:magic/field/apply_one with storage test: field_work.pending_one

function test:magic/field/apply_loop
