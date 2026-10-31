#> test:research/eval_item
# @macro name/icon: 研究の名前とアイコン。research_work.item(Slot は呼び出し側が入れる)を作る。
# 名前の色: 済は「<名前> [済]」、研究できるものは明るい色、条件が足りないものは灰色

$data modify storage test: research_work.item set value {Slot:0b,id:"$(icon)",count:1,components:{"minecraft:custom_name":{text:"$(name)",italic:false,color:"gray"},"minecraft:lore":[],"minecraft:custom_data":{test:{crafter_ui:1b}}}}
data modify storage test: research_work.item.components."minecraft:lore" set from storage test: research_work.lore
$execute if score #rs_done test.temporary matches 1 run data modify storage test: research_work.item.components."minecraft:custom_name" set value {text:"$(name) [済]",italic:false,color:"dark_green"}
execute if score #rs_done test.temporary matches 0 if score #rs_ok test.temporary matches 1 run data modify storage test: research_work.item.components."minecraft:custom_name".color set value "yellow"
