#> test:buff/ledger/advance_interval_advance
# #lg_next が #lg_el を追い越すまで interval ぶん進める。
# こうしておくと1ステップで大きく時間が飛んでも発火は1回で済み、次の発火時刻がずれていかない

execute unless score #lg_next test.buff.work <= #lg_el test.buff.work run return 0

scoreboard players operation #lg_next test.buff.work += #lg_int test.buff.work

function test:buff/ledger/advance_interval_advance
