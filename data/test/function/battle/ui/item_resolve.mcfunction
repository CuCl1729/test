#> test:battle/ui/item_resolve
# @s = アイテムを選んだプレイヤー(チャット式)。選んだ番号(1から)を battle.temporary.item_slot の位置(0から)にして使う

scoreboard players operation #item_index test.temporary = @s test.battle.item_select
scoreboard players set @s test.battle.item_select 0
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0
scoreboard players remove #item_index test.temporary 1

data modify storage test: registry_work.item_pick set value {index:0}
execute store result storage test: registry_work.item_pick.index int 1 run scoreboard players get #item_index test.temporary
function test:battle/ui/item_pick with storage test: registry_work.item_pick
