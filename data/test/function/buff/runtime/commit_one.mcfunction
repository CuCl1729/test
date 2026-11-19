#> test:buff/runtime/commit_one
# 内部。@s = 受け手。@macro stat: ステータス名。検査の通った層の地図をそのまま得点へ写す。
# 実効値は層の核が出した値そのもの(ここで計算し直さない)。今のHP・MPは最大値が動いても触らない
$execute store result score @s test.buff.$(stat) run data get storage test: buff_layers.result.add.$(stat)
$execute store result score @s test.buff.m.$(stat) run data get storage test: buff_layers.result.m.$(stat)
$execute store result score @s test.buff.flat.$(stat) run data get storage test: buff_layers.result.flat.$(stat)
$execute store result score @s test.status.$(stat) run data get storage test: buff_layers.result.stats.$(stat)
