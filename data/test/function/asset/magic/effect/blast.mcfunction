data modify storage test: magic.loot.status.effect append value "blast"

# 範囲の爆発で、半径内のプレイヤーと敵を中心から外へ吹き飛ばす(test:magic/aoe/blast)。
# power は外向き、lift は足す上向きの速さで、どちらも 0.01 ブロック/tick 単位
$data modify storage test: magic.loot.status.blast set value {power:$(power),lift:$(lift)}

$scoreboard players add #cost test.temporary $(cost)
