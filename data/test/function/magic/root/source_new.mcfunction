#> test:magic/root/source_new
# @macro id: その元帳に新しい発生源IDを1つ作って storage test: root_work.source_out に入れる(元帳が無ければ0)
data modify storage test: root_work.source_out set value 0
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0
$execute unless data storage test: magic_roots[{id:$(id)}].next_source run data modify storage test: magic_roots[{id:$(id)}].next_source set value 1

scoreboard players set #root_source_new test.temporary 1
$execute store result score #root_source_new test.temporary run data get storage test: magic_roots[{id:$(id)}].next_source
execute if score #root_source_new test.temporary matches ..0 run scoreboard players set #root_source_new test.temporary 1
scoreboard players operation #root_source_next test.temporary = #root_source_new test.temporary
scoreboard players add #root_source_next test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].next_source int 1 run scoreboard players get #root_source_next test.temporary
execute store result storage test: root_work.source_out int 1 run scoreboard players get #root_source_new test.temporary
return 1
