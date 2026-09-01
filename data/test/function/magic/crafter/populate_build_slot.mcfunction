#> test:magic/crafter/populate_build_slot
# @s = クラフター本体。@macro id/slot: 要素idと詰め先スロット番号
# buildにはidしか持たせていないので、タイプ/効果どちらのレジストリにあるか分からず両方試す

data modify storage test: registry_work.build_slot_info set value {label:"?",color:"gray",item:"barrier"}
$execute if data storage test: asset.magic.types[{id:"$(id)"}] run data modify storage test: registry_work.build_slot_info set from storage test: asset.magic.types[{id:"$(id)"}]
$execute if data storage test: asset.magic.effects[{id:"$(id)"}] run data modify storage test: registry_work.build_slot_info set from storage test: asset.magic.effects[{id:"$(id)"}]
$data modify storage test: registry_work.build_slot_info.slot set value $(slot)

function test:magic/crafter/populate_build_slot_place with storage test: registry_work.build_slot_info
