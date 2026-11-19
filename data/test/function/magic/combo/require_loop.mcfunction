#> test:magic/combo/require_loop
# combo_work.need を1つずつ見て、1つでも欠けていれば #combo_ok を 0 にする
execute unless data storage test: combo_work.need[0] run return 0

data modify storage test: combo_work.arg.id set from storage test: combo_work.need[0]
data remove storage test: combo_work.need[0]
function test:magic/combo/has with storage test: combo_work.arg

execute if score #combo_has test.temporary matches 0 run return run scoreboard players set #combo_ok test.temporary 0
function test:magic/combo/require_loop
