#> test:projectile/on/hit_entity/on_land
# @s = 次の段が「着弾で」の投射体。触れた対象には、ふつうの弾と同じく効果を当ててから(範囲と組んでいれば aoe 側の爆発にまかせる)、
# その場で次の段を始め、弾は消える(既定の処理は「当てて残る」なので、ここで当てて消す)
execute unless entity @s[tag=aoe] run function test:projectile/prepare_buff
execute unless entity @s[tag=aoe] as @e[type=!player,tag=!projectile,scores={test.status.hp=1..},dx=-0.25,dy=-0.25,dz=-0.25] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.25,dy=0.25,dz=0.25] run function test:magic/hit
execute at @s run function test:magic/chain/next
scoreboard players set #event_result test.temporary 2
