#> test:craft/custom/out/consumable
# @macro id: 消耗品のid。デバッグで配るものと重なるよう、test:loot/give と同じ tooltip_display を足す。loot.item に作る(個数は test:craft/custom/place_out が入れる)

$function test:item/consumable/build {id:"$(id)"}
function test:craft/custom/out/loot_style
