#> test:machine/check_core
# @s = 機械のマーカー(実行位置は核)。@macro core: 核のブロック(ほかのキーも渡ってくるが使わない)。核が無ければ1、あれば0を返す

$execute unless block ~ ~ ~ $(core) run return 1
return 0
