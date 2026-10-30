#> test:machine/take_one
# 実行位置の入れ物の最初のスロット(Items[0])を1個減らす(1個だけなら消す)

execute store result score #machine_c test.temporary run data get block ~ ~ ~ Items[0].count
execute if score #machine_c test.temporary matches ..1 run return run data remove block ~ ~ ~ Items[0]
execute store result block ~ ~ ~ Items[0].count int 1 run scoreboard players remove #machine_c test.temporary 1
