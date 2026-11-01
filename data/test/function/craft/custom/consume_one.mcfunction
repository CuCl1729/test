#> test:craft/custom/consume_one
# 実行位置 = 樽。@macro slot/i: 材料の枠のスロットと、9マスの何番目か。need[i] 個減らし、0になったら消す

$execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[$(i)]
execute if score #cc_nd test.temporary matches ..0 run return 0
$execute store result score #cc_cn test.temporary run data get block ~ ~ ~ Items[{Slot:$(slot)b}].count
scoreboard players operation #cc_cn test.temporary -= #cc_nd test.temporary
$execute if score #cc_cn test.temporary matches ..0 run return run data remove block ~ ~ ~ Items[{Slot:$(slot)b}]
$execute store result block ~ ~ ~ Items[{Slot:$(slot)b}].count int 1 run scoreboard players get #cc_cn test.temporary
