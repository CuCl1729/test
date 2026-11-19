#> test:magic/root/hold
# @macro id: 実体を持たない「仮想の保持」を1つ足す(ビームが今は持続物を1つも出していなくても、
# このルートの元帳を消させないため)。既に保持済みなら何もしない(refsを二重に増やさないため)
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0
$execute if data storage test: magic_roots[{id:$(id),held:1b}] run return 1

$data modify storage test: magic_roots[{id:$(id)}].held set value 1b
scoreboard players set #root_refs test.temporary 0
$execute store result score #root_refs test.temporary run data get storage test: magic_roots[{id:$(id)}].refs
scoreboard players add #root_refs test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].refs int 1 run scoreboard players get #root_refs test.temporary
return 1
