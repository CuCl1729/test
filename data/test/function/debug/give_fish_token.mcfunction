#> test:debug/give_fish_token
# @s = プレイヤー。@macro id: 中身のid。釣りの目印(ルートテーブルが落とすものと同じ)を1個、足元に落とす(拾うと素材に変わる)

data remove storage test: loot.item
data modify storage test: loot.item.id set from storage test: asset.fish_token_item.item
data modify storage test: loot.item.components."minecraft:item_model" set from storage test: asset.fish_token_item.model
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.fish_token_item.name
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{fish_token:"$(id)"}}
execute at @s run function test:item/drop_at
