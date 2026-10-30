#> test:init/asset/machine
# 機械(マルチブロック)のレジストリ。手書き(形はスプレッドシートで表しにくいため)。
#
# asset.machine_item.<id> = {item, name, kind}: 組み立てに使うアイテム。作るのは test:item/machine/build {id}
#   kind "place":  置けるブロック。can_place_on で #test:machine_placeable(床・部品・入れ物・核・ホッパー)の上か横にだけ置ける。
#                  壊すと、同じもの(custom_data・名前・can_place_on が一致)が落ちるよう、そのブロックのルートテーブルを上書きしてある
#                  (data/minecraft/loot_table/blocks/<ブロック>.json。中身を変えるときは両方そろえる)
#   kind "wrench": レンチ。can_break で #test:machine_breakable(部品・入れ物・核・ホッパー)だけ壊せる。耐久値は減らない

data modify storage test: asset.machine_item set value {}
data modify storage test: asset.machine_item_ids set value []

data modify storage test: asset.machine_item.machine_part set value {item:"minecraft:waxed_cut_copper",name:"機械の部品",kind:"place"}
data modify storage test: asset.machine_item.machine_container set value {item:"minecraft:dropper",name:"機械の入れ物",kind:"place"}
data modify storage test: asset.machine_item.machine_hopper set value {item:"minecraft:hopper",name:"ホッパー",kind:"place"}
data modify storage test: asset.machine_item.wrench set value {item:"minecraft:iron_hoe",name:"レンチ",kind:"wrench"}
data modify storage test: asset.machine_item_ids set value ["machine_part","machine_container","machine_hopper","wrench"]
