#> test:gather/egg/add
# @s = 置いたプレイヤー。@macro n/type/x/y/z: 新しいポイントの番号・採取物・ブロックの座標。記録に足して、両マップに置く
$data modify storage test: gather_world.point.p$(n) set value {type:"$(type)",x:$(x),y:$(y),z:$(z)}
$data modify storage test: gather_world.ids append value {id:"p$(n)"}
$function test:gather/place/point {id:"p$(n)"}
$tellraw @s [{text:"採取ポイントを置いた: ",color:"gray"},{storage:"test:",nbt:"asset.gather.$(type).name",interpret:true,color:"white"},{text:" (p$(n))",color:"dark_gray"}]
