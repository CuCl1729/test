#> test:projectile/on/expire/aoe
# @s = 射程が尽きた、範囲タイプと組み合わせた投射体。何にも当たらなくてもその場で爆発して消える

function test:projectile/burst

scoreboard players set #event_result test.temporary 2
