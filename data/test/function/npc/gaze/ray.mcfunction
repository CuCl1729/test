#> test:npc/gaze/ray
# @s = プレイヤー。実行位置 = 視線の上の点。当たり判定がこの点を含む店員・銀行員のインタラクションに tag=npc_gaze を付けて止める。
# 当たらなければ 0.1 進める(#gz_ray 回まで)。研究の観測鏡の test:research/scan/ray と同じやり方(対象を店員・銀行員だけにしたもの)

execute positioned ~-0.99 ~-0.99 ~-0.99 as @e[type=interaction,tag=npc_counter,dx=0] positioned ~0.99 ~0.99 ~0.99 if entity @s[dx=0] run tag @s add npc_gaze
execute if entity @e[type=interaction,tag=npc_gaze,limit=1] run return 1
scoreboard players remove #gz_ray test.temporary 1
execute if score #gz_ray test.temporary matches 1.. positioned ^ ^ ^0.1 run function test:npc/gaze/ray
