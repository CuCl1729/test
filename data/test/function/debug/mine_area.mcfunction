#> test:debug/mine_area
# @macro id: 鉱山のid。debug_work.mine_area = {id, x1, y1, z1, dx, dy, dz, x2, z2} にする(x2/z2 は反対側の角)

$data modify storage test: debug_work.mine_area set from storage test: asset.mine.$(id).area
$data modify storage test: debug_work.mine_area.id set value "$(id)"
execute store result score #mine_a test.temporary run data get storage test: debug_work.mine_area.x1
execute store result score #mine_d test.temporary run data get storage test: debug_work.mine_area.dx
execute store result storage test: debug_work.mine_area.x2 int 1 run scoreboard players operation #mine_a test.temporary += #mine_d test.temporary
execute store result score #mine_a test.temporary run data get storage test: debug_work.mine_area.z1
execute store result score #mine_d test.temporary run data get storage test: debug_work.mine_area.dz
execute store result storage test: debug_work.mine_area.z2 int 1 run scoreboard players operation #mine_a test.temporary += #mine_d test.temporary
