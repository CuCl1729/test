#> test:craft/custom/out/machine_egg
# @macro id: 機械のid。test:machine/give_egg と同じもの(loot/give の tooltip_display も足す)。loot.item に作る(個数は test:craft/custom/place_out が入れる)

$function test:machine/build_egg {id:"$(id)"}
function test:craft/custom/out/loot_style
