#> test:equip/proc/use_item
# @s = プレイヤー(#oh_my_dat:please実行済み)。@macro key: 枠を見分けるキー / item: 使う消耗品のid / event: イベント。
# 予約が実行された回数を枠ごとに数え(test.equip.proc_count.<キー>。recalcで作り直す一覧の外に置くので、
# アイテムを使ったり拾ったりしても0に戻らない)、消耗品の every 回に達したら1個使う(test:equip/proc/consume)。
# 達したら、使えたかどうかに関係なく数を0に戻す。
# イベントが instant(asset.equip.proc_events)なら、数えずに毎回使う

$execute unless data storage test: asset.consumable.$(item) run return run function test:debug/log {msg:"自動使用: 消耗品「$(item)」の定義がありません"}

# 個別ストレージの参照先を自分に戻す(同じtickに先に唱えた魔法の枠が、バフの付与などで敵や味方に切り替えているため)
function #oh_my_dat:please

$execute if data storage test: asset.equip.proc_events[{id:"$(event)",instant:1b}] run return run function test:equip/proc/consume {key:"$(key)",item:"$(item)",event:"$(event)"}

$execute store result score #proc_count test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.proc_count.$(key)
scoreboard players add #proc_count test.temporary 1
$execute store result score #proc_every test.temporary run data get storage test: asset.consumable.$(item).every

$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.proc_count.$(key) int 1 run scoreboard players get #proc_count test.temporary
execute if score #proc_count test.temporary < #proc_every test.temporary run return 0

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.proc_count.$(key) set value 0
$function test:equip/proc/consume {key:"$(key)",item:"$(item)",event:"$(event)"}
