# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/ore/generated/ores
# 原石の種類(スプレッドシートの「原石」タブ)。asset.ore.<id> = {item, model, name}。item は全種類 minecraft:paper(かまどで焼けないもの)、
# 見た目は model(item_model)で変える。作るのは test:item/ore/build {id, rare, stage}。
# asset.ore_ids は全種類のidの一覧(デバッグで配るときに使う)

data modify storage test: asset.ore.copper set value {item:"minecraft:paper",model:"minecraft:raw_copper",name:"銅の原石"}
data modify storage test: asset.ore_ids append value "copper"
data modify storage test: asset.ore.iron set value {item:"minecraft:paper",model:"minecraft:raw_iron",name:"鉄の原石"}
data modify storage test: asset.ore_ids append value "iron"
