#> test:init/asset/mine/
# 鉱山のレジストリ。asset.mine.<id>(スプレッドシートの「鉱山」タブから生成。中身は generated/mines の見出しを参照)

data modify storage test: asset.mine set value {}
data modify storage test: asset.mine_ids set value []
function test:init/asset/mine/generated/mines
