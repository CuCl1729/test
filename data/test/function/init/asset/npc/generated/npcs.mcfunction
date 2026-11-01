# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/npc/generated/npcs
# NPC(スプレッドシートの「NPC」タブ)。asset.npc.<id> = {id, name, kind, body, x, y, z, yaw, role, shop, counter?, entry?}。置くのは test:npc/place/

data modify storage test: asset.npc.elder set value {id:"elder",name:"村長",kind:"villager",body:{NoAI:1b,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,VillagerData:{profession:"minecraft:librarian",type:"minecraft:plains",level:1},Offers:{Recipes:[]},CustomName:{text:"村長",color:"yellow"},CustomNameVisible:1b,Tags:["npc_body","npc.elder"],Rotation:[0f,0f]},x:0,y:0,z:-15,yaw:0f,role:"talk",shop:"",entry:1b,hooks:1b}
data modify storage test: asset.npc_ids append value "elder"
data modify storage test: asset.npc.herbalist set value {id:"herbalist",name:"薬師",kind:"mannequin",body:{profile:{name:"Alex"},immovable:1b,hide_description:1b,Invulnerable:1b,Silent:1b,CustomName:{text:"薬師",color:"yellow"},CustomNameVisible:1b,Tags:["npc_body","npc.herbalist"],Rotation:[0f,0f]},x:3,y:0,z:-15,yaw:0f,role:"talk",shop:"",entry:1b,hooks:1b}
data modify storage test: asset.npc_ids append value "herbalist"
data modify storage test: asset.npc.shopkeeper set value {id:"shopkeeper",name:"道具屋",kind:"mannequin",body:{profile:{name:"Steve"},immovable:1b,hide_description:1b,Invulnerable:1b,Silent:1b,CustomName:{text:"道具屋",color:"yellow"},CustomNameVisible:1b,Tags:["npc_body","npc.shopkeeper"],Rotation:[0f,0f]},x:-3,y:0,z:-15,yaw:0f,role:"shop",shop:"general",counter:1b,entry:1b}
data modify storage test: asset.npc_ids append value "shopkeeper"
data modify storage test: asset.npc.banker set value {id:"banker",name:"銀行員",kind:"villager",body:{NoAI:1b,Invulnerable:1b,Silent:1b,PersistenceRequired:1b,VillagerData:{profession:"minecraft:cartographer",type:"minecraft:plains",level:1},Offers:{Recipes:[]},CustomName:{text:"銀行員",color:"yellow"},CustomNameVisible:1b,Tags:["npc_body","npc.banker"],Rotation:[0f,0f]},x:-6,y:0,z:-15,yaw:0f,role:"bank",shop:"",counter:1b}
data modify storage test: asset.npc_ids append value "banker"
