#> test:init/asset/gather/
# 採取のレジストリ(スプレッドシートの「採取物」「採取の中身」「採取の道具」「採取ポイント」タブから生成)。
# asset.gather.<id> / asset.gather_tool.<id> / asset.gather_point.<id> と、それぞれの *_ids

data modify storage test: asset.gather set value {}
data modify storage test: asset.gather_ids set value []
data modify storage test: asset.gather_tool set value {}
data modify storage test: asset.gather_tool_ids set value []
data modify storage test: asset.gather_point set value {}
data modify storage test: asset.gather_point_ids set value []
function test:init/asset/gather/generated/gather
