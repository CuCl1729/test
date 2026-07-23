execute unless data storage test: magic.loot.name[{text:"Ball"}] run data modify storage test: magic.loot.name append value {italic:0b,text:"Ball"}

data modify storage test: magic.loot.status merge value {magic_type:"projectile",projectile:{behavior:[],speed:100,range:20}}

scoreboard players add #cost test.temporary 50