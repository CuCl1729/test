#> test:magic/crafter/click_top
# @s = クラフター本体。@macro index: 取られたスロットのpage_ids内インデックス(0〜6)
# 中段が満杯(9件)でなければ末尾に積んで組み立て直す。満杯なら追加せずメッセージだけ出す

$data modify storage test: registry_work.click_id set from entity @s data.crafter_ui.page_ids[$(index)]

scoreboard players set #build_full test.buff.work 0
execute if data entity @s data.crafter_ui.build[8] run scoreboard players set #build_full test.buff.work 1

execute if score #build_full test.buff.work matches 0 run data modify entity @s data.crafter_ui.build append value ""
execute if score #build_full test.buff.work matches 0 run data modify entity @s data.crafter_ui.build[-1] set from storage test: registry_work.click_id

execute if score #build_full test.buff.work matches 1 as @p[distance=..3] run tellraw @s [{text:"これ以上追加できません",color:gray}]

function test:magic/crafter/rebuild
function test:magic/crafter/populate_top
