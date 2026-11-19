#> test:buff/events/fire_at
# 内部。的の上で動く。入り口の状態を退避し、別名(stacks/at)とマクロ引数を整えてから
# 設定された関数/タグへ渡す。予約名は同名の凍結パラメータより勝つ(消してから入れ直す)。
# 後始末は常に行う(呼び出し元の積みへ枠を戻す)

# job.target_uuid があるなら、IDを使い回した別人にはこの仕事を渡さない。
# 枠を積む前に抜けるので、枠も呼び出しも漏れない(UUIDの無い古い仕事は今までどおり素通り)
scoreboard players set #bi_match test.buff.work 1
execute if data storage test: buff_drain.job.target_uuid run data modify storage test: buff_identity.arg set value {}
execute if data storage test: buff_drain.job.target_uuid run data modify storage test: buff_identity.arg.uuid set from storage test: buff_drain.job.target_uuid
execute if data storage test: buff_drain.job.target_uuid run function test:buff/identity/matches with storage test: buff_identity.arg
execute if score #bi_match test.buff.work matches 0 run return 0

function test:buff/events/frame_push

# 的として動いているだけでは OhMyDat の参照先は移らないので、ここで的の分を選び直す
function #oh_my_dat:please

data remove storage test: buff_event
data modify storage test: buff_event set from storage test: buff_drain.job

execute store result score #buff_stacks test.buff.work run data get storage test: buff_drain.job.count
scoreboard players set #buff_at test.buff.work 0
execute store result score #buff_at test.buff.work run data get storage test: buff_drain.job.units[0].at

data remove storage test: buff_drain.args
data modify storage test: buff_drain.args set value {}
data modify storage test: buff_drain.args set from storage test: buff_drain.job.params

data remove storage test: buff_drain.args.id
data modify storage test: buff_drain.args.id set from storage test: buff_drain.job.id
data remove storage test: buff_drain.args.event
data modify storage test: buff_drain.args.event set from storage test: buff_drain.job.event
data remove storage test: buff_drain.args.reason
data modify storage test: buff_drain.args.reason set from storage test: buff_drain.job.reason
data remove storage test: buff_drain.args.target
data modify storage test: buff_drain.args.target set from storage test: buff_drain.job.target
data remove storage test: buff_drain.args.count
data modify storage test: buff_drain.args.count set from storage test: buff_drain.job.count
data remove storage test: buff_drain.args.stacks
data modify storage test: buff_drain.args.stacks set from storage test: buff_drain.job.count

# row.tag は真偽。path を #タグとして呼ぶかどうかの印なので、どちらか片方だけが走る
execute if data storage test: buff_drain.job.row.path unless data storage test: buff_drain.job.row{tag:1b} run function test:buff/events/call_path with storage test: buff_drain.job.row
execute if data storage test: buff_drain.job.row{tag:1b} run function test:buff/events/call_tag with storage test: buff_drain.job.row

# 資源の種は呼び出し先を持たないので、まとめて当てる側へ渡す。
# 値は術者ごとに評価済みで、仕事のまとまりごとにちょうど一度だけ走る
execute if data storage test: buff_drain.job.row{kind:"heal"} run function test:buff/resource/apply
execute if data storage test: buff_drain.job.row{kind:"damage"} run function test:buff/resource/apply

function test:buff/events/frame_restore
data remove storage test: buff_frames.stack[0]
