#> test:init/asset/equip/accessory
# アクセサリー。インベントリに入れておくだけで効く(上限はasset.equip.accessory_limit)

data modify storage test: asset.equip.items.power_ring set value {item:"gold_nugget",components:{"minecraft:custom_name":[{italic:0b,text:"Power Ring "},{color:gray,text:"Level"},{color:aqua,text:"0"}],"minecraft:custom_data":{equip:{slot:"accessory"},status_bonus:{type:"atk_m",value:5.0},level:0,max_level:60}}}
data modify storage test: asset.equip.items.fire_charm set value {item:"emerald",components:{"minecraft:custom_name":[{italic:0b,text:"Fireward Charm "},{color:gray,text:"Level"},{color:aqua,text:"0"}],"minecraft:custom_data":{equip:{slot:"accessory"},status_bonus:{type:"fire_resist_add",value:10.0},level:0,max_level:60}}}
