#> test:npc/cart/act/deposit_all
# @s = [全部預ける] を取ったプレイヤー。持ち物の中のコインを全部、口座に入れる

execute store result score #dc test.temporary run function test:money/coins
execute if score #dc test.temporary matches 0 run return run tellraw @s {text:"コインを持っていない",color:"gray"}
clear @s *[minecraft:custom_data~{test:{coin:1}}]
clear @s *[minecraft:custom_data~{test:{coin:10}}]
clear @s *[minecraft:custom_data~{test:{coin:100}}]
execute store result storage test: money_work.n int 1 run scoreboard players get #dc test.temporary
function test:money/add with storage test: money_work
