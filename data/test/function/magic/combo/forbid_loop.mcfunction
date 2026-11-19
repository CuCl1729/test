#> test:magic/combo/forbid_loop
# combo_work.ban を1つずつ見て、1つでも入っていれば #combo_ok を 0 にする
execute unless data storage test: combo_work.ban[0] run return 0

data modify storage test: combo_work.arg.id set from storage test: combo_work.ban[0]
data remove storage test: combo_work.ban[0]
function test:magic/combo/has with storage test: combo_work.arg

execute if score #combo_has test.temporary matches 1 run return run scoreboard players set #combo_ok test.temporary 0
function test:magic/combo/forbid_loop
