#> test:battle/zone/example
# 対応範囲: チャンクX -2〜2, Z -2〜2 (仮の例)

execute if score #chunk_x test.temporary matches -2..2 if score #chunk_z test.temporary matches -2..2 run data modify storage test: battle.temporary.structure set value "test:arena_example"
execute if score #chunk_x test.temporary matches -2..2 if score #chunk_z test.temporary matches -2..2 run function test:battle/place_zone with storage test: battle.temporary