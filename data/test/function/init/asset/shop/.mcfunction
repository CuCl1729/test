#> test:init/asset/shop/
# 店のレジストリ(スプレッドシートの「店」タブから生成)。asset.shop.<店> と asset.shop_ids

data modify storage test: asset.shop set value {}
data modify storage test: asset.shop_ids set value []
function test:init/asset/shop/generated/shops
