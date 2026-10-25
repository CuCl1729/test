#> test:equip/effect_dispatch
# @macro kind: 効果の種類。paramsをそのままマクロ引数にして test:equip/effect/<kind> を呼ぶ
# (新しい効果は equip/effect/<kind>.mcfunction を1つ書き、シリーズの宣言(init/asset/equip/sets)に足すだけでよい)

$function test:equip/effect/$(kind) with storage test: equip_work.current.params
