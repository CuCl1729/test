#> test:item/gather_tool/give
# @s = 受け取るプレイヤー。@macro id: 採取の道具のid。作って足元に落とす(すぐ拾う。持ち物がいっぱいでも消えない)

scoreboard players set #gather_built test.temporary 0
$execute store result score #gather_built test.temporary run function test:item/gather_tool/build {id:"$(id)"}
execute if score #gather_built test.temporary matches 1 at @s run function test:item/drop_at
