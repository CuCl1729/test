#> test:magic/root/can_spawn_entry
# @macro id / source: magic_rootsのidについて、同時に存在できる数(alive<max_alive)の余裕があるかを返す。
# 同時に存在できる数は発生源ごとに数える。元帳が無い(子ステージなのに持ち主が元帳を持っていない)なら出せない
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0

$data modify storage test: root_work.slot set value {id:$(id),source:$(source)}
function test:magic/root/source_slot with storage test: root_work.slot

scoreboard players set #root_max test.temporary 0
$execute store result score #root_max test.temporary run data get storage test: magic_roots[{id:$(id)}].max_alive

execute if score #root_source_alive test.temporary < #root_max test.temporary run return 1
return 0
