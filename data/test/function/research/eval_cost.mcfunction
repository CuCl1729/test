#> test:research/eval_cost
# @s = プレイヤー。@macro cost: 研究のコスト(スキルポイント)

$execute if score @s test.status.skill_point matches $(cost).. run return run data modify storage test: research_work.lore append value {text:"コスト $(cost)",color:"green",italic:false}
$data modify storage test: research_work.lore append value {text:"コスト $(cost)",color:"red",italic:false}
scoreboard players set #rs_ok test.temporary 0
execute if data storage test: research_work{missing:""} run data modify storage test: research_work.missing set value "スキルポイント"
