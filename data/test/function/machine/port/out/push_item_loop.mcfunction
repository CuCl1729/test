#> test:machine/port/out/push_item_loop
# @s = 機械のマーカー。machine_work.push_items(搬出口の中身のコピー)の1スロットずつ、入らなくなるか16個送るまで送る。
# 送った数だけ、搬出口のそのスロットを減らす

execute unless data storage test: machine_work.push_items[0] run return 0
execute if score #push_budget test.temporary matches ..0 run return 0

data modify storage test: machine_work.stack set from storage test: machine_work.push_items[0]
data remove storage test: machine_work.push_items[0]
execute unless data storage test: machine_work.stack.components run data modify storage test: machine_work.stack.components set value {}
execute store result score #stack_left test.temporary run data get storage test: machine_work.stack.count
scoreboard players operation #stack_before test.temporary = #stack_left test.temporary
scoreboard players set #push_full test.temporary 0

function test:machine/port/out/push_into with storage test: machine_work.push
execute unless score #stack_left test.temporary = #stack_before test.temporary run function test:machine/port/out/push_shrink with storage test: machine_work.push

# 送り先が入れ物でないか、いっぱいなら、この搬出口はここまで
execute if score #push_full test.temporary matches 1 run return 0
function test:machine/port/out/push_item_loop
