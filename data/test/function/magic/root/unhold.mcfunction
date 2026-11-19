#> test:magic/root/unhold
# @macro id: test:magic/root/hold で足した仮想の保持を1つ外す。保持していなければ何もしない(2回呼んでも安全)。
# held を先に消してから refs を引く(他の子の実体ぶんの refs が残っていれば元帳はそのまま)
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0
$execute unless data storage test: magic_roots[{id:$(id),held:1b}] run return 0

$data modify storage test: magic_roots[{id:$(id)}].held set value 0b
scoreboard players set #root_refs test.temporary 0
$execute store result score #root_refs test.temporary run data get storage test: magic_roots[{id:$(id)}].refs
execute if score #root_refs test.temporary matches 1.. run scoreboard players remove #root_refs test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].refs int 1 run scoreboard players get #root_refs test.temporary

$execute if data storage test: magic_roots[{id:$(id),refs:0}] run data remove storage test: magic_roots[{id:$(id)}]
return 1
