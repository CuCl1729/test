#> test:craft/custom/out/station_egg
# @macro id: ステーションのid。test:station/give_egg と同じもの(loot/give の tooltip_display も足す)。loot.item に作る(個数は test:craft/custom/place_out が入れる)

$function test:station/build_egg {id:"$(id)"}
function test:craft/custom/out/loot_style
