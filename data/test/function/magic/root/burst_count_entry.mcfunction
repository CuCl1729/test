#> test:magic/root/burst_count_entry
# @macro id / source: magic_rootsのidの空き枠(max_alive-このsourceのalive)で#burst_countを切り詰めて返す。
# 元帳が無いか空きが無ければ0
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0

$data modify storage test: root_work.slot set value {id:$(id),source:$(source)}
function test:magic/root/source_slot with storage test: root_work.slot

scoreboard players set #root_max test.temporary 0
$execute store result score #root_max test.temporary run data get storage test: magic_roots[{id:$(id)}].max_alive

scoreboard players operation #root_free test.temporary = #root_max test.temporary
scoreboard players operation #root_free test.temporary -= #root_source_alive test.temporary
execute if score #root_free test.temporary matches ..0 run return 0

execute if score #burst_count test.temporary <= #root_free test.temporary run return run scoreboard players get #burst_count test.temporary
return run scoreboard players get #root_free test.temporary
