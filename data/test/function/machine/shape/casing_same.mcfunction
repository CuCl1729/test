#> test:machine/shape/casing_same
# 実行位置 = 筐体のブロック。@macro block: この機械の筐体のブロック(ほかのキーも渡ってくるが使わない)。違う種類なら #machine_mixed を増やす

$execute unless block ~ ~ ~ $(block) run scoreboard players add #machine_mixed test.temporary 1
