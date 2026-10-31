#> test:research/eval_know_line
# @macro label/n/have: 属性の表示名・必要な量・今の量(#k)

$execute if score #k test.temporary matches $(n).. run return run data modify storage test: research_work.lore append value {text:"$(label) $(have)/$(n)",color:"green",italic:false}
$data modify storage test: research_work.lore append value {text:"$(label) $(have)/$(n)",color:"red",italic:false}
scoreboard players set #rs_ok test.temporary 0
$execute if data storage test: research_work{missing:""} run data modify storage test: research_work.missing set value "知識 $(label) $(have)/$(n)"
