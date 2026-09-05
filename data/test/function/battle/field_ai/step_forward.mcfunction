#> test:battle/field_ai/step_forward
# @s = 敵(呼び出し元が向きを設定済み)。@macro dist: 前進量
# 目の前(と1つ上)が空気でなければ進まない(簡易的な障害物回避のみ。経路探索はしない)

execute unless block ^ ^ ^1 #minecraft:air run return 0
execute unless block ^ ^1 ^1 #minecraft:air run return 0

$tp @s ^ ^ ^$(dist)
