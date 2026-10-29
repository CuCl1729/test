data modify storage test: magic.loot.status.effect append value "revive"

# 倒れた味方を起こし、HPを最大HPの percent% にする(範囲の魔法でだけ使う。test:status/revive)
$data modify storage test: magic.loot.status.revive set value {percent:$(percent)}

$scoreboard players add #cost test.temporary $(cost)
