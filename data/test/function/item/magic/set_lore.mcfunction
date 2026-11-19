#> test:item/magic/set_lore
# storage test: loot.item に組み立てた魔法アイテムへ、消費MP・タイプ・組み合わせたステータスのロアを追加する

data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"消費MP:"}]
data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.cost"}
data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

# 押している間だけ払う形(ビーム)は、唱えたときの前払いが無い代わりに毎秒の維持MPが掛かる。
# 「1本あたり」なので、複数発射の設定ぶんだけ増える
execute if data storage test: loot.item.components.minecraft:custom_data.test.upkeep run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"維持MP/秒(1本):"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.upkeep run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.upkeep"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.upkeep run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

# この組み合わせが何になるか。文言は組み合わせの表の「説明」そのまま(クラフト時に焼き込んである)
execute if data storage test: loot.item.components.minecraft:custom_data.test.combo run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:blue,text:""}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.combo run data modify storage test: loot.item.components.minecraft:lore[-1][0].text set from storage test: loot.item.components.minecraft:custom_data.test.combo

# 継続(続く秒数)と追尾(探す距離)
execute if data storage test: loot.item.components.minecraft:custom_data.test.continuous run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"継続:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.continuous run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.continuous.duration"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.continuous run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text
execute if data storage test: loot.item.components.minecraft:custom_data.test.continuous run data modify storage test: loot.item.components.minecraft:lore[-1] append value {italic:0b,color:gray,text:"秒"}

execute if data storage test: loot.item.components.minecraft:custom_data.test.homing run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"追尾:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.homing run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.homing.radius"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.homing run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

# タイプ名のロアはレジストリを走査して出す(組み合わせた場合は使ったタイプぶん並ぶ)
data modify storage test: registry_work.lore_type_queue set from storage test: asset.magic.types
function test:item/magic/set_lore_type_loop

# 付与するバフ/デバフの一覧
data remove storage test: registry_work.lore_buff_queue
execute if data storage test: loot.item.components.minecraft:custom_data.test.buff[0] run data modify storage test: registry_work.lore_buff_queue set from storage test: loot.item.components.minecraft:custom_data.test.buff
function test:item/magic/set_lore_buff_loop

execute if data storage test: loot.item.components.minecraft:custom_data.test.aoe.radius run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"効果半径:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.aoe.radius run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.aoe.radius"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.aoe.radius run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

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

# 炎以外の属性ダメージ(水流/樹木/金属/大地)。レジストリを走査し、data.magic.<id>.baseが実在するものだけ1行足す
data modify storage test: registry_work.lore_element_queue set from storage test: asset.magic.effects
function test:item/magic/set_lore_element_loop

# 威力上昇は属性共通のdata.magic.atkに統合済み。無い場合だけ、旧版の属性別キー(data.magic.fire.atk)を表示する
execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.atk run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gold,text:"威力上昇:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.atk run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.data.magic.atk"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.atk run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute unless data storage test: loot.item.components.minecraft:custom_data.test.data.magic.atk if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.atk run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gold,text:"威力上昇:"}]
execute unless data storage test: loot.item.components.minecraft:custom_data.test.data.magic.atk if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.atk run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.data.magic.fire.atk"}
execute unless data storage test: loot.item.components.minecraft:custom_data.test.data.magic.atk if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.fire.atk run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

execute if data storage test: loot.item.components.minecraft:custom_data.test.heal.power run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:green,text:"回復量:"}]
execute if data storage test: loot.item.components.minecraft:custom_data.test.heal.power run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.heal.power"}
execute if data storage test: loot.item.components.minecraft:custom_data.test.heal.power run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text

# つないだ魔法の流れ(例: 投射 →着弾で→ 設置 →再使用で→ 範囲 爆風)
function test:item/magic/set_lore_flow
