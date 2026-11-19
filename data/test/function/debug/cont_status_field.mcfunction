#> test:debug/cont_status_field
# @s = 近くの場。残り時間と、どこに付いているか(乗っている元が消えて取り残された状態かどうか)を出す。
# 出す相手は debug_cont_view タグの付いたプレイヤー(test:debug/cont_status が付けている)
execute if entity @s[tag=field_parented] run tellraw @a[tag=debug_cont_view] [{text:"場(元に乗っている) ",color:aqua},{text:"残り ",color:gray},{score:{name:"@s",objective:"test.device.life"},color:white}]
execute if entity @s[tag=field_follow_owner] run tellraw @a[tag=debug_cont_view] [{text:"場(持ち主について動く) ",color:aqua},{text:"残り ",color:gray},{score:{name:"@s",objective:"test.device.life"},color:white}]
execute unless entity @s[tag=field_parented] unless entity @s[tag=field_follow_owner] run tellraw @a[tag=debug_cont_view] [{text:"場(その場に残っている) ",color:aqua},{text:"残り ",color:gray},{score:{name:"@s",objective:"test.device.life"},color:white}]
