#> test:magic/crafter/place
# @s = 設置されたクラフター本体(バレルの位置)。初回描画を行う

setblock ~ ~ ~ barrel

function test:magic/crafter/populate_top
function test:magic/crafter/rebuild

tag @s remove summoned
