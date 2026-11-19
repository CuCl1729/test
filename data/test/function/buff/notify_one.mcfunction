#> test:buff/notify_one
# 内部。@s = 受け手。@macro id / event / reason: 台帳イベント1件。
# 付与(apply)は「状態になった」を、寿命が尽きた終了(expire, reason:"expire")だけ「切れた」を出す
# (解除・場から出た・押し出しでは出さない)。重ねがけできるバフは今の段数と上限を添える
$execute unless data storage test: asset.buff.types[{id:"$(id)"}] run return 0
$data modify storage test: buff_work.notify set from storage test: asset.buff.types[{id:"$(id)"}]
execute if data storage test: buff_work.note{event:"expire",reason:"expire"} run return run function test:buff/notify_expire with storage test: buff_work.notify
execute unless data storage test: buff_work.note{event:"apply"} run return 0

function #oh_my_dat:please
data modify storage test: buff_work.notify.stacks set value 0
$execute store result storage test: buff_work.notify.stacks int 1 run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff[{id:"$(id)"}].stacks
execute if data storage test: buff_work.notify{max_stacks:1} run return run function test:buff/notify_apply with storage test: buff_work.notify
function test:buff/notify_apply_stacked with storage test: buff_work.notify
