#> test:item/weapon/lore/special_aoe
# 範囲攻撃(右クリック)。「✹ 範囲攻撃(右クリック) 90°・150%・MP10」(扇の角度・攻撃力に対する倍率・消費MP)。
# 値はcustom_data.weaponの値(test:asset/weapon/が作成時に決める)

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"✹ ",color:"gold"}
data modify storage test: lore_work.line append value {text:"範囲攻撃(右クリック) ",color:"gray"}

data modify storage test: lore_work.n set from storage test: lore_work.data.weapon[{type:"aoe_angle"}].value
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:"°・",color:"gray"}

data modify storage test: lore_work.n set from storage test: lore_work.data.weapon[{type:"aoe_multiplier"}].value
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:"%",color:"aqua"}
data modify storage test: lore_work.line append value {text:"・MP",color:"gray"}

data modify storage test: lore_work.n set from storage test: lore_work.data.weapon[{type:"aoe_mp_cost"}].value
function test:item/weapon/lore/num

function test:item/weapon/lore/commit
