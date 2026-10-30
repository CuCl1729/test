#> test:machine/ghost/place
# @s = 機械のマーカー(実行位置は核の中心)。@macro x/y/z/block: 核からのずれと、見せる筐体のブロック。
# その位置(ブロックの角)にゴーストが無ければ置く。0.6倍に縮めて中心に寄せ、光らせる(26.3 の block_state は {id:…} の形)

$execute positioned ~$(x) ~$(y) ~$(z) align xyz if entity @e[type=block_display,tag=machine_ghost,distance=..0.1] run return run tag @e[type=block_display,tag=machine_ghost,distance=..0.1] remove machine_ghost_stale
$execute positioned ~$(x) ~$(y) ~$(z) align xyz run summon block_display ~ ~ ~ {Tags:["machine_ghost","machine_ghost_new"],block_state:{id:"$(block)"},Glowing:1b,brightness:{sky:15,block:15},transformation:{translation:[0.2f,0.2f,0.2f],scale:[0.6f,0.6f,0.6f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
scoreboard players operation @e[type=block_display,tag=machine_ghost_new] test.machine.id = #machine_owner test.temporary
tag @e[type=block_display,tag=machine_ghost_new] remove machine_ghost_new
