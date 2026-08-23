#> test:init/
#
# @private
forceload add 0 0 0 0

# test:arena の各アリーナ座標(戦闘マーカー/構造物が置かれる場所)を常時ロードしておく
execute in test:arena run forceload add 0 0 0 0
execute in test:arena run forceload add 500 0 500 0
execute in test:arena run forceload add 1000 0 1000 0
execute in test:arena run forceload add 1500 0 1500 0

# ワールドに1組あればよい共有の補助エンティティ。ロアの組み立て(item/magic/set_lore等)や
# 座標計算(scan/circle等)がこれらを前提にしているため、誤ってkillされても/reloadで復旧するよう
# 「installed」ガードではなく「無ければ召喚し直す」形にしておく
# (HPバーやダメージポップアップの掃除でtext_displayをまとめてkillすると巻き込まれるため)
execute unless entity @e[type=marker,nbt={data:{is_class_manager:1b}},limit=1] run summon marker 0.0 0.0 0.0 {data:{"is_class_manager":1b}}
execute unless entity @e[tag=text,limit=1] run summon text_display 0.0 0.0 0.0 {Tags:[text]}
execute unless entity @e[tag=Ray,limit=1] run summon armor_stand 0.0 0.0 0.0 {Tags:[Ray],Marker:1b}
execute unless entity @e[tag=Temp,limit=1] run summon armor_stand 0.0 0.0 0.0 {Tags:[Temp],Marker:1b}
execute unless block 0 -64 0 red_shulker_box run setblock 0 -64 0 red_shulker_box

# Axisは「ちょうど2体」で1組(scan/circleが2体の回転を組み合わせて座標を出すため)。
# 個数が合っていないと座標がずれるので、毎回作り直して数を確定させる(状態を持たないマーカーなので作り直して問題ない)
kill @e[tag=Axis]
summon armor_stand 0.0 0.0 0.0 {Tags:[Axis],Marker:1b}
summon armor_stand 0.0 0.0 0.0 {Tags:[Axis],Marker:1b}

data remove storage test: class
data remove storage test: asset

function test:init/scoreboard
function test:init/class
function test:init/asset/

function test:init/set_table

data modify storage test: installed set value 1b
