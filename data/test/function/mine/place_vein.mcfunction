#> test:mine/place_vein
# @s = 鉱脈のアマスタ(at @s)。@macro vein: 鉱脈のid(アマスタの data.vein)。その鉱脈の構造物を自分の位置に置く

$execute unless data storage test: asset.vein.$(vein) run return run function test:debug/log {msg:"鉱脈のアマスタ: 鉱脈「$(vein)」の定義がありません"}
$function test:mine/place_vein_template with storage test: asset.vein.$(vein)
