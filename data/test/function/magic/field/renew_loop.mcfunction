#> test:magic/field/renew_loop
# @s = 場の中に居続けている者。この場が掛けたバフを1件ずつ見て、切れていたら掛け直す
execute unless data storage test: field_work.renew[0] run return 0

data modify storage test: field_work.renew_one set from storage test: field_work.renew[0]
data remove storage test: field_work.renew[0]
function test:magic/field/renew_one with storage test: field_work.renew_one

function test:magic/field/renew_loop
