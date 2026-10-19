#> test:item/weapon/lore/damage_term
# @macro elem/key/label/unit: ダメージ式の1項(例: 「攻撃力の」+ 200 +「%」)

execute if score #lore_terms test.temporary matches 1.. run data modify storage test: lore_work.line append value {text:" + ",color:"gray"}
$data modify storage test: lore_work.line append value {text:"$(label)",color:"gray"}
$data modify storage test: lore_work.n set from storage test: lore_work.data.damage.$(elem).$(key)
function test:item/weapon/lore/num
$data modify storage test: lore_work.line append value {text:"$(unit)",color:"aqua"}

scoreboard players add #lore_terms test.temporary 1
