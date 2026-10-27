#> test:item/weapon/lore/proc_item
# @macro item: アイテムの枠に設定した消耗品のid。「<消耗品の名前> を使う(<every>回ごと)」を作りかけの行に足す
# (everyは今の定義から読む。定義が無いときは回数を出さない)

function test:item/weapon/lore/proc_name {color:"green"}
data modify storage test: lore_work.line append value {text:" を使う",color:"gray"}

$execute unless data storage test: asset.consumable.$(item) run return 0
data modify storage test: lore_work.line append value {text:"(",color:"dark_gray"}
$data modify storage test: lore_work.n set from storage test: asset.consumable.$(item).every
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:"回ごと)",color:"dark_gray"}
