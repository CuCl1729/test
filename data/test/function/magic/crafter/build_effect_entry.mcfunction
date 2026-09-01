#> test:magic/crafter/build_effect_entry
# @s = クラフター本体。@macro build_id: 処理する要素id
# タイプ/効果どちらのレジストリにあるかを問わず、folderフィールドを見て
# test:asset/magic/<folder>/<id> を呼ぶ(タイプ側もfolder:"type"を持つため同じ経路で処理できる)

data modify storage test: registry_work.build_dispatch set value {id:"",folder:""}
$data modify storage test: registry_work.build_dispatch.id set value "$(build_id)"
$execute if data storage test: asset.magic.types[{id:"$(build_id)"}] run data modify storage test: registry_work.build_dispatch.folder set from storage test: asset.magic.types[{id:"$(build_id)"}].folder
$execute if data storage test: asset.magic.effects[{id:"$(build_id)"}] run data modify storage test: registry_work.build_dispatch.folder set from storage test: asset.magic.effects[{id:"$(build_id)"}].folder

execute if data storage test: registry_work.build_dispatch{folder:""} run return 0
function test:magic/crafter/build_effect_dispatch with storage test: registry_work.build_dispatch
