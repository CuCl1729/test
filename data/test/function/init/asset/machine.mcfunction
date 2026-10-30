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

# asset.machine.<id> = 機械の定義。置くのはスポーンエッグ(test:machine/give_egg)、動かすのは test:machine/tick_second(1秒ごと)
#   name:          表示名(頭上の表示とエッグの名前)
#   core:          核のブロック(#test:machine_cores に入れる)。マーカーが自分の位置に置く
#   kind:          "pre"(前処理: 原石を加工途中の原石にする)/ "smelt"(仕上げ: 素材にする)
#   stage:         前処理のみ。何段階目の加工途中の原石を作るか(1から)。stage がちょうど1つ前のものだけ受け付ける
#   stage_prefix:  前処理のみ。加工途中の原石の名前の頭に付ける言葉
#   stage_model:   前処理のみ。加工途中の原石の見た目(item_model)
#   time:          1回の処理にかかる秒数
#   parts:         核から見た部品の位置とブロック [{block, l, u, f}](左・上・前。前は置いた人のいた方)。入れ物も含める
#   input / fuel:  原石を入れる入れ物 / 燃料を入れる入れ物の位置 {l, u, f}(parts の中の入れ物)
#   output:        できたものを落とす位置 {l, u, f}(空いている場所。真下のホッパーで回収できる)
# 位置は execute rotated <向き> 0 の ^左 ^上 ^前 で判定するので、どの向きに置いても同じ形になる

data modify storage test: asset.machine set value {}
data modify storage test: asset.machine_ids set value []

# 粉砕機(仮): 左に原石の入れ物、右に燃料の入れ物、上に部品。出口は前の1段上(前の床にホッパーを置くと回収できる)
data modify storage test: asset.machine.crusher set value {name:"粉砕機",core:"minecraft:lodestone",kind:"pre",stage:1,stage_prefix:"砕いた",stage_model:"minecraft:glowstone_dust",time:4,\
  parts:[{block:"minecraft:dropper",l:1,u:0,f:0},{block:"minecraft:dropper",l:-1,u:0,f:0},{block:"minecraft:waxed_cut_copper",l:0,u:1,f:0}],\
  input:{l:1,u:0,f:0},fuel:{l:-1,u:0,f:0},output:{l:0,u:1,f:1}}
data modify storage test: asset.machine_ids append value "crusher"

# 精錬炉(仮): 粉砕機と同じ並びに、後ろの部品を足した形
data modify storage test: asset.machine.smelter set value {name:"精錬炉",core:"minecraft:waxed_chiseled_copper",kind:"smelt",time:8,\
  parts:[{block:"minecraft:dropper",l:1,u:0,f:0},{block:"minecraft:dropper",l:-1,u:0,f:0},{block:"minecraft:waxed_cut_copper",l:0,u:1,f:0},{block:"minecraft:waxed_cut_copper",l:0,u:0,f:-1}],\
  input:{l:1,u:0,f:0},fuel:{l:-1,u:0,f:0},output:{l:0,u:1,f:1}}
data modify storage test: asset.machine_ids append value "smelter"
