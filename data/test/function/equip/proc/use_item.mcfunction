#> test:equip/proc/use_item
# @s = プレイヤー(#oh_my_dat:please実行済み)。@macro key: 枠を見分けるキー / item: 使う消耗品のid / event: イベント。
# 予約が実行された回数を枠ごとに数え(test.equip.proc_count.<キー>。recalcで作り直す一覧の外に置くので、
# アイテムを使ったり拾ったりしても0に戻らない)、消耗品の every 回に達したら1個使う。
# 達したら、使えたかどうかに関係なく数を0に戻す。
# 使うときは先に clear を実行し、1個減らせたときだけ効果を実行する(持っているかを先に調べない)

$execute unless data storage test: asset.consumable.$(item) run return run function test:debug/log {msg:"自動使用: 消耗品「$(item)」の定義がありません"}

# 個別ストレージの参照先を自分に戻す(同じtickに先に唱えた魔法の枠が、バフの付与などで敵や味方に切り替えているため)
function #oh_my_dat:please

$execute store result score #proc_count test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.proc_count.$(key)
scoreboard players add #proc_count test.temporary 1
$execute store result score #proc_every test.temporary run data get storage test: asset.consumable.$(item).every

$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.proc_count.$(key) int 1 run scoreboard players get #proc_count test.temporary
execute if score #proc_count test.temporary < #proc_every test.temporary run return 0

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.proc_count.$(key) set value 0

scoreboard players set #consumable_used test.temporary 0
$execute store success score #consumable_used test.temporary run clear @s *[custom_data~{test:{consumable:"$(item)"}}] 1
$execute if score #consumable_used test.temporary matches 0 run return run function test:debug/log {msg:"自動使用: 消耗品「$(item)」を持っていない($(key)・$(event))"}

$function test:consumable/use {id:"$(item)"}
$function test:debug/log {msg:"自動使用: 消耗品「$(item)」を使った($(key)・$(event))"}
