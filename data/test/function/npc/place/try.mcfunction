#> test:npc/place/try
# @macro id/dim/x/y/z/kind/body: 置く NPC と、置くマップ(action / turn)。読み込まれていて、まだ無ければ置く

$execute in test:$(dim) unless loaded $(x) $(y) $(z) run return 0
$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz positioned ~0.5 ~ ~0.5 if entity @e[type=interaction,tag=npc_i,distance=..0.5] run return 0
$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz positioned ~0.5 ~ ~0.5 run function test:npc/place/summon with storage test: npc_work.p
