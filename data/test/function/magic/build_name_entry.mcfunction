#> test:magic/build_name_entry
# @s = クラフター本体。@macro name_id: 処理する要素id
# 既出なら何もしない(最初の1回だけ名前を出すため)。タイプ/効果どちらのレジストリにあるかを
# 問わず処理できるよう両方試す(存在しない方・nameを持たない要素は黙って空振りする)

$execute if data storage test: registry_work.name_seen[{id:"$(name_id)"}] run return 0
$data modify storage test: registry_work.name_seen append value {id:"$(name_id)"}

$execute if data storage test: asset.magic.types[{id:"$(name_id)"}].name run data modify storage test: magic.loot.name append from storage test: asset.magic.types[{id:"$(name_id)"}].name
$execute if data storage test: asset.magic.effects[{id:"$(name_id)"}].name run data modify storage test: magic.loot.name append from storage test: asset.magic.effects[{id:"$(name_id)"}].name
