#> test:debug/machine_status
# @s = プレイヤー。16ブロック以内の機械の状態(形・燃料の残り・処理中のもの・進み具合)を1台ずつ出す

tag @s add debug_machine_viewer
tellraw @s {text:"― 近くの機械 ―",color:"gold"}
execute store result score #machine_n test.temporary at @s if entity @e[type=armor_stand,tag=machine,distance=..16]
execute if score #machine_n test.temporary matches 0 run tellraw @s {text:" 16ブロック以内に機械がない",color:"gray"}
execute at @s as @e[type=armor_stand,tag=machine,distance=..16,sort=nearest] run function test:debug/machine_status_line
tag @s remove debug_machine_viewer
