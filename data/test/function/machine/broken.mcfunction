#> test:machine/broken
# @s = 核が無くなった機械のマーカー。機械のエッグをその場に落とし、頭上の表示ごと消える
# (核のブロック自体はルートテーブルで何も落とさない。data/minecraft/loot_table/blocks/<核>.json)

function test:machine/give_egg with entity @s data.machine
tag @s add kill
