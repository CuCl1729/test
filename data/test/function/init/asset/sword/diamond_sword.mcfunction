data modify storage test: asset.diamond_sword.item set value diamond_sword

data modify storage test: asset.diamond_sword.components."minecraft:custom_data" set value {status_bonus:{type:"crit_rate_add",value:8.0},base_status:{type:"crit_damage_add",value:16.0,status_type:"%"},level:0,max_level:60,tier:6,weapon:[{type:"reach",value:5}],damage:{physics:{atk:300,base:300}}}

data modify storage test: asset.diamond_sword.components."minecraft:custom_name" set value [{italic:0b,text:"Diamond Sword "},{color:gray,text:"Level"},{color:aqua,text:"0"}]

data modify storage test: asset.diamond_sword.components."minecraft:lore" append value [{color:gray,italic:0b,text:"会心ダメージ:+"},{color:aqua,text:"16.0"},{color:gray,text:"%"}]
data modify storage test: asset.diamond_sword.components."minecraft:lore" append value [{color:gray,italic:0b,text:"会心率:+"},{color:aqua,text:"8,0"},{color:gary,text:"%"}]
data modify storage test: asset.diamond_sword.components."minecraft:lore" append value [{text:"   "},{color:gray,italic:0b,text:"サブステータス"}]

