#> test:debug/spawn_vein
# @s = プレイヤー。@macro id: 鉱脈のid。足元のブロックの角に、鉱脈のアマスタを置く。
# test:action と test:turn の両方の同じ座標に、1回で置く(2つのマップは地形と座標が同じ)。
# 同じ位置にすでにあるときは、同じ鉱脈ならそのまま、違う鉱脈なら置き換える(test:debug/vein_place)。
# もう片方のマップが読み込まれていないと置けないので、そのときは何もせず [鉱山を読み込む] を出す。
# アマスタの位置が、鉱脈の構造物を置く角になる。鉱山の範囲の中に置くと、その鉱山のリセットで鉱脈が置き直される

$execute unless data storage test: asset.vein.$(id) run return run tellraw @s [{text:"鉱脈「$(id)」はありません",color:gray}]
execute unless dimension test:action unless dimension test:turn run return run tellraw @s [{text:"test:action か test:turn で使う",color:gray}]

function test:debug/vein_at
execute store result score #vein_ok test.temporary run function test:debug/vein_loaded with storage test: debug_work.vein_at
execute if score #vein_ok test.temporary matches 0 run return 0

$data modify storage test: debug_work.vein_at.id set value "$(id)"
data modify storage test: debug_work.vein_at.dim set value "action"
function test:debug/vein_place with storage test: debug_work.vein_at
data modify storage test: debug_work.vein_at.dim set value "turn"
function test:debug/vein_place with storage test: debug_work.vein_at
$tellraw @s [{text:"鉱脈を置いた: $(id)(両マップ)",color:gray}]
