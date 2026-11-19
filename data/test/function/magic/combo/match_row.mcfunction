#> test:magic/combo/match_row
# 表の1行が今の組み合わせに当たるかを見る。@macro apply / emitter: その行の適用と発生元
# (ほかのキーも渡ってくるが、require / forbid は combo_work.row から読む)

# 適用(段 / つなぎ)が違う行は見ない
$execute unless data storage test: combo_work{apply:"$(apply)"} run return 0

# 発生元。any はどこからでも当たる
scoreboard players set #combo_emit test.temporary 0
execute if data storage test: combo_work.row{emitter:"any"} run scoreboard players set #combo_emit test.temporary 1
$execute if data storage test: combo_work{emitter:"$(emitter)"} run scoreboard players set #combo_emit test.temporary 1
execute if score #combo_emit test.temporary matches 0 run return 0

scoreboard players set #combo_ok test.temporary 1

# 必須要素はすべて入っていること。ほかの要素が増えてもこの行は無効にならない(部分一致)
data modify storage test: combo_work.need set from storage test: combo_work.row.require
function test:magic/combo/require_loop
execute if score #combo_ok test.temporary matches 0 run return 0

# 禁止要素は1つでも入っていたら当たらない
data modify storage test: combo_work.ban set from storage test: combo_work.row.forbid
function test:magic/combo/forbid_loop
execute if score #combo_ok test.temporary matches 0 run return 0

data modify storage test: combo_work.hit set from storage test: combo_work.row
scoreboard players set #combo_found test.temporary 1
return 1
