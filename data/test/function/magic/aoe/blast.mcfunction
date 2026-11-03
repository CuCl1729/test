#> test:magic/aoe/blast
# 実行位置 = 範囲の爆発の中心。@macro radius/power/lift: 半径(ブロック)と、外向き・上向きの速さ(0.01 ブロック/tick)。
# 半径内のプレイヤー(唱えた人も)と戦闘に入っていない敵を、中心から外へ吹き飛ばす(test:magic/aoe/blast_one)
particle minecraft:gust_emitter_small ~ ~0.5 ~ 0 0 0 0 1 force @a
playsound minecraft:entity.wind_charge.wind_burst master @a ~ ~ ~ 1 1
$execute as @a[distance=..$(radius),gamemode=!spectator] run function test:magic/aoe/blast_one {power:$(power),lift:$(lift)}
$execute as @e[tag=enemy,tag=!battle_member,distance=..$(radius)] run function test:magic/aoe/blast_one {power:$(power),lift:$(lift)}
