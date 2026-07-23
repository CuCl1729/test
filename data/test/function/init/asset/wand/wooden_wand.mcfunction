data modify storage test: asset.wooden_wand.item set value stick

data modify storage test: asset.wooden_wand.components."minecraft:custom_data" set value {status_bonus:{type:"atk_m",value:10},base_status:{type:"atk_add",value:30},level:0,max_level:60,magic_damage_bonus:30}

data modify storage test: asset.wooden_wand.components."minecraft:custom_name" set value [{italic:0b,text:"Wooden Wand "},{color:gray,text:"Level"},{color:"aqua",text:"0"}]

data modify storage test: asset.wooden_wand.components."minecraft:lore" append value [{color:gray,italic:0b,text:"基礎攻撃力:"},{color:aqua,text:"30"}]
data modify storage test: asset.wooden_wand.components."minecraft:lore" append value [{color:gray,italic:0b,text:"攻撃力:"},{color:aqua,text:"10"},{color:gray,text:"%"}]
data modify storage test: asset.wooden_wand.components."minecraft:lore" append value [{text:"   "},{color:gray,italic:0b,text:"サブステータス"}]

