# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/crop/generated/crops
# 普通の作物のドロップ(スプレッドシートの「作物のドロップ」タブ)。asset.crop.<作物> = {drops:[{item, min, max}]}。
# 育ちきった作物の目印(crop_token)を、test:crop/token/convert が行ごとに rng/roll で個数を決めて、バニラのアイテムにする

data modify storage test: asset.crop.wheat set value {drops:[{item:"minecraft:wheat",min:1,max:1},{item:"minecraft:wheat_seeds",min:0,max:3}]}
data modify storage test: asset.crop_ids append value "wheat"
data modify storage test: asset.crop.carrots set value {drops:[{item:"minecraft:carrot",min:2,max:5}]}
data modify storage test: asset.crop_ids append value "carrots"
data modify storage test: asset.crop.potatoes set value {drops:[{item:"minecraft:potato",min:2,max:5}]}
data modify storage test: asset.crop_ids append value "potatoes"
data modify storage test: asset.crop.beetroots set value {drops:[{item:"minecraft:beetroot",min:1,max:1},{item:"minecraft:beetroot_seeds",min:0,max:3}]}
data modify storage test: asset.crop_ids append value "beetroots"
