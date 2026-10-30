#> test:mine/token/convert
# @s = プレイヤー。持ち物の目印(custom_data.test.ore_token = 鉱脈のid。鉱石ブロックのルートテーブルが落とす)を、
# 鉱脈ごとに原石に変える。test:cache/update が呼ぶ

data modify storage test: mine_work.token_queue set value []
data modify storage test: mine_work.token_queue append from entity @s Inventory[].components."minecraft:custom_data".test.ore_token
function test:mine/token/convert_loop
