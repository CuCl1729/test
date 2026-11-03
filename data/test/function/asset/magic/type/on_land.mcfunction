# つなぎ: 前の段の弾が当たった・射程が切れた所で、次の段を始める。数値は持たない
data modify storage test: magic.loot.link set value {}
$scoreboard players add #cost test.temporary $(cost)
