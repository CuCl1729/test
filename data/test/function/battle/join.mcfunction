#> test:battle/join
# @s を、最も近くの入り口マーカーの戦闘へ参加させ、対応するエリアへ転送する

execute if entity @s[type=player] unless score @s test.settings.battle_ui matches 1.. run scoreboard players set @s test.settings.battle_ui 2

execute if score @s test.battle.id matches 1.. run return 0

scoreboard players operation @s test.battle.id = @e[tag=battle_entrance,sort=nearest,limit=1] test.battle.id
scoreboard players operation @s test.battle.arena = @e[tag=battle_entrance,sort=nearest,limit=1] test.battle.arena

execute if score @s test.battle.arena matches 1 in test:arena run function test:battle/enter_arena {x:0,y:100,z:0}
execute if score @s test.battle.arena matches 2 in test:arena run function test:battle/enter_arena {x:500,y:100,z:0}
execute if score @s test.battle.arena matches 3 in test:arena run function test:battle/enter_arena {x:1000,y:100,z:0}
execute if score @s test.battle.arena matches 4 in test:arena run function test:battle/enter_arena {x:1500,y:100,z:0}