#> test:magic/registry/known_check
# @s = 判定対象のプレイヤー(呼び出し前にfunction #oh_my_dat:pleaseを@sとして実行済みであること)
# @macro id: 習得済みか調べる要素id
# 結果を #known test.temporary に 0/1 で返す

scoreboard players set #known test.temporary 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.known{$(id):1b} run scoreboard players set #known test.temporary 1
