#> test:job/station/populate_list_slot_locked
# @s = Jobステーション本体(please実行済み)。@macro id/label/color/requires/slot: レジストリの1件ぶん
# 未解放の職業をグレーで置く(前提未達の詳細内訳はlore化していない。クリックはできるが
# test:job/unlockが前提未達なら実際には解放しない)

data modify storage test: job_work.list_item set value {id:"gray_dye",count:1,components:{"minecraft:custom_name":{text:"",italic:false,color:"gray"},"minecraft:custom_data":{test:{job_ui:1b}}}}
$data modify storage test: job_work.list_item.components."minecraft:custom_name".text set value "$(label)(未解放)"
$data modify storage test: job_work.list_item.Slot set value $(slot)b

data modify block ~ ~ ~ Items append from storage test: job_work.list_item
