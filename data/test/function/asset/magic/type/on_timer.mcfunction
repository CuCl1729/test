# つなぎ: 置いてから seconds 秒で、前の段の設置物が起動して次の段を始める
$data modify storage test: magic.loot.link set value {seconds:$(seconds)}
$scoreboard players add #cost test.temporary $(cost)
