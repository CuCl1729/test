#> test:buff/prepare/lookup
# 内部。@macro id: バフid。レジストリの定義を work.def へ写す。
# 無いidはここで断る(生きている発生元を触る前に失敗させるため)
$execute unless data storage test: asset.buff.types[{id:"$(id)"}] run data modify storage test: buff_prepare.result set value {ok:0b,error:"unknown_buff"}
$execute if data storage test: asset.buff.types[{id:"$(id)"}] run data modify storage test: buff_prepare.work.def set from storage test: asset.buff.types[{id:"$(id)"}]
