execute unless data storage test: magic.loot.name[{text:"Fire"}] run data modify storage test: magic.loot.name append value {italic:0b,color:red,text:"Fire"}

data modify storage test: magic.loot.status.effect append value "fire"

data modify storage test: magic.loot.status.data.magic.fire set value {base:1000}

scoreboard players add #cost test.temporary 50