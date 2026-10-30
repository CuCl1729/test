#> test:factory/go_tp
# @s = プレイヤー。@macro cx/cz/wall: 区画の真ん中と、床の1つ上の高さ(ほかのキーも渡ってくるが使わない)。そこへ移す

$execute in test:factory run tp @s $(cx) $(wall) $(cz)
