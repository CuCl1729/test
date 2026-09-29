#> test:scan/aoe/probe
# サンプル点1つぶんの当たり判定。magic/aoe/probeと同じ二重AABBで、サンプル点を中心とした
# 水平±0.5・上下±1の範囲にヒットボックスが触れているものを拾う。
# 点の間隔は弧の方向・半径の方向とも1ブロック以下なので、射程によらず隣り合う点の箱が隙間なくつながる。
# 戦闘中のbattle_markerを叩くと途中参加できるため、HPを持つものだけには絞らない

execute as @e[type=!player,tag=!hit,dx=-0.5,dy=-1,dz=-0.5] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.5,dy=1,dz=0.5] run function test:scan/hit
