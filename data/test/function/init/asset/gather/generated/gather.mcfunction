# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/gather/generated/gather
# 採取(スプレッドシートの「採取物」「採取の中身」「採取の道具」「採取ポイント」タブ)。
#   asset.gather.<id> = {name, block, after, tool, respawn(秒), drops:[{material, rank, chance, chance_rank, min, max}]}
#   asset.gather_tool.<id> = {item, model, name, kind, rank} / asset.gather_point.<id> = {type, block, x, y, z}

data modify storage test: asset.gather_tool.copper_sickle set value {item:"minecraft:recovery_compass",model:"minecraft:copper_hoe",name:"銅の鎌",kind:"sickle",rank:1}
data modify storage test: asset.gather_tool_ids append value "copper_sickle"
data modify storage test: asset.gather_tool.iron_sickle set value {item:"minecraft:recovery_compass",model:"minecraft:iron_hoe",name:"鉄の鎌",kind:"sickle",rank:2}
data modify storage test: asset.gather_tool_ids append value "iron_sickle"
data modify storage test: asset.gather.herb set value {name:"薬草の茂み",block:"minecraft:fern",after:"minecraft:air",tool:"sickle",respawn:30,drops:[{material:"herb_leaf",rank:0,chance:100,chance_rank:0,min:1,max:2},{material:"medicinal_root",rank:1,chance:30,chance_rank:20,min:1,max:1}]}
data modify storage test: asset.gather_ids append value "herb"
data modify storage test: asset.gather.bush set value {name:"低木",block:"minecraft:azalea",after:"minecraft:dead_bush",tool:"sickle",respawn:60,drops:[{material:"twig",rank:0,chance:80,chance_rank:0,min:1,max:3},{material:"flower_petal",rank:2,chance:20,chance_rank:20,min:1,max:1}]}
data modify storage test: asset.gather_ids append value "bush"
data modify storage test: asset.gather_point.herb_1 set value {type:"herb",block:"minecraft:fern",x:0,y:0,z:5}
data modify storage test: asset.gather_point_ids append value "herb_1"
data modify storage test: asset.gather_point.herb_2 set value {type:"herb",block:"minecraft:fern",x:3,y:0,z:5}
data modify storage test: asset.gather_point_ids append value "herb_2"
data modify storage test: asset.gather_point.bush_1 set value {type:"bush",block:"minecraft:azalea",x:6,y:0,z:5}
data modify storage test: asset.gather_point_ids append value "bush_1"
