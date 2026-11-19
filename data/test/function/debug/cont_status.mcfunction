#> test:debug/cont_status
# @s = 実行したプレイヤー(at @s)。近く(64ブロック)の持続物の状態を出す。
# 残る時間・次のパルスまでの tick・持ち主の番号を見られるようにして、
# 「止まっているのか消えたのか」「乗っている元が消えて取り残されたのか」を切り分ける
#
# 1行ずつ出すのは持続物を as にした実行なので、出す相手(自分)には一時タグで印を付けておく
tag @s add debug_cont_view

tellraw @s ""
tellraw @s {text:"― 近くの持続物 ―",color:gold}

execute as @a[scores={test.magic.beam=1},distance=..64] run tellraw @a[tag=debug_cont_view] [{text:"ビーム(手持ち) ",color:aqua},{selector:"@s"},{text:" 次のパルス ",color:gray},{score:{name:"@s",objective:"test.device.timer"},color:white},{text:" 端数MP ",color:gray},{score:{name:"@s",objective:"test.magic.mp_frac"},color:white}]
execute as @e[type=armor_stand,tag=magic_beam,distance=..64] run tellraw @a[tag=debug_cont_view] [{text:"自動ビーム ",color:aqua},{text:"残り ",color:gray},{score:{name:"@s",objective:"test.device.life"},color:white},{text:" 次 ",color:gray},{score:{name:"@s",objective:"test.device.timer"},color:white},{text:" 持ち主 ",color:gray},{score:{name:"@s",objective:"test.owner"},color:white}]
execute as @e[type=armor_stand,tag=magic_field,distance=..64] run function test:debug/cont_status_field
execute as @e[type=armor_stand,tag=magic_sustain,distance=..64] run tellraw @a[tag=debug_cont_view] [{text:"自己持続 ",color:aqua},{text:"残り ",color:gray},{score:{name:"@s",objective:"test.device.life"},color:white},{text:" 持ち主 ",color:gray},{score:{name:"@s",objective:"test.owner"},color:white}]
execute as @e[type=armor_stand,tag=magic_emitter,distance=..64] run tellraw @a[tag=debug_cont_view] [{text:"一定間隔の発生源 ",color:aqua},{text:"次 ",color:gray},{score:{name:"@s",objective:"test.device.timer"},color:white},{text:" 残り回数 ",color:gray},{score:{name:"@s",objective:"test.periodic.count"},color:white}]
execute as @e[type=armor_stand,tag=magic_device,distance=..64] run tellraw @a[tag=debug_cont_view] [{text:"設置物 ",color:aqua},{text:"残り ",color:gray},{score:{name:"@s",objective:"test.device.life"},color:white},{text:" 次 ",color:gray},{score:{name:"@s",objective:"test.device.timer"},color:white},{text:" 残り回数 ",color:gray},{score:{name:"@s",objective:"test.periodic.count"},color:white}]

tag @s remove debug_cont_view
