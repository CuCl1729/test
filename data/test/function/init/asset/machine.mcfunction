#> test:init/asset/machine
# 機械(3×3×3 のマルチブロック)のレジストリ。手書き(筐体の種類と性能だけはスプレッドシートの「筐体」タブから生成)。
#
# asset.machine_item.<id> = {item, name, kind}: 組み立てに使うアイテム。作るのは test:item/machine/build {id}
#   kind "place":  置けるブロック。can_place_on で #test:machine_placeable(床・筐体・搬入口・搬出口・核・ホッパー)の上か横にだけ置ける。
#                  壊すと、同じもの(custom_data・名前・can_place_on が一致)が落ちるよう、そのブロックのルートテーブルを上書きしてある
#                  (data/minecraft/loot_table/blocks/<ブロック>.json。中身を変えるときは両方そろえる)
#   kind "wrench": レンチ。can_break で #test:machine_breakable(筐体・搬入口・搬出口・核・ホッパー)だけ壊せる。耐久値は減らない
#   筐体のアイテム(casing_<筐体のid>)は init/asset/machine/generated/casings が足す

data modify storage test: asset.machine_item set value {}
data modify storage test: asset.machine_item_ids set value []

data modify storage test: asset.machine_item.port_in set value {item:"minecraft:dropper",name:"搬入口",kind:"place"}
data modify storage test: asset.machine_item.port_out set value {item:"minecraft:dispenser",name:"搬出口",kind:"place"}
data modify storage test: asset.machine_item.machine_hopper set value {item:"minecraft:hopper",name:"ホッパー",kind:"place"}
data modify storage test: asset.machine_item.wrench set value {item:"minecraft:iron_hoe",name:"レンチ",kind:"wrench"}
data modify storage test: asset.machine_item_ids set value ["port_in","port_out","machine_hopper","wrench"]

# 筐体: asset.casing.<id> = {block, name, speed, by_bonus, fuel_use} と asset.casing_ids(スプレッドシートの「筐体」タブから生成)
data modify storage test: asset.casing set value {}
data modify storage test: asset.casing_ids set value []
function test:init/asset/machine/generated/casings

# 機械の形: 核が中心の 3×3×3。外側の26か所(asset.machine_shell の {x,y,z} は核からのずれ)は、
# どこも「筐体」(全部同じ種類)・「搬入口」(#test:machine_inputs)・「搬出口」(#test:machine_outputs)のどれか。
# 搬入口と搬出口はそれぞれ1つ以上。搬出口は、置いたときの向き(facing)の隣に成果物を出す(機械の内側を向いたものは数えない)
data modify storage test: asset.machine_shell set value [\
  {x:-1,y:-1,z:-1},{x:0,y:-1,z:-1},{x:1,y:-1,z:-1},{x:-1,y:-1,z:0},{x:0,y:-1,z:0},{x:1,y:-1,z:0},{x:-1,y:-1,z:1},{x:0,y:-1,z:1},{x:1,y:-1,z:1},\
  {x:-1,y:0,z:-1},{x:0,y:0,z:-1},{x:1,y:0,z:-1},{x:-1,y:0,z:0},{x:1,y:0,z:0},{x:-1,y:0,z:1},{x:0,y:0,z:1},{x:1,y:0,z:1},\
  {x:-1,y:1,z:-1},{x:0,y:1,z:-1},{x:1,y:1,z:-1},{x:-1,y:1,z:0},{x:0,y:1,z:0},{x:1,y:1,z:0},{x:-1,y:1,z:1},{x:0,y:1,z:1},{x:1,y:1,z:1}\
]

# asset.machine.<id> = 機械の定義。置くのはスポーンエッグ(test:machine/give_egg)、動かすのは test:machine/tick_second(1秒ごと)
#   name:          表示名(頭上の表示とエッグの名前)
#   core:          核のブロック(#test:machine_cores に入れる)。機械の種類は核だけで決まる
#   kind:          "pre"(前処理: 原石を加工途中の原石にする)/ "smelt"(仕上げ: 素材にする)
#   stage:         前処理のみ。何段階目の加工途中の原石を作るか(1から)。stage がちょうど1つ前のものだけ受け付ける
#   stage_prefix:  前処理のみ。加工途中の原石の名前の頭に付ける言葉
#   stage_model:   前処理のみ。加工途中の原石の見た目(item_model)
#   time:          1回の処理にかかる秒数(筐体の処理速度 100% のとき)

data modify storage test: asset.machine set value {}
data modify storage test: asset.machine_ids set value []

data modify storage test: asset.machine.crusher set value {name:"粉砕機",core:"minecraft:lodestone",kind:"pre",stage:1,stage_prefix:"砕いた",stage_model:"minecraft:glowstone_dust",time:4}
data modify storage test: asset.machine_ids append value "crusher"

data modify storage test: asset.machine.smelter set value {name:"精錬炉",core:"minecraft:waxed_chiseled_copper",kind:"smelt",time:8}
data modify storage test: asset.machine_ids append value "smelter"

# 加工途中の原石の名前の頭と見た目: asset.ore_stage.s<段階> = {prefix, model}。前処理の機械の stage_prefix / stage_model から作る
# (test:item/ore/build {id, rare, stage} が読む)
data modify storage test: asset.ore_stage set value {}
data modify storage test: machine_work.index_queue set from storage test: asset.machine_ids
function test:init/asset/machine/stage_loop
