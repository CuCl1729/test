#> test:init/asset/fish/
# 釣りのレジストリ(スプレッドシートの「釣り場」「釣りの中身」タブから生成)。
# asset.fish_pool.<id> / asset.fish_pool_ids / asset.fish_token_item(目印の元のアイテム・見た目・名前)/ asset.fishing_spots

data modify storage test: asset.fish_pool set value {}
data modify storage test: asset.fish_pool_ids set value []
data modify storage test: asset.fishing_spots set value []
function test:init/asset/fish/generated/fish
