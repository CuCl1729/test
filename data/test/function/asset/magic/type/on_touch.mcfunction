# つなぎ: 持ち主以外のプレイヤーか敵が radius ブロック以内に来ると、前の段の設置物が起動して次の段を始める
$data modify storage test: magic.loot.link set value {radius:$(radius)}
$scoreboard players add #cost test.temporary $(cost)
