#> test:debug/rng/replay
# @macro key: 覚えているシードで乱数列test:<key>をもう一度巻き戻す(同じ操作を繰り返せば同じ結果になる)

$execute unless data storage test: debug.rng.$(key).seed run return run function test:debug/menu/done {msg:"$(key) にはシードが設定されていません。先に[シード…]で設定してください"}

$function test:debug/rng/seed with storage test: debug.rng.$(key)
