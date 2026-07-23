scoreboard players reset @s test.temporary
scoreboard players operation @s test.temporary = @s test.slotnumber

execute unless score @s test.slotnumber matches -2147483648..2147483647 store result score @s test.temporary run data get entity @s SelectedItemSlot 1

execute store result score @s test.slotnumber run data get entity @s SelectedItemSlot 1

scoreboard players operation @s test.temporary -= @s test.slotnumber
execute unless score @s test.temporary matches 0 run function test:cache/mainhand
