#> test:buff/apply
# @s = 付与対象。@macro id: バフid / stacks: 追加するスタック数(必ず指定すること)

# レジストリに無いidは黙って無視する(付与元のtypoでエラーを撒き散らさないため)
$execute unless data storage test: asset.buff.types[{id:"$(id)"}] run return 0

$data modify storage test: buff_work.arg set from storage test: asset.buff.types[{id:"$(id)"}]
$data modify storage test: buff_work.arg.add set value $(stacks)

function test:buff/load
function test:buff/apply_entry with storage test: buff_work.arg

# 再付与の挙動がignoreで既に掛かっていた場合など、何も変わらなかったときはここで終わり
execute if score #applied test.buff.work matches 0 run return 0

function test:buff/save
function test:buff/refresh_icons

# 通知とイベントは個別ストレージへ書き戻したあとに出す。イベント関数の中から
# buff/applyやbuff/removeが呼ばれても(=内側でoh_my_dat:pleaseを呼び直しても)壊れないようにするため
# 重ねがけできるバフは「x2/3」のように現在のスタック数と上限を出す。
# 上限に達していることが分かるようにするため(重ねがけしないバフは今まで通り名前だけ)
execute store result storage test: buff_work.arg.stacks int 1 run scoreboard players get #new_stacks test.buff.work

execute if score #max_stacks test.buff.work matches ..1 run function test:buff/notify_apply with storage test: buff_work.arg
execute if score #max_stacks test.buff.work matches 2.. run function test:buff/notify_apply_stacked with storage test: buff_work.arg

# 掛け直しの場合は、まず古いスタック数で終了イベントを出してから新しいスタック数で付与イベントを出す。
# こうするとイベント関数側は「applyで足したぶんをexpireで戻す」と書くだけで済み、
# 重ねがけしても増減の数が合わなくなることがない
$execute if score #old_stacks test.buff.work matches 1.. run data modify storage test: buff_work.fire append value {event:"expire",id:"$(id)",stacks:1,reason:"refresh",at:0}
execute if score #old_stacks test.buff.work matches 1.. store result storage test: buff_work.fire[-1].stacks int 1 run scoreboard players get #old_stacks test.buff.work

$data modify storage test: buff_work.fire append value {event:"apply",id:"$(id)",stacks:1,reason:"apply",at:0}
execute store result storage test: buff_work.fire[-1].stacks int 1 run scoreboard players get #new_stacks test.buff.work

function test:buff/fire_loop
