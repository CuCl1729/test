#> test:debug/give_rune
# @s = プレイヤー。@macro id: ルーンのid。作って渡す(loot.context は呼び出し側が "inventory" にしてある)

scoreboard players set #rune_built test.temporary 0
$execute store result score #rune_built test.temporary run function test:item/rune/build {id:"$(id)"}
execute if score #rune_built test.temporary matches 1 run function test:loot/give
