#> test:magic/crafter/stage_combo_none
# @s = クラフター本体。この段の要素の組み合わせは表のどれにも当たらない(= 未定義)。
# 黙って既定動作に落とさず、理由を残して不正にする
scoreboard players set #stage_invalid test.temporary 1
data modify storage test: registry_work.invalid_reason set value "この要素の組み合わせは使えない"
