#> test:battle/start
# @s = 戦闘のきっかけとなったエンティティ(ターン制マップ側)

function test:debug/log {msg:"battle start"}

execute if score @s test.battle.id matches 1.. run return 0

scoreboard players add #battle test.battle.next_id 1

execute if score #arena_1 test.arena.occupied matches 0 run return run function test:battle/setup {arena:1,x:0,y:100,z:0}
execute if score #arena_2 test.arena.occupied matches 0 run return run function test:battle/setup {arena:2,x:500,y:100,z:0}
execute if score #arena_3 test.arena.occupied matches 0 run return run function test:battle/setup {arena:3,x:1000,y:100,z:0}
execute if score #arena_4 test.arena.occupied matches 0 run return run function test:battle/setup {arena:4,x:1500,y:100,z:0}