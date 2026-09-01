#> test:magic/crafter/click_clear
# @s = クラフター本体。中段の内容を全部消す

data modify entity @s data.crafter_ui.build set value []

function test:magic/crafter/rebuild
