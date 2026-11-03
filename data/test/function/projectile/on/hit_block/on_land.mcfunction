#> test:projectile/on/hit_block/on_land
# @s = 次の段が「着弾で」の投射体。壁や地面に当たった所で次の段を始め、弾は消える(範囲と組んでいれば、その爆発は aoe 側が先に起こす)
execute at @s run function test:magic/chain/next
scoreboard players set #event_result test.temporary 2
