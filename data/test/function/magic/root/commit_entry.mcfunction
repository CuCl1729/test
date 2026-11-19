#> test:magic/root/commit_entry
# @macro id: magic_rootsのidのぶんを1回消費し、今のステージ(magic.player.root)を「数えた」ことにする。
# 元帳が無い・残りが無い場合は何もせず0を返す(呼び出し元は数えない)
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0

scoreboard players set #root_remaining test.temporary 0
$execute store result score #root_remaining test.temporary run data get storage test: magic_roots[{id:$(id)}].remaining
execute if score #root_remaining test.temporary matches ..0 run return 0

scoreboard players remove #root_remaining test.temporary 1
$execute store result storage test: magic_roots[{id:$(id)}].remaining int 1 run scoreboard players get #root_remaining test.temporary

data modify storage test: magic.player.root.counted set value 1b
return 1
