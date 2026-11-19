# つなぎ: 前の段(設置物・飛んでいる弾・自分)が、一定間隔で次の段を始める。1回ずつ次の段の複製を使うので、
# 起こした先の魔法はそれぞれ自分の寿命を持つ。同時に出せる数の上限は asset.config.magic_root_max_alive(全体で共通)
#   interval:  次の段を始める間隔(秒)
#   count:     何回始めるか(有限。これで無限増殖を止める)
$data modify storage test: magic.loot.link set value {interval:$(interval),count:$(count)}

$scoreboard players add #cost test.temporary $(cost)
