#> test:job/station/populate_list_slot_unlocked
# @s = Jobステーション本体(please実行済み)。@macro id/label/color/slot: レジストリの1件ぶん
# 解放済みの職業を緑色・レベル表示付きで置く。クリックでツリービューへ

scoreboard players set #lvl test.temporary 0
$execute store result score #lvl test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).level

data modify storage test: job_work.list_item set value {id:"nether_star",count:1,components:{"minecraft:custom_name":{text:"",italic:false,color:"green",extra:[{text:" Lv."},{score:{name:"#lvl",objective:"test.temporary"}}]},"minecraft:custom_data":{test:{job_ui:1b}}}}
$data modify storage test: job_work.list_item.components."minecraft:custom_name".text set value "$(label)"
$data modify storage test: job_work.list_item.Slot set value $(slot)b

data modify block ~ ~ ~ Items append from storage test: job_work.list_item
