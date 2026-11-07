#> test:magic/crafter/click_bpage
# @s = クラフター本体。@macro dir: -1(前の要素)/ 1(次の要素)。中段のページを1つ動かして描き直す(範囲は populate_build が収める)
scoreboard players set #b_page test.buff.work 0
execute store result score #b_page test.buff.work run data get entity @s data.crafter_ui.bpage
$scoreboard players operation #b_page test.buff.work += #$(dir) test.constant
execute store result entity @s data.crafter_ui.bpage int 1 run scoreboard players get #b_page test.buff.work
