#> test:buff/ledger/fold_one
# @macro = イベント占有1件 {id,event,reason,n,unit}。
# 同じバフ・同じイベント・同じ理由・同じ機会(n)のものを1バッチにまとめる。
# 段ごとの年齢や発火地点は内訳(units[].at / units[].elapsed)に残るので、
# 年齢が違うだけの同時発生を別イベントに割らない

$execute unless data storage test: buff_ledger.events[{id:"$(id)",event:"$(event)",reason:"$(reason)",n:$(n)}] run data modify storage test: buff_ledger.events append value {id:"$(id)",event:"$(event)",reason:"$(reason)",n:$(n),count:0,units:[]}
$data modify storage test: buff_ledger.events[{id:"$(id)",event:"$(event)",reason:"$(reason)",n:$(n)}].units append from storage test: buff_ledger.work.o.unit
$execute store result storage test: buff_ledger.events[{id:"$(id)",event:"$(event)",reason:"$(reason)",n:$(n)}].count int 1 run data get storage test: buff_ledger.events[{id:"$(id)",event:"$(event)",reason:"$(reason)",n:$(n)}].units
