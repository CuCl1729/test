execute unless data storage test: magic.loot.name[{text:"Heal"}] run data modify storage test: magic.loot.name append value {italic:0b,color:white,text:"Heal"}

data modify storage test: magic.loot.status.effect append value "heal"

data modify storage test: magic.loot.status.heal set value {power:3}

scoreboard players add #cost test.temporary 200