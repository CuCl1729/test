#> test:item/machine/build_place
# loot.item を、床・部品・入れ物・核・ホッパーの上か横にだけ置けるブロックにする(アドベンチャーモード用)。
# ルートテーブル(data/minecraft/loot_table/blocks/<ブロック>.json)の set_components と同じ中身にする

data modify storage test: loot.item.components."minecraft:can_place_on" set value {blocks:"#test:machine_placeable"}
data modify storage test: loot.item.components."minecraft:tooltip_display" set value {hidden_components:["minecraft:can_place_on"]}
