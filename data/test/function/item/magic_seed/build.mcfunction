#> test:item/magic_seed/build
# @macro id: 魔法作物のid(asset.magic_crop.<id>)。種を storage test: loot.item に作る。custom_data.test.magic_seed = "<id>"。
# 元のアイテムは素材と同じ共通のもの、見た目は種の見た目(item_model)。右クリックを拾うため、ステータス確認のアイテムと同じく
# consumable を付ける(食べ終わらないほど長い時間にしてある。植えるのは test:farm/plant)。定義が無いidなら0、作れたら1を返す

$execute unless data storage test: asset.magic_crop.$(id) run return 0
data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.magic_crop.$(id).seed_item
$data modify storage test: loot.item.components."minecraft:item_model" set from storage test: asset.magic_crop.$(id).seed_model
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{magic_seed:"$(id)",right_click:true}}
data modify storage test: loot.item.components."minecraft:consumable" set value {consume_seconds:100000,animation:"none"}
$function test:item/magic_seed/name with storage test: asset.magic_crop.$(id)
return 1
