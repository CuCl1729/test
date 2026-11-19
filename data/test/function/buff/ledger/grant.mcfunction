#> test:buff/ledger/grant
# @macro = buff_ledger.arg {id,count,src,caster,seq,duration,max_stacks,policy?,eff?,interval?,timers?}
# ふつうの再付与。段を増やし、上限を超えたぶんは古い段から押し出して捨てる。
# 押し出した段は待機させず、新しい段が切れても復活しない。
# 契約と各フィールドの意味は requests/buff-ledger/contract.md を参照

function test:buff/ledger/begin

$scoreboard players set #lg_seq test.buff.work $(seq)
$scoreboard players set #lg_count test.buff.work $(count)
execute if score #lg_count test.buff.work matches ..0 run return run function test:buff/ledger/end

# 上限の書き忘れで0段にならないよう最低1は保証する
$scoreboard players set #lg_max test.buff.work $(max_stacks)
execute if score #lg_max test.buff.work matches ..0 run scoreboard players set #lg_max test.buff.work 1

# 採用する新しい段。上限を超えるぶんは一度も有効にならないので expire も出さない
scoreboard players operation #lg_new test.buff.work = #lg_count test.buff.work
execute if score #lg_new test.buff.work > #lg_max test.buff.work run scoreboard players operation #lg_new test.buff.work = #lg_max test.buff.work

# 連番が足りるかを、台帳を一切触る前に確かめる。
# 足りないまま進めると負の連番に巻き戻り、新旧の前後関係が壊れてしまう
scoreboard players set #lg_cap test.buff.work 2147483647
scoreboard players operation #lg_cap test.buff.work -= #lg_new test.buff.work
execute if score #lg_seq test.buff.work > #lg_cap test.buff.work run return run function test:buff/ledger/refuse

$execute unless data storage test: buff_ledger.ledger[{id:"$(id)"}] run data modify storage test: buff_ledger.ledger append value {id:"$(id)",units:[]}

# 押し出す古い段の数 = 既存 + 採用 - 上限
scoreboard players set #lg_evict test.buff.work 0
$execute store result score #lg_evict test.buff.work run data get storage test: buff_ledger.ledger[{id:"$(id)"}].units
scoreboard players operation #lg_evict test.buff.work += #lg_new test.buff.work
scoreboard players operation #lg_evict test.buff.work -= #lg_max test.buff.work

# 古い段の終了を、新しい段の付与より先に積む
data modify storage test: buff_ledger.work.ev set value {event:"expire",reason:"cap"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.arg.id
execute if score #lg_evict test.buff.work matches 1.. run function test:buff/ledger/evict_loop with storage test: buff_ledger.arg

# refresh_all は新しい段が採用されたときだけ、残っている段の残り時間だけを戻す
execute if data storage test: buff_ledger.arg{policy:"refresh_all"} run function test:buff/ledger/refresh with storage test: buff_ledger.arg

data modify storage test: buff_ledger.work.ev set value {event:"apply",reason:"grant"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.arg.id
function test:buff/ledger/add_loop with storage test: buff_ledger.arg

function test:buff/ledger/end
