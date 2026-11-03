#> test:projectile/on/expire/on_land
# @s = 次の段が「着弾で」の投射体。射程が切れた所で次の段を始め、弾は消える
execute at @s run function test:magic/chain/next
scoreboard players set #event_result test.temporary 2
