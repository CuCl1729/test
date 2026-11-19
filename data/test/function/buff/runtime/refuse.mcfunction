#> test:buff/runtime/refuse
# 内部。断るときの出口。正本・得点・表示用・buffedタグには一切触らず、events は空で返す。
# 他人の参照値を取る途中だったときのために、受け手の OhMyDat のカーソルを戻してから抜ける

function #oh_my_dat:please

data modify storage test: buff_runtime.result set value {ok:0b,events:[]}
data modify storage test: buff_runtime.result.error set from storage test: buff_runtime.work.err
data remove storage test: buff_runtime.work
return 0
