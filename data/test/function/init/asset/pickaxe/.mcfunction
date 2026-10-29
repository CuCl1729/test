#> test:init/asset/pickaxe/
# ツルハシのレジストリ。asset.pickaxe.<id> = {item, name, rank, speed, blocks}(スプレッドシートの「ツルハシ」タブから生成)。
# 作るのは test:item/pickaxe/build {id}

data modify storage test: asset.pickaxe set value {}
data modify storage test: asset.pickaxe_ids set value []
function test:init/asset/pickaxe/generated/pickaxes
