execute unless data storage test: magic.loot.name[{text:"Self"}] run data modify storage test: magic.loot.name append value {italic:0b,color:white,text:"Self"}

data modify storage test: magic.loot.status merge value {magic_type:"self"}

scoreboard players add #cost test.temporary 20
