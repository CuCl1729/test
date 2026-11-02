#> test:init/asset/gather/
# 採取のレジストリ(スプレッドシートの「採取物」「道具」「ドロップ」タブから生成)。
# asset.gather.<id> / asset.gather_tool.<id> と、それぞれの *_ids。
# 採取ポイントの位置はシートではなくワールドに持つ(storage test: gather_world。エッグで置く。test:gather/egg/place)

data modify storage test: asset.gather set value {}
data modify storage test: asset.gather_ids set value []
data modify storage test: asset.gather_tool set value {}
data modify storage test: asset.gather_tool_ids set value []
function test:init/asset/gather/generated/gather
function test:gather/migrate
