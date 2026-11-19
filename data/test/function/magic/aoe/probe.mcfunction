#> test:magic/aoe/probe
# サンプル点1つぶんの当たり判定。scan/ray_cast/と同じ二重AABBでヒットボックスが触れているものを拾う
# (distance=はヒットボックスではなく中心点間の距離判定なので使わない)
# サンプル点は重なるため、既にhitタグが付いているものは除外して二重取りを防ぐ。
# マーカーや表示用エンティティを拾わないよう、HPを持っている対象だけに絞る

# beam_hit は、同じパルスでビームに直接貫かれた相手。行き止まりの範囲で二重に当てないよう外す
# (ビーム以外の呼び出しでは誰にも付いていないので、何も変わらない)
execute as @e[tag=!hit,tag=!beam_hit,tag=!projectile,scores={test.status.hp=1..},dx=-0.5,dy=-0.5,dz=-0.5] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.5,dy=0.5,dz=0.5] run function test:scan/hit

# 武器弾の円/投射/ビームのAoEなら、旧剣AoE(scan/aoe/probe)と同じく乱入用マーカーも拾う。
# 純粋な魔法(action_hitが武器でない)はこれまで通りマーカーを無視する
execute if data storage test: action_hit{kind:"weapon"} as @e[tag=!hit,tag=!beam_hit,tag=battle_entrance,dx=-0.5,dy=-0.5,dz=-0.5] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.5,dy=0.5,dz=0.5] run function test:scan/hit
particle end_rod ~ ~ ~ 0 0 0 0 0