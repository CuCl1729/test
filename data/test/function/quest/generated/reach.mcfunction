# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:quest/generated/reach
# 場所に行く段階(毎秒。test:action・test:turn の両方で、範囲の中にいる人)

execute in test:action as @a[x=-20,y=0,z=-30,dx=10,dy=5,dz=10] run function test:quest/reach_hit {id:"patrol",stage:1,need:1,main:0b}
execute in test:turn as @a[x=-20,y=0,z=-30,dx=10,dy=5,dz=10] run function test:quest/reach_hit {id:"patrol",stage:1,need:1,main:0b}
