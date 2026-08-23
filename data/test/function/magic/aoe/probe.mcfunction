#> test:magic/aoe/probe
# サンプル点1つぶんの当たり判定。scan/ray_cast/と同じ二重AABBでヒットボックスが触れているものを拾う
# (distance=はヒットボックスではなく中心点間の距離判定なので使わない)
# サンプル点は重なるため、既にhitタグが付いているものは除外して二重取りを防ぐ。
# マーカーや表示用エンティティを拾わないよう、HPを持っている対象だけに絞る

execute as @e[tag=!hit,tag=!projectile,scores={test.status.hp=1..},dx=-0.5,dy=-0.5,dz=-0.5] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.5,dy=0.5,dz=0.5] run function test:scan/hit
particle end_rod ~ ~ ~ 0 0 0 0 0