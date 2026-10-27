#> test:craft/equip_magic/return_rune
# @s = 付与台マーカー。@macro id: 返すルーンのid。今の定義(asset.rune.<id>)で作り直して渡す。
# 定義が見つからない(スプレッドシートから消したなど)ときは返せないので、近くのプレイヤーとデバッグログに知らせる

scoreboard players set #rune_built test.temporary 0
$execute store result score #rune_built test.temporary run function test:item/rune/build {id:"$(id)"}

execute if score #rune_built test.temporary matches 1 run function test:loot/give
$execute if score #rune_built test.temporary matches 0 run tellraw @a[distance=..6] {text:"外したルーン「$(id)」は定義が見つからないため返せませんでした",color:"red"}
$execute if score #rune_built test.temporary matches 0 run function test:debug/log {msg:"強化台(付与): 定義の無いルーンは返せません: $(id)"}
