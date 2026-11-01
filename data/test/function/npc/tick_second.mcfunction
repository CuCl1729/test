#> test:npc/tick_second
# 毎秒(test:tick の1秒クロックから)。5秒ごとに NPC を置き直す(test:npc/place/all)

scoreboard players add #npc_clock test.time 1
execute if score #npc_clock test.time matches 5.. run function test:npc/place/all
