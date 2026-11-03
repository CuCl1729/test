#> test:magic/place/fire
# @s = 起動した設置物。実行位置 = 設置物。その位置で次の段を始め(test:magic/chain/next)、設置物は消える
execute at @s run function test:magic/chain/next
kill @s
