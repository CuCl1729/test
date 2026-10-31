#> test:gather/used
# @macro point/type/dim: 採ったポイント(ほかのキーも渡ってくるが使わない)。復活の時刻 = 今 + 復活時間(秒) × 20 を記録する

$execute store result score #gather_wait test.temporary run data get storage test: asset.gather.$(type).respawn 20
scoreboard players operation #gather_wait test.temporary += #gather_now test.temporary
$execute store result storage test: gather_state.$(dim).$(point).ready_at int 1 run scoreboard players get #gather_wait test.temporary
