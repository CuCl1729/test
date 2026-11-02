#> test:mine/egg/name
# @macro ore: 鉱脈の原石のid(ほかのキーも渡ってくるが使わない)。作っているエッグの名前の2つ目に、原石の名前を入れる
$data modify storage test: loot.item.components."minecraft:custom_name"[1].text set from storage test: asset.ore.$(ore).name
