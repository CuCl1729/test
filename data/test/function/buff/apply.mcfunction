#> test:buff/apply
# @s = 付与対象。@macro id: バフid / stacks: 追加する段数(必ず指定すること)
# 新しい段を足す(段ごとに時間を持ち、上限を超えたら古い段から押し出す。BUFF_REWORK_SPEC 4)。
# レジストリに無いidは黙って無視する(付与元のtypoでエラーを撒き散らさないため)。
$execute unless data storage test: asset.buff.types[{id:"$(id)"}] run return 0
$data modify storage test: buff_runtime.arg set value {op:"grant",id:"$(id)",count:$(stacks)}
return run function test:buff/op
