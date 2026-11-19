#> test:buff/remove_source
# @s = 対象。@macro id: バフid / key: 外す付与元のキー(ほかのキーも渡ってくるが使わない)。
# その付与元が掛けた段だけを外す(終了イベントは出る)。ほかの付与元や、ふつうに掛けた段は残る
$data modify storage test: buff_runtime.arg set value {op:"remove_source",id:"$(id)",src:"$(key)"}
return run function test:buff/op
