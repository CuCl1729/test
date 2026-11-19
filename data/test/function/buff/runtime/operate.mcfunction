#> test:buff/runtime/operate
# @s = 効果を受ける側(recipient)。storage test: buff_runtime.arg =
#   {op:"grant"|"maintain"|"advance"|"remove"|"remove_source"|"clear",
#    id?,count?,src?,caster?,last_refs?,duration?,step?,initial?}
#   新形式(buff_state version 2)だけを相手にする、1回ぶんの完結した取引。
#   成功: storage test: buff_runtime.result = {ok:1b,events:[受け手を添えた台帳イベントの写し]} で 1
#   失敗: {ok:0b,error:"<理由>",events:[]} で 0。途中まで成功した地図は作らない
#
#   正本は OhMyDat の .test.buff_state = {version:2,next_seq:1,ledger:[段のまとまり,…]}。
#   .test.buff は表示用の写しで、buff_state があるときは正本ではない。
#   この単位では利用者の関数・通知・リソース・属性修飾子には一切触らない(ディスパッチは後の単位)
#
# arg は読むだけ。作業域は buff_runtime.work、buff_ledger / buff_prepare / buff_actor /
# buff_layers / buff_eval / buff_math は呼び先の作業域として上書きされる。buff_work と
# 公開イベントの文脈には触らない

function #oh_my_dat:please

data remove storage test: buff_runtime.result
data modify storage test: buff_runtime.work set value {view:[],err:"unknown_op"}
data modify storage test: buff_runtime.work.arg set from storage test: buff_runtime.arg

# 操作名から関数名を組むので、受け付けるものだけを白名簿にする
scoreboard players set #rt_op test.buff.work 0
execute if data storage test: buff_runtime.work.arg{op:"grant"} run scoreboard players set #rt_op test.buff.work 1
execute if data storage test: buff_runtime.work.arg{op:"maintain"} run scoreboard players set #rt_op test.buff.work 2
execute if data storage test: buff_runtime.work.arg{op:"remove"} run scoreboard players set #rt_op test.buff.work 3
execute if data storage test: buff_runtime.work.arg{op:"remove_source"} run scoreboard players set #rt_op test.buff.work 4
execute if data storage test: buff_runtime.work.arg{op:"advance"} run scoreboard players set #rt_op test.buff.work 5
execute if data storage test: buff_runtime.work.arg{op:"clear"} run scoreboard players set #rt_op test.buff.work 6
execute if score #rt_op test.buff.work matches 0 run return run function test:buff/runtime/refuse

# 読めない版・まだ変換していない旧形式は、何も壊さずに断る(変換器は後の単位)
data modify storage test: buff_runtime.work.err set value "unsupported_version"
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state{version:2} run return run function test:buff/runtime/refuse
data modify storage test: buff_runtime.work.err set value "migration_required"
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff[0] run return run function test:buff/runtime/refuse

# 正本は値の写しで読む(途中で断っても元の正本はそのまま)
data modify storage test: buff_runtime.work.state set value {version:2,next_seq:1,ledger:[]}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state run data modify storage test: buff_runtime.work.state set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state
execute unless data storage test: buff_runtime.work.state.ledger run data modify storage test: buff_runtime.work.state.ledger set value []
execute unless data storage test: buff_runtime.work.state.next_seq run data modify storage test: buff_runtime.work.state.next_seq set value 1
scoreboard players set #rt_oldseq test.buff.work 1
execute store result score #rt_oldseq test.buff.work run data get storage test: buff_runtime.work.state.next_seq

# id を使う操作で id が無いのは、知らないバフと同じ扱い(台帳のマクロを欠けた引数で呼ばない)
data modify storage test: buff_runtime.work.err set value "unknown_buff"
execute if score #rt_op test.buff.work matches 1..4 unless data storage test: buff_runtime.work.arg.id run return run function test:buff/runtime/refuse

# 作成系だけ、今のレジストリの定義を引く。削除・時間進行は定義が消えていても保存済みの段を片付ける
data remove storage test: buff_prepare.result
execute if score #rt_op test.buff.work matches 1..2 run function test:buff/prepare/lookup with storage test: buff_runtime.work.arg
execute if data storage test: buff_prepare.result run return run function test:buff/runtime/refuse
execute if score #rt_op test.buff.work matches 1..2 run data modify storage test: buff_runtime.work.def set from storage test: buff_prepare.work.def

data modify storage test: buff_ledger.arg set value {}
execute if score #rt_op test.buff.work matches 1..2 run function test:buff/runtime/arg_create
execute if score #rt_op test.buff.work matches 3..4 run data modify storage test: buff_ledger.arg.id set from storage test: buff_runtime.work.arg.id
execute if score #rt_op test.buff.work matches 4 run data modify storage test: buff_ledger.arg.src set value "-"
execute if score #rt_op test.buff.work matches 4 if data storage test: buff_runtime.work.arg.src run data modify storage test: buff_ledger.arg.src set from storage test: buff_runtime.work.arg.src
execute if score #rt_op test.buff.work matches 5 run data modify storage test: buff_ledger.arg.step set value 0
execute if score #rt_op test.buff.work matches 5 if data storage test: buff_runtime.work.arg.step run data modify storage test: buff_ledger.arg.step set from storage test: buff_runtime.work.arg.step

# 定義が無いまま断られたときに備えて、ここまでの作業域は捨てる
data modify storage test: buff_runtime.work.err set value "invalid_definition"
execute if score #rt_op test.buff.work matches 1..2 unless data storage test: buff_ledger.arg.duration run return run function test:buff/runtime/refuse

# 純粋な台帳の遷移を、候補の台帳に対してだけ走らせる
data modify storage test: buff_ledger.ledger set from storage test: buff_runtime.work.state.ledger
function test:buff/runtime/dispatch with storage test: buff_runtime.work.arg

data modify storage test: buff_runtime.work.err set value "seq_exhausted"
execute if data storage test: buff_ledger{status:"seq_exhausted"} run return run function test:buff/runtime/refuse

# 連番を使わない操作では台帳が next_seq を出さないので、正本のものを引き継ぐ
scoreboard players operation #rt_newseq test.buff.work = #rt_oldseq test.buff.work
execute if data storage test: buff_ledger.next_seq store result score #rt_newseq test.buff.work run data get storage test: buff_ledger.next_seq

# 新しい連番が出たときだけ、掛けた時点の発生元で効果を固定する。
# 時間だけの維持・縮小・上限で足せなかったときは prepare を呼ばず、発生元も要求しない
scoreboard players set #rt_ok test.buff.work 1
execute if score #rt_newseq test.buff.work > #rt_oldseq test.buff.work store result score #rt_ok test.buff.work run function test:buff/runtime/freeze
execute if score #rt_ok test.buff.work matches 0 run return run function test:buff/runtime/refuse

# 受け身の取り分と層の集計。1つでも範囲外なら、正本・得点・表示用・イベントのどれも触らずに断る
data modify storage test: buff_runtime.work.err set value "out_of_range"
execute store result score #rt_ok test.buff.work run function test:buff/actor/passives
execute if score #rt_ok test.buff.work matches 0 if score #ba_err test.buff.work matches 2 run data modify storage test: buff_runtime.work.err set value "gear_unavailable"
execute if score #rt_ok test.buff.work matches 0 run return run function test:buff/runtime/refuse

data modify storage test: buff_layers.arg set value {}
data modify storage test: buff_layers.arg.passives set from storage test: buff_actor.passives
data modify storage test: buff_layers.arg.ledger set from storage test: buff_ledger.ledger
function test:buff/layers/evaluate
execute if data storage test: buff_layers.result{ok:0b} run data modify storage test: buff_runtime.work.err set from storage test: buff_layers.result.error
execute if data storage test: buff_layers.result{ok:0b} run return run function test:buff/runtime/refuse

# ネイティブの属性に入れる合計も、書き込む前に候補の台帳で試しておく。
# ここで断れば、正本・得点・表示用・イベントのどれも触らないまま終われる
data modify storage test: buff_native.arg set value {ledger:[]}
data modify storage test: buff_native.arg.ledger set from storage test: buff_ledger.ledger
function test:buff/native/evaluate
execute if data storage test: buff_native.result{ok:0b} run data modify storage test: buff_runtime.work.err set from storage test: buff_native.result.error
execute if data storage test: buff_native.result{ok:0b} run return run function test:buff/runtime/refuse

# ここから先は書き込みだけ。すべて検査の通った地図からの写し
data modify storage test: buff_runtime.work.stats set from storage test: buff_actor.passives
function test:buff/runtime/commit_loop

# 表示用の一覧は正本から組み直す(隠した段は作らない)
data modify storage test: buff_runtime.work.groups set from storage test: buff_ledger.ledger
function test:buff/runtime/view_loop

# 他人の参照値を取る間にカーソルが動いているので、受け手へ戻してから保存する。
# 空になっても version と next_seq は残す(消しても時系列が巻き戻らないようにするため)
# 正本は途中で欠けた姿を見せないよう、作業側で丸ごと組んでから一度に写す
data modify storage test: buff_runtime.work.state set value {version:2}
execute store result storage test: buff_runtime.work.state.next_seq int 1 run scoreboard players get #rt_newseq test.buff.work
data modify storage test: buff_runtime.work.state.ledger set from storage test: buff_ledger.ledger
function #oh_my_dat:please
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state set from storage test: buff_runtime.work.state
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff set from storage test: buff_runtime.work.view

tag @s remove buffed
execute if data storage test: buff_ledger.ledger[0] run tag @s add buffed

# 出力は受け手を添えた台帳イベントの写し。保存が終わってから見せる
execute store result storage test: buff_runtime.work.target int 1 run scoreboard players get @s OhMyDatID
data modify storage test: buff_runtime.work.events set from storage test: buff_ledger.events
# 空の一覧に [] へ書くと要素が生まれてしまうので、イベントがあるときだけ受け手を添える
execute if data storage test: buff_runtime.work.events[0] run data modify storage test: buff_runtime.work.events[].target set from storage test: buff_runtime.work.target
# IDは死んだ非プレイヤーのぶんが使い回されるので、本物の身元も添える(あとで的を取り違えないため)
execute if data storage test: buff_runtime.work.events[0] run data modify storage test: buff_runtime.work.events[].target_uuid set from entity @s UUID

data modify storage test: buff_runtime.result set value {ok:1b}
data modify storage test: buff_runtime.result.events set from storage test: buff_runtime.work.events
data remove storage test: buff_runtime.work
return 1
