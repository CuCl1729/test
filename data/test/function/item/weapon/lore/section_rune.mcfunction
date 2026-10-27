#> test:item/weapon/lore/section_rune
# @macro rune: ルーンのid。ルーンのアイテムの説明文に、今の定義(asset.rune.<id>.status)の能力を並べる

function test:item/weapon/lore/header {title:"強化台(付与)で装備の枠に入れると、常に効く能力"}
data modify storage test: lore_work.sub_queue set value []
$data modify storage test: lore_work.sub_queue set from storage test: asset.rune.$(rune).status
function test:item/weapon/lore/substatus_loop
