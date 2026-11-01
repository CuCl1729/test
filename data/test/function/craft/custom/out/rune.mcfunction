#> test:craft/custom/out/rune
# @macro id: ルーンのid。デバッグで配るもの(test:loot/give を通る)と重なるよう、同じ tooltip_display を足す。loot.item に作る(個数は test:craft/custom/place_out が入れる)

$function test:item/rune/build {id:"$(id)"}
function test:craft/custom/out/loot_style
