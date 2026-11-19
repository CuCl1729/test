#> test:magic/root/retain
# @s = 新しく出した持続物(弾・場・自己持続など)。@macro id / child / source: どのルートの、何段目(0=直接, 1=子ステージ)、
# どの発生源から出たか(発生源ごとに数えること。source=0 は直接/古い元帳との互換)。
# 呼び出し元は出す前にtest:magic/root/can_spawnで枠を確認済みのはず。ここでは上限は見ない(出した後に数えるだけ)。
# 既にdata.magic_rootが付いていれば何もしない(同じ個体を二重に数えないため)
execute if data entity @s data.magic_root run return 1
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0

$data modify entity @s data.magic_root set value {id:$(id),child:$(child),source:$(source)}
tag @s add magic_root_member

scoreboard players set #root_refs test.temporary 0
$execute store result score #root_refs test.temporary run data get storage test: magic_roots[{id:$(id)}].refs
scoreboard players add #root_refs test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].refs int 1 run scoreboard players get #root_refs test.temporary

$data modify storage test: root_work.child set value $(child)
scoreboard players set #root_child test.temporary 0
execute store result score #root_child test.temporary run data get storage test: root_work.child
execute if score #root_child test.temporary matches 0 run return 1

# 古い元帳では発生源0が合計(alive)を引き継ぐので、合計を動かす前に発生源ぶんを数える
$data modify storage test: root_work.slot set value {id:$(id),source:$(source)}
function test:magic/root/source_slot with storage test: root_work.slot
scoreboard players add #root_source_alive test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].sources[{id:$(source)}].alive int 1 run scoreboard players get #root_source_alive test.temporary

scoreboard players set #root_alive test.temporary 0
$execute store result score #root_alive test.temporary run data get storage test: magic_roots[{id:$(id)}].alive
scoreboard players add #root_alive test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].alive int 1 run scoreboard players get #root_alive test.temporary
return 1
