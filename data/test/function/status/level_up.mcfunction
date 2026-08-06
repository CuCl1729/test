#> test:status/level_up
# @s = 経験値チェック対象のプレイヤー。必要経験値(レベル^2 * 50)を超えていればレベルアップを繰り返す

scoreboard players operation #required test.temporary = @s test.status.level
scoreboard players operation #required test.temporary *= #required test.temporary
scoreboard players operation #required test.temporary *= #50 test.constant

execute store success score #can_level test.temporary if score @s test.status.exp >= #required test.temporary

execute if score #can_level test.temporary matches 1 run scoreboard players operation @s test.status.exp -= #required test.temporary
execute if score #can_level test.temporary matches 1 run scoreboard players add @s test.status.level 1
execute if score #can_level test.temporary matches 1 run scoreboard players add @s test.status.skill_point 1
execute if score #can_level test.temporary matches 1 run function test:status/level_up
