# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/material/generated/materials
# 素材の宣言(スプレッドシートの「素材」タブ)。asset.material.<id> = {item, name, role, data}。
# data はアイテムの custom_data.test に入る({material:{kind}} か、型紙なら {pattern:{part}})。作るのは test:item/material/build {id}

data modify storage test: asset.material.bone set value {item:"bone",name:"骨の欠片",role:"material",data:{material:{kind:"bone"}}}
data modify storage test: asset.material_ids append value "bone"
data modify storage test: asset.material.goblin_hide set value {item:"rabbit_hide",name:"ゴブリンの革",role:"material",data:{material:{kind:"goblin_hide"}}}
data modify storage test: asset.material_ids append value "goblin_hide"
data modify storage test: asset.material.mana_shard set value {item:"prismarine_crystals",name:"魔力の欠片",role:"material",data:{material:{kind:"mana_shard"}}}
data modify storage test: asset.material_ids append value "mana_shard"
data modify storage test: asset.material.iron_catalyst set value {item:"iron_nugget",name:"鉄の触媒",role:"catalyst",data:{material:{kind:"iron_catalyst"}}}
data modify storage test: asset.material_ids append value "iron_catalyst"
data modify storage test: asset.material.diamond_catalyst set value {item:"amethyst_shard",name:"輝きの触媒",role:"catalyst",data:{material:{kind:"diamond_catalyst"}}}
data modify storage test: asset.material_ids append value "diamond_catalyst"
data modify storage test: asset.material.aoe_core set value {item:"fire_charge",name:"範囲攻撃の核",role:"special",data:{material:{kind:"aoe_core"}}}
data modify storage test: asset.material_ids append value "aoe_core"
data modify storage test: asset.material.poison_fang set value {item:"fermented_spider_eye",name:"毒の牙",role:"special",data:{material:{kind:"poison_fang"}}}
data modify storage test: asset.material_ids append value "poison_fang"
data modify storage test: asset.material.head_pattern set value {item:"paper",name:"兜の型紙",role:"pattern",data:{pattern:{part:"head"}}}
data modify storage test: asset.material_ids append value "head_pattern"
data modify storage test: asset.material.chest_pattern set value {item:"paper",name:"鎧の型紙",role:"pattern",data:{pattern:{part:"chest"}}}
data modify storage test: asset.material_ids append value "chest_pattern"
data modify storage test: asset.material.legs_pattern set value {item:"paper",name:"脚甲の型紙",role:"pattern",data:{pattern:{part:"legs"}}}
data modify storage test: asset.material_ids append value "legs_pattern"
data modify storage test: asset.material.feet_pattern set value {item:"paper",name:"靴の型紙",role:"pattern",data:{pattern:{part:"feet"}}}
data modify storage test: asset.material_ids append value "feet_pattern"
data modify storage test: asset.material.accessory_pattern set value {item:"paper",name:"装飾の型紙",role:"pattern",data:{pattern:{part:"accessory"}}}
data modify storage test: asset.material_ids append value "accessory_pattern"
