#> test:item/magic/set_lore
# storage test: loot.item に組み立てた魔法アイテムへ、消費MP・タイプ・組み合わせたステータスのロアを追加する

data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"消費MP:"}]
data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.cost"}
data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute if data storage test: loot.item.components.minecraft:custom_data.test{magic_type:"self"} run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"タイプ: 自己"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test{magic_type:"projectile"} run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"タイプ: 投射"}]

execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"射程:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.projectile.range"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"速度:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.projectile.speed"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile.gravity run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"重力:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile.gravity run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.projectile.gravity"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.projectile.gravity run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.base run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:red,text:"炎上ダメージ:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.base run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.data.magic.fire.base"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.base run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.atk run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gold,text:"威力上昇:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.atk run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.data.magic.fire.atk"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.atk run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute if data storage test: loot.item.components.minecraft:custom_data.test.heal.power run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:green,text:"回復量:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.heal.power run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.heal.power"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.heal.power run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text
