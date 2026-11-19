#> test:buff/apply_source
# @s = 付与対象。@macro id: バフid / stacks: この付与元のぶんの段数 / key: 付与元のキー /
#   duration: この付与元のぶんの継続時間(秒) / initial: 1b = 場に入った初回、0b = 居続けている間の維持
# 「誰が掛けたぶんか」を分けて持つ付与(場)。同じキーで何度呼んでも段数は増えない(維持)。
# 初回だけ付与時イベントを出す。上限が空いたときだけ足りないぶんを補い、ほかの段は押し出さない。
# 後から test:buff/remove_source で、このキーのぶんだけを外せる
$execute unless data storage test: asset.buff.types[{id:"$(id)"}] run return 0
$data modify storage test: buff_runtime.arg set value {op:"maintain",id:"$(id)",count:$(stacks),src:"$(key)",duration:$(duration),initial:$(initial)}
return run function test:buff/op
