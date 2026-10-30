#> test:init/asset/ore/
# 原石の種類のレジストリ。asset.ore.<id> = {item, model, name}(スプレッドシートの「原石」タブから生成)。
# item は全種類かまどで焼けないもの(paper)、見た目は model(item_model)。
# 原石のアイテムは custom_data.test.ore = {kind, rare} だけを持つ(同じ種類・同じレア度なら重なる)。作るのは test:item/ore/build {id, rare}

data modify storage test: asset.ore set value {}
data modify storage test: asset.ore_ids set value []
function test:init/asset/ore/generated/ores
