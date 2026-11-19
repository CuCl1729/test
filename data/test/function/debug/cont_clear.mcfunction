#> test:debug/cont_clear
# @s = 実行したプレイヤー。出ている持続物(自動ビーム・場・自己持続・一定間隔の発生源)を全部消す。
# 場は掛けたバフも外してから消える(test:magic/field/end)
execute as @e[type=armor_stand,tag=magic_field] at @s run function test:magic/field/end
kill @e[type=armor_stand,tag=magic_beam]
kill @e[type=armor_stand,tag=magic_sustain]
kill @e[type=armor_stand,tag=magic_emitter]
scoreboard players set @a test.magic.beam 0
tellraw @s {text:"[DEBUG] 持続物を消しました",color:gray}
