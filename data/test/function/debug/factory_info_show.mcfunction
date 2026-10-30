#> test:debug/factory_info_show
# @s = プレイヤー。@macro n/x0/z0/x1/z1/floor/ceil: 区画(factory_work.plot。ほかのキーも渡ってくるが使わない)

scoreboard players set #fi_built test.temporary 0
$execute if data storage test: factory_state.built.p$(n) run scoreboard players set #fi_built test.temporary 1
scoreboard players set #fi_forced test.temporary 0
$execute in test:factory store success score #fi_forced test.temporary run forceload query $(x0) $(z0)
$tellraw @s [{text:"工場の区画 $(n): ",color:"gold"},{text:"$(x0) $(floor) $(z0) 〜 $(x1) $(ceil) $(z1)",color:"aqua"}]
tellraw @s [{text:" 作り終えた:",color:"gray"},{score:{name:"#fi_built",objective:"test.temporary"},color:"aqua"},{text:" forceload:",color:"gray"},{score:{name:"#fi_forced",objective:"test.temporary"},color:"aqua"},{text:" (1 = はい)",color:"dark_gray"}]
