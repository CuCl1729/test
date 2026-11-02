#> test:gather/migrate
# 1回だけ: 採取ポイントの位置がスプレッドシートの「採取ポイント」タブにあったころの点を、ワールドの記録
# (storage test: gather_world)へ移す。id はそのままなので、復活待ちの状態(gather_state)も引き継ぐ

execute if data storage test: gather_world.migrated run return 0
data modify storage test: gather_world.point.herb_1 set value {type:"herb",x:0,y:0,z:5}
data modify storage test: gather_world.point.herb_2 set value {type:"herb",x:3,y:0,z:5}
data modify storage test: gather_world.point.bush_1 set value {type:"bush",x:6,y:0,z:5}
data modify storage test: gather_world.ids append value {id:"herb_1"}
data modify storage test: gather_world.ids append value {id:"herb_2"}
data modify storage test: gather_world.ids append value {id:"bush_1"}
data modify storage test: gather_world.migrated set value 1b
