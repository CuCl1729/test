#> test:buff/ledger/refuse
# 連番を使い切っていて、新しい段に表せる番号を割り当てられない。
# 台帳には一切触らずに断る(押し出しも部分的な付与もしない)。
# 古い段を捨てたり番号を巻き戻したりはしない。呼び出し側は status を見て諦めるか作り直す

data modify storage test: buff_ledger.status set value "seq_exhausted"

function test:buff/ledger/end
