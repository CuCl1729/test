#> test:machine/by/hit
# @macro material/count: 当たった副産物の素材と個数(ほかのキーも渡ってくるが使わない)。出すもの(machine_work.drop)に足す

$scoreboard players set #machine_give_count test.temporary $(count)
$function test:machine/give_material {id:"$(material)"}
