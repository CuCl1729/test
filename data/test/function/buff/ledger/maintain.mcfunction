#> test:buff/ledger/maintain
# @macro = buff_ledger.arg {id,count,src,caster,seq,duration,max_stacks,initial?,policy?,eff?,interval?,timers?}
# 場のような「同じ付与元からの維持更新」。count はその付与元が持ちたい段数(増分ではない)。
# 既に持っている段は身元も時計もそのままに、残り時間と捕まえ直した値だけ入れ直す(イベントは出さない)。
# 多すぎれば古い段から終わらせ(新しい段を残す)、足りなければ足す。count:0 はその付与元を全部終わらせる
# (ふつうの付与 grant の「0は何もしない」はそのまま)。
# initial:0b = 継続中の維持更新。足した段でも apply を出さない(付与時イベントは場に入った初回だけ)。
# initial:1b または省略 = その場への初回侵入として扱う

function test:buff/ledger/begin

$scoreboard players set #lg_seq test.buff.work $(seq)
$scoreboard players set #lg_count test.buff.work $(count)
execute if data storage test: buff_ledger.arg{initial:0b} run scoreboard players set #lg_quiet test.buff.work 1

$scoreboard players set #lg_max test.buff.work $(max_stacks)
execute if score #lg_max test.buff.work matches ..0 run scoreboard players set #lg_max test.buff.work 1

# ここから台帳を触る前の下見。この付与元が今いくつ持っているかと、バフ全体の段数を数える
scoreboard players set #lg_total test.buff.work 0
$execute store result score #lg_total test.buff.work run data get storage test: buff_ledger.ledger[{id:"$(id)"}].units
scoreboard players set #lg_have test.buff.work 0
data modify storage test: buff_ledger.work.scan set value []
$data modify storage test: buff_ledger.work.scan set from storage test: buff_ledger.ledger[{id:"$(id)"}].units
function test:buff/ledger/maintain_count_loop with storage test: buff_ledger.arg

# 多すぎるぶん(古い段から終わらせる)と、足りないぶん(空いている上限の範囲まで足す)。
# 維持更新でほかの付与元を押し出すと、毎パルス押し出し合いになってしまう
scoreboard players operation #lg_excess test.buff.work = #lg_have test.buff.work
scoreboard players operation #lg_excess test.buff.work -= #lg_count test.buff.work
execute if score #lg_excess test.buff.work matches ..0 run scoreboard players set #lg_excess test.buff.work 0
scoreboard players operation #lg_new test.buff.work = #lg_count test.buff.work
scoreboard players operation #lg_new test.buff.work -= #lg_have test.buff.work
execute if score #lg_new test.buff.work matches ..0 run scoreboard players set #lg_new test.buff.work 0
scoreboard players operation #lg_room test.buff.work = #lg_max test.buff.work
scoreboard players operation #lg_room test.buff.work -= #lg_total test.buff.work
execute if score #lg_new test.buff.work > #lg_room test.buff.work run scoreboard players operation #lg_new test.buff.work = #lg_room test.buff.work
execute if score #lg_new test.buff.work matches ..0 run scoreboard players set #lg_new test.buff.work 0

# 連番が足りるかを、台帳を一切触る前に確かめる(grant と同じ扱い)
scoreboard players set #lg_cap test.buff.work 2147483647
scoreboard players operation #lg_cap test.buff.work -= #lg_new test.buff.work
execute if score #lg_seq test.buff.work > #lg_cap test.buff.work run return run function test:buff/ledger/refuse

$execute unless data storage test: buff_ledger.ledger[{id:"$(id)"}] run data modify storage test: buff_ledger.ledger append value {id:"$(id)",units:[]}

# この付与元のぶんを入れ直す(並び順はそのまま)。減ったぶんはここで終了イベントになる
data modify storage test: buff_ledger.work.ev set value {event:"expire",reason:"remove"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.arg.id
data modify storage test: buff_ledger.work.in set value []
$data modify storage test: buff_ledger.work.in set from storage test: buff_ledger.ledger[{id:"$(id)"}].units
data modify storage test: buff_ledger.work.out set value []
function test:buff/ledger/maintain_loop with storage test: buff_ledger.arg
$data modify storage test: buff_ledger.ledger[{id:"$(id)"}].units set from storage test: buff_ledger.work.out

execute if data storage test: buff_ledger.arg{policy:"refresh_all"} run function test:buff/ledger/refresh with storage test: buff_ledger.arg

data modify storage test: buff_ledger.work.ev set value {event:"apply",reason:"maintain"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.arg.id
function test:buff/ledger/add_loop with storage test: buff_ledger.arg

# 1段も残らなかったときは空のバフを残さない
$execute unless data storage test: buff_ledger.ledger[{id:"$(id)"}].units[0] run data remove storage test: buff_ledger.ledger[{id:"$(id)"}]

function test:buff/ledger/end
