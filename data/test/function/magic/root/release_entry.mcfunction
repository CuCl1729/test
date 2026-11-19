#> test:magic/root/release_entry
# @macro id / child / source: 外れた個体のぶんをmagic_rootsから引く(発生源ごとの枠も引く)。refsが0になったら、
# そのルートの元帳自体を消す(初回配布で持続物を1つも出さなかったルートは、これでただちに片付く)。元帳が既に無ければ何もしない
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0

scoreboard players set #root_refs test.temporary 0
$execute store result score #root_refs test.temporary run data get storage test: magic_roots[{id:$(id)}].refs
execute if score #root_refs test.temporary matches 1.. run scoreboard players remove #root_refs test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].refs int 1 run scoreboard players get #root_refs test.temporary

$data modify storage test: root_work.child set value $(child)
scoreboard players set #root_child test.temporary 0
execute store result score #root_child test.temporary run data get storage test: root_work.child

# 古い元帳では発生源0が合計(alive)を引き継ぐので、合計を動かす前に発生源ぶんを引く
$data modify storage test: root_work.slot set value {id:$(id),source:$(source)}
execute if score #root_child test.temporary matches 1 run function test:magic/root/source_slot with storage test: root_work.slot
execute if score #root_child test.temporary matches 1 if score #root_source_alive test.temporary matches 1.. run scoreboard players remove #root_source_alive test.temporary 1
$execute if score #root_child test.temporary matches 1 store result storage test: magic_roots[{id:$(id)}].sources[{id:$(source)}].alive int 1 run scoreboard players get #root_source_alive test.temporary

scoreboard players set #root_alive test.temporary 0
$execute store result score #root_alive test.temporary run data get storage test: magic_roots[{id:$(id)}].alive
execute if score #root_child test.temporary matches 1 if score #root_alive test.temporary matches 1.. run scoreboard players remove #root_alive test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].alive int 1 run scoreboard players get #root_alive test.temporary

$execute if data storage test: magic_roots[{id:$(id),refs:0}] run data remove storage test: magic_roots[{id:$(id)}]
return 1
