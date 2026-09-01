#> test:craft/magic/research/place
# @s = 設置された研究ステーション本体(バレルの位置)。初回描画を行う

setblock ~ ~ ~ barrel

data modify entity @s data.research_ui set value {page:0,has_next:0b,page_ids:[]}
function test:craft/magic/research/populate_top

tag @s remove summoned
