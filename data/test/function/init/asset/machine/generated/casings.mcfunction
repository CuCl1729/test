# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/machine/generated/casings
# 機械の筐体(スプレッドシートの「筐体」タブ)。asset.casing.<id> = {block, name, speed, by_bonus, fuel_use}。
#   speed: 1秒の進み(%) / by_bonus: 副産物の確率に足す値(%) / fuel_use: 1回の処理で使う燃料(%。100で1回分)
# 筐体のアイテムは asset.machine_item.casing_<id>(test:item/machine/build で作る)。test:init/asset/machine が呼ぶ

data modify storage test: asset.casing.copper set value {block:"minecraft:waxed_cut_copper",name:"銅の筐体",speed:100,by_bonus:0,fuel_use:100}
data modify storage test: asset.casing_ids append value "copper"
data modify storage test: asset.machine_item.casing_copper set value {item:"minecraft:waxed_cut_copper",name:"銅の筐体",kind:"place"}
data modify storage test: asset.machine_item_ids append value "casing_copper"
data modify storage test: asset.casing.iron set value {block:"minecraft:iron_block",name:"鉄の筐体",speed:150,by_bonus:10,fuel_use:150}
data modify storage test: asset.casing_ids append value "iron"
data modify storage test: asset.machine_item.casing_iron set value {item:"minecraft:iron_block",name:"鉄の筐体",kind:"place"}
data modify storage test: asset.machine_item_ids append value "casing_iron"
