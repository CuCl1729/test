#> test:magic/crafter/click_build
# @s = クラフター本体。@macro index: 取られた中段のスロットの位置(0〜8)。実際の位置(ページ bpage × 9 + index)の
# 1件だけ取り除く(NBTのリスト削除で残りは自動的に詰まる)。上段の表示は変わらないので無関係
scoreboard players set #b_index test.buff.work 0
execute store result score #b_index test.buff.work run data get entity @s data.crafter_ui.bpage
scoreboard players operation #b_index test.buff.work *= #9 test.constant
$scoreboard players add #b_index test.buff.work $(index)
data modify storage test: registry_work.b_remove set value {i:0}
execute store result storage test: registry_work.b_remove.i int 1 run scoreboard players get #b_index test.buff.work
function test:magic/crafter/click_build_remove with storage test: registry_work.b_remove
