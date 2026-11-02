#> test:debug/spawn_vein
# @s = プレイヤー。@macro id: 鉱脈のid。足元のブロックの角に、鉱脈のアマスタを置く(test:debug/vein_put)。
# エッグで置くときは test:mine/egg/place が、エッグを使った位置で同じことをする

$execute unless data storage test: asset.vein.$(id) run return run tellraw @s [{text:"鉱脈「$(id)」はありません",color:gray}]
function test:debug/vein_at
$function test:debug/vein_put {id:"$(id)"}
