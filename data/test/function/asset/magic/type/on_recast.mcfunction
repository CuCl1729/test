# つなぎ: 同じ魔法をもう一度使うと、前の段の設置物が起動して次の段を始める。数値は持たない
data modify storage test: magic.loot.link set value {}
$scoreboard players add #cost test.temporary $(cost)
