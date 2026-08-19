#> test:scan/aoe/check
# @macro width: この歩でのdx/dz半幅(ブロック、double)。ray_cast/のヒットボックス判定と同じ形

$execute as @e[type=!player,tag=!hit,dx=-$(width),dy=-0.1,dz=-$(width)] positioned ~-1 ~-1 ~-1 if entity @s[dx=$(width),dy=0.1,dz=$(width)] run function test:scan/hit
