#> test:magic/crafter/build_effect_entry
# @s = クラフター本体。@macro build_id: 処理する要素id
# タイプ/効果どちらのレジストリにあるかを問わず、folderフィールドを見て
# test:asset/magic/<folder>/<id> を呼ぶ(タイプ側もfolder:"type"を持つため同じ経路で処理できる)

data modify storage test: registry_work.build_dispatch set value {id:"",folder:""}
$data modify storage test: registry_work.build_dispatch.id set value "$(build_id)"
$execute if data storage test: asset.magic.types[{id:"$(build_id)"}] run data modify storage test: registry_work.build_dispatch.folder set from storage test: asset.magic.types[{id:"$(build_id)"}].folder
$execute if data storage test: asset.magic.effects[{id:"$(build_id)"}] run data modify storage test: registry_work.build_dispatch.folder set from storage test: asset.magic.effects[{id:"$(build_id)"}].folder

execute if data storage test: registry_work.build_dispatch{folder:""} run return 0

# 組み合わせの表(test:magic/combo/match)は「使われた要素id」の集合だけを見る。
# 届け方や修飾子だけでなく効果(火炎・回復など)も条件に書けるよう、処理した要素は
# タイプ/効果の別なくここで必ずフラグを立てる(タイプ側は自分の関数でも立てるが、二重でも害は無い)
$data modify storage test: magic.loot.status.type_flags.$(build_id) set value 1b

function test:magic/crafter/build_effect_dispatch with storage test: registry_work.build_dispatch
