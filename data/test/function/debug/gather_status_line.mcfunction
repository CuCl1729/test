#> test:debug/gather_status_line
# @s = 採取ポイント。@macro point/type/dim: ポイント・採取物・マップ。復活までの秒数(0なら採れる)を出す

scoreboard players set #gather_ready test.temporary 0
$execute store result score #gather_ready test.temporary run data get storage test: gather_state.$(dim).$(point).ready_at
scoreboard players operation #gather_ready test.temporary -= #gather_now test.temporary
scoreboard players set #gather_n test.temporary 20
scoreboard players operation #gather_ready test.temporary /= #gather_n test.temporary
execute if score #gather_ready test.temporary matches ..-1 run scoreboard players set #gather_ready test.temporary 0
$tellraw @a[tag=debug_gather_viewer] [{text:" $(point) ",color:"gold"},{storage:"test:",nbt:"asset.gather.$(type).name",color:"white"},{text:" 復活まで ",color:"gray"},{score:{name:"#gather_ready",objective:"test.temporary"},color:"aqua"},{text:"秒",color:"gray"}]
