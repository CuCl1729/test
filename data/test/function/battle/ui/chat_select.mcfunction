#> test:battle/ui/chat_select
# @s = チャットUIで行動を選択したプレイヤー

scoreboard players operation #chat_select test.battle.chat_select = @s test.battle.chat_select
scoreboard players set @s test.battle.chat_select 0

execute if score #chat_select test.battle.chat_select matches 1 run function test:battle/action/attack
execute if score #chat_select test.battle.chat_select matches 2 run function test:battle/action/skill
execute if score #chat_select test.battle.chat_select matches 3 run function test:battle/action/item
execute if score #chat_select test.battle.chat_select matches 4 run function test:battle/action/defend
