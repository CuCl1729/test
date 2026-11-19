#> test:buff/op
# @s = 受け手。storage test: buff_runtime.arg(test:buff/runtime/operate と同じ形)を1回ぶん行い、
# 付与・自然終了の通知と頭上のアイコンを出す。test:buff/apply・apply_source・remove_source・clear・step の共通の出口。
# 古い形式のバフが残っていれば先に移す(test:buff/migrate)。成功で 1、断られたら 0
#
# 利用者の関数は submit の中で配られる。その中で別のバフを付けても、通知の一覧は submit が
# 戻ってから読むので混ざらない

function test:buff/migrate
execute store result score #bo_ok test.buff.work run function test:buff/events/submit
execute if score #bo_ok test.buff.work matches 0 run return 0

data modify storage test: buff_work.notes set from storage test: buff_runtime.result.events
function test:buff/notify_loop

function #oh_my_dat:please
data modify storage test: buff_work.list set value []
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff[0] run data modify storage test: buff_work.list set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff
function test:buff/refresh_icons
return 1
