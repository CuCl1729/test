#> test:debug/give_material
# @s = プレイヤー。@macro id: 素材のid。型紙は1個、それ以外は20個、インベントリに直接渡す(test:item/material/give)

$execute if data storage test: asset.material.$(id){role:"pattern"} run return run function test:item/material/give {id:"$(id)",count:1}
$function test:item/material/give {id:"$(id)",count:20}
