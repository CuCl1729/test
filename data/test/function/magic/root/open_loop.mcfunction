#> test:magic/root/open_loop
# root_work.chain を先頭から順に見て、「一定間隔」のつなぎ、または前の段(root_work.prev)が連続+投射で
# 今回が「着弾」のときに止まる(root_work.found に 1b を残す)。どちらでもなければ、このつなぎの到達先
# (entry.stage.type_flags)を次の判定の「前の段」にして続ける(ビームの段は鎖の先頭に限らずどこにあっても数える)
execute unless data storage test: root_work.chain[0] run return 0

data modify storage test: root_work.entry set from storage test: root_work.chain[0]
data remove storage test: root_work.chain[0]

execute if data storage test: root_work.entry{link:"periodic"} run data modify storage test: root_work.found set value 1b
execute if data storage test: root_work.entry{link:"periodic"} run return 1

execute if data storage test: root_work.prev{continuous:1b,projectile:1b} if data storage test: root_work.entry{link:"on_land"} run data modify storage test: root_work.found set value 1b
execute if data storage test: root_work.prev{continuous:1b,projectile:1b} if data storage test: root_work.entry{link:"on_land"} run return 1

data remove storage test: root_work.prev
data modify storage test: root_work.prev set from storage test: root_work.entry.stage.type_flags
function test:magic/root/open_loop
