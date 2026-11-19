#> test:magic/root/source_slot
# @macro id/source: ルート元帳の発生源ごとの同時生存数を用意して #root_source_alive test.temporary に入れる。
# 発生源を知らなかった古い元帳(sourcesが無い)は、ここで一度だけ移行する。今までの合計(alive)は
# すべて発生源0のぶんなので、他の発生源を作る前に発生源0へ移しておく(毎回の数え直しも走査もしない)
scoreboard players set #root_source_alive test.temporary 0
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0
$execute unless data storage test: magic_roots[{id:$(id)}].sources run data modify storage test: magic_roots[{id:$(id)}].sources set value [{id:0}]
$execute unless data storage test: magic_roots[{id:$(id)}].sources[{id:0}].alive run data modify storage test: magic_roots[{id:$(id)}].sources[{id:0}].alive set from storage test: magic_roots[{id:$(id)}].alive

$execute unless data storage test: magic_roots[{id:$(id)}].sources[{id:$(source)}] run data modify storage test: magic_roots[{id:$(id)}].sources append value {id:$(source),alive:0}

$execute store result score #root_source_alive test.temporary run data get storage test: magic_roots[{id:$(id)}].sources[{id:$(source)}].alive
return 1
