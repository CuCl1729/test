#> test:buff/ledger/begin
# 各操作の最初に呼ぶ。出力(status/events/next_seq)と内部作業領域を初期化する。
# 台帳そのものは呼び出し側が読み込んで置く(無ければ空として扱う)

data modify storage test: buff_ledger.status set value "ok"
data modify storage test: buff_ledger.events set value []
data remove storage test: buff_ledger.next_seq
data modify storage test: buff_ledger.work set value {occ:[],in:[],out:[],exp:[],scan:[],tocc:[]}

execute unless data storage test: buff_ledger.ledger run data modify storage test: buff_ledger.ledger set value []

# 連番を使わない操作(削除・時間進行)では next_seq を出さない目印
scoreboard players set #lg_seq test.buff.work -1
# 維持更新で「初回ではない」とき、足した段の apply を出さないための目印
scoreboard players set #lg_quiet test.buff.work 0
scoreboard players set #lg_drop test.buff.work 0
scoreboard players set #lg_excess test.buff.work 0
