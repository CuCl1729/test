#> test:machine/broken
# @s = 核が無くなった機械のマーカー。機械のエッグと、処理中の原石があればそれも、その場に落とし、頭上の表示ごと消える
# (核のブロック自体はルートテーブルで何も落とさない。data/minecraft/loot_table/blocks/<核>.json)

function test:machine/give_egg with entity @s data.machine
execute if data entity @s data.machine.processing run data modify storage test: loot.item set from entity @s data.machine.processing
execute if data entity @s data.machine.processing run function test:item/drop_at
tag @s add kill
