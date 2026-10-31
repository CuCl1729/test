#> test:debug/gather_respawn
# @s = プレイヤー。16ブロック以内の採取ポイントを、今すぐ復活させる(見た目は次の1秒の確認で戻る)

execute at @s as @e[type=interaction,tag=gather_point,distance=..16] run function test:debug/gather_respawn_one with entity @s data.gather
tellraw @s {text:"近くの採取ポイントを復活させた",color:"gray"}
