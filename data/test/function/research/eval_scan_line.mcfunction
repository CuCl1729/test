#> test:research/eval_scan_line
# @s = プレイヤー。@macro id/name: 調べておく観測

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scanned.$(id) run return run data modify storage test: research_work.lore append value {text:"観測: $(name)",color:"green",italic:false}
$data modify storage test: research_work.lore append value {text:"観測: $(name)",color:"red",italic:false}
scoreboard players set #rs_ok test.temporary 0
$execute if data storage test: research_work{missing:""} run data modify storage test: research_work.missing set value "観測 $(name)"
