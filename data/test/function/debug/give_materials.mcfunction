#> test:debug/give_materials
# @s = プレイヤー。素材を全種類(asset.material_ids)、インベントリに直接渡す(型紙は1個、それ以外は20個ずつ。
# 鍛冶場・工房は材料の個数でレア度が決まり、20個以上で最高になる)

data modify storage test: debug_work.give_queue set value []
data modify storage test: debug_work.give_queue set from storage test: asset.material_ids
function test:debug/give_materials_loop
