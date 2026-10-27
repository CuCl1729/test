#> test:station/place
# @s = 設置された(または樽が無くなった)ステーションのマーカー。樽を置き、飾りを付け、今のモードに入る

setblock ~ ~ ~ barrel
function test:station/decorate_by_id with entity @s data.station
function test:station/enter_mode

tag @s remove summoned
