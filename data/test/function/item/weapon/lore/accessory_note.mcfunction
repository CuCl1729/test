#> test:item/weapon/lore/accessory_note
# アクセサリーの使い方(インベントリに入れておくと効く。上限はasset.equip.accessory_limit)

data modify storage test: loot.item.components."minecraft:lore" append value [{text:""}]
function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"◇ ",color:"aqua"}
data modify storage test: lore_work.line append value {text:"インベントリに入れておくと効果(最大",color:"gray"}
data modify storage test: lore_work.n set from storage test: asset.equip.accessory_limit
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:"個まで)",color:"gray"}
function test:item/weapon/lore/commit
