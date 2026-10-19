#> test:item/weapon/lore/section_special
# 特殊効果: 素材で付いた能力(範囲攻撃の核 → 右クリックの範囲攻撃、毒の牙など → 命中時のバフ付与)

function test:item/weapon/lore/header {title:"特殊効果"}

execute if data storage test: lore_work.data.test{aoe_attack:1b} run function test:item/weapon/lore/special_aoe

data modify storage test: lore_work.buff_queue set value []
data modify storage test: lore_work.buff_queue set from storage test: lore_work.data.test.buff_on_hit
function test:item/weapon/lore/special_buff_loop
