#> test:item/weapon/lore/stat_parts
# @macro type/sign: ステータスの種類と符号("" / "+")。値はstorage test: lore_work.stat.valueから読む。
# 「アイコン 名前 符号 値 単位」を作りかけの行(lore_work.line)に足す(行は始めず、確定もしない)。
# 1行に1ステータスなら test:item/weapon/lore/stat_line、ルーンの枠のように1行に並べるときはこれを直接使う

$data modify storage test: lore_work.def set from storage test: loot.table.stat_display[{type:"$(type)"}]

function test:item/weapon/lore/part_label with storage test: lore_work.def
$data modify storage test: lore_work.line append value {text:"$(sign)",color:"aqua"}

data modify storage test: lore_work.n set from storage test: lore_work.stat.value
function test:item/weapon/lore/num
function test:item/weapon/lore/part_unit with storage test: lore_work.def
