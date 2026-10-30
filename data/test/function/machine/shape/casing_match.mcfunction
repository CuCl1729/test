#> test:machine/shape/casing_match
# 実行位置 = 筐体のブロック。@macro id/block: 筐体の種類とブロック(ほかのキーも渡ってくるが使わない)

$execute unless block ~ ~ ~ $(block) run return 0
$data modify storage test: machine_work.casing set value "$(id)"
data modify storage test: machine_work.casing_def set from storage test: machine_work.casing_try
