# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/material/generated/materials
# 素材の宣言(スプレッドシートの「素材」タブ)。asset.material.<id> = {item, model, name, role, data}。item は全素材 minecraft:recovery_compass、見た目は model(item_model)。
# data はアイテムの custom_data.test に入る({material:{kind}} か、型紙なら {pattern:{part}})。作るのは test:item/material/build {id}

data modify storage test: asset.material.bone set value {item:"minecraft:recovery_compass",model:"minecraft:bone",name:"骨の欠片",role:"material",data:{material:{kind:"bone"}}}
data modify storage test: asset.material_ids append value "bone"
data modify storage test: asset.material.goblin_hide set value {item:"minecraft:recovery_compass",model:"minecraft:rabbit_hide",name:"ゴブリンの革",role:"material",data:{material:{kind:"goblin_hide"}}}
data modify storage test: asset.material_ids append value "goblin_hide"
data modify storage test: asset.material.mana_shard set value {item:"minecraft:recovery_compass",model:"minecraft:prismarine_crystals",name:"魔力の欠片",role:"material",data:{material:{kind:"mana_shard"}}}
data modify storage test: asset.material_ids append value "mana_shard"
data modify storage test: asset.material.iron_catalyst set value {item:"minecraft:recovery_compass",model:"minecraft:iron_nugget",name:"鉄の触媒",role:"catalyst",data:{material:{kind:"iron_catalyst"}}}
data modify storage test: asset.material_ids append value "iron_catalyst"
data modify storage test: asset.material.diamond_catalyst set value {item:"minecraft:recovery_compass",model:"minecraft:amethyst_shard",name:"輝きの触媒",role:"catalyst",data:{material:{kind:"diamond_catalyst"}}}
data modify storage test: asset.material_ids append value "diamond_catalyst"
data modify storage test: asset.material.aoe_core set value {item:"minecraft:recovery_compass",model:"minecraft:fire_charge",name:"範囲攻撃の核",role:"special",data:{material:{kind:"aoe_core"}}}
data modify storage test: asset.material_ids append value "aoe_core"
data modify storage test: asset.material.poison_fang set value {item:"minecraft:recovery_compass",model:"minecraft:fermented_spider_eye",name:"毒の牙",role:"special",data:{material:{kind:"poison_fang"}}}
data modify storage test: asset.material_ids append value "poison_fang"
data modify storage test: asset.material.head_pattern set value {item:"minecraft:recovery_compass",model:"minecraft:paper",name:"兜の型紙",role:"pattern",data:{pattern:{part:"head"}}}
data modify storage test: asset.material_ids append value "head_pattern"
data modify storage test: asset.material.chest_pattern set value {item:"minecraft:recovery_compass",model:"minecraft:paper",name:"鎧の型紙",role:"pattern",data:{pattern:{part:"chest"}}}
data modify storage test: asset.material_ids append value "chest_pattern"
data modify storage test: asset.material.legs_pattern set value {item:"minecraft:recovery_compass",model:"minecraft:paper",name:"脚甲の型紙",role:"pattern",data:{pattern:{part:"legs"}}}
data modify storage test: asset.material_ids append value "legs_pattern"
data modify storage test: asset.material.feet_pattern set value {item:"minecraft:recovery_compass",model:"minecraft:paper",name:"靴の型紙",role:"pattern",data:{pattern:{part:"feet"}}}
data modify storage test: asset.material_ids append value "feet_pattern"
data modify storage test: asset.material.accessory_pattern set value {item:"minecraft:recovery_compass",model:"minecraft:paper",name:"装飾の型紙",role:"pattern",data:{pattern:{part:"accessory"}}}
data modify storage test: asset.material_ids append value "accessory_pattern"
data modify storage test: asset.material.copper_ingot set value {item:"minecraft:recovery_compass",model:"minecraft:copper_ingot",name:"銅のインゴット",role:"material",data:{material:{kind:"copper_ingot"}}}
data modify storage test: asset.material_ids append value "copper_ingot"
data modify storage test: asset.material.pure_copper set value {item:"minecraft:recovery_compass",model:"minecraft:resin_brick",name:"純銅",role:"material",data:{material:{kind:"pure_copper"}}}
data modify storage test: asset.material_ids append value "pure_copper"
data modify storage test: asset.material.iron_ingot set value {item:"minecraft:recovery_compass",model:"minecraft:iron_ingot",name:"鉄のインゴット",role:"material",data:{material:{kind:"iron_ingot"}}}
data modify storage test: asset.material_ids append value "iron_ingot"
data modify storage test: asset.material.steel set value {item:"minecraft:recovery_compass",model:"minecraft:netherite_scrap",name:"鋼",role:"material",data:{material:{kind:"steel"}}}
data modify storage test: asset.material_ids append value "steel"
data modify storage test: asset.material.slag set value {item:"minecraft:recovery_compass",model:"minecraft:nether_brick",name:"鉱滓",role:"material",data:{material:{kind:"slag"}}}
data modify storage test: asset.material_ids append value "slag"
data modify storage test: asset.material.stone_dust set value {item:"minecraft:recovery_compass",model:"minecraft:clay_ball",name:"石の粉",role:"material",data:{material:{kind:"stone_dust"}}}
data modify storage test: asset.material_ids append value "stone_dust"
data modify storage test: asset.material.herb_leaf set value {item:"minecraft:recovery_compass",model:"minecraft:fern",name:"薬草",role:"material",data:{material:{kind:"herb_leaf"}}}
data modify storage test: asset.material_ids append value "herb_leaf"
data modify storage test: asset.material.medicinal_root set value {item:"minecraft:recovery_compass",model:"minecraft:beetroot_seeds",name:"薬の根",role:"material",data:{material:{kind:"medicinal_root"}}}
data modify storage test: asset.material_ids append value "medicinal_root"
data modify storage test: asset.material.twig set value {item:"minecraft:recovery_compass",model:"minecraft:stick",name:"小枝",role:"material",data:{material:{kind:"twig"}}}
data modify storage test: asset.material_ids append value "twig"
data modify storage test: asset.material.flower_petal set value {item:"minecraft:recovery_compass",model:"minecraft:pink_petals",name:"花びら",role:"material",data:{material:{kind:"flower_petal"}}}
data modify storage test: asset.material_ids append value "flower_petal"
