#> test:craft/custom/out/machine_part
# @macro id: 機械の部品のid(casing_<筐体> / port_in / port_out)。loot.item に作る(個数は test:craft/custom/place_out が入れる)

$function test:item/machine/build {id:"$(id)"}
