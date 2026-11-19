#> test:magic/beam/ray_step
# 実行位置 = 線の上の点。0.5 ブロックずつ進む。壁に入ったら一歩戻った所で終わり、
# 射程を使い切ったらその場で終わり。途中で触れた敵はその場で当てて、さらに進む
execute unless block ~ ~ ~ #minecraft:air run return run function test:magic/beam/wall_end

particle minecraft:electric_spark ~ ~ ~ 0 0 0 0 1 force

# 触れた敵に当てる(貫通)。beam_hit を付けた相手は、この線のこのパルスではもう当てない
execute if score #beam_apply test.temporary matches 1 as @e[type=!player,tag=!projectile,tag=!beam_hit,scores={test.status.hp=1..},dx=-0.5,dy=-0.5,dz=-0.5] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.5,dy=0.5,dz=0.5] run function test:magic/beam/ray_hit

# 武器弾由来のビームなら、旧剣AoEと同じく乱入用マーカーにも貫通中に印を付ける。
# マーカーはダメージ対象ではなく線を止めないので、hitを呼ばずタグだけ付ける
execute if score #beam_apply test.temporary matches 1 if data storage test: magic.player.data.action{kind:"weapon"} as @e[type=!player,tag=!projectile,tag=battle_entrance,tag=!weapon_hit,dx=-0.5,dy=-0.5,dz=-0.5] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.5,dy=0.5,dz=0.5] run tag @s add weapon_hit

scoreboard players add #beam_step test.temporary 1
# 根元の0歩目も1サンプルに数えているので、射程ぶんの最後の点まで来させるには一歩分だけ多く許す必要がある
execute if score #beam_step test.temporary > #beam_len test.temporary run return run function test:magic/beam/ray_end
execute positioned ^ ^ ^0.5 run function test:magic/beam/ray_step
