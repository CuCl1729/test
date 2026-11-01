#> test:npc/cart/bank/coin
# 預ける枠に置かれたコイン(cart_work.it)の値×枚数を #bd に足す

execute store result score #bv test.temporary run data get storage test: cart_work.it.components."minecraft:custom_data".test.coin
execute store result score #bc test.temporary run data get storage test: cart_work.it.count
scoreboard players operation #bv test.temporary *= #bc test.temporary
scoreboard players operation #bd test.temporary += #bv test.temporary
