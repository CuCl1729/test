#> test:equip/effect_dispatch
# @macro kind: 効果の種類。paramsをそのままマクロ引数にして test:equip/effect/<kind> を呼ぶ
# (新しい効果は equip/effect/<kind>.mcfunction を1つ書き、スプレッドシートの「4部位効果」タブに1行足して
#  tools/datasheet/generate.ps1 で再生成するだけでよい。必要なparamsは、この関数の$(…)から生成スクリプトが読み取って検証する)

$function test:equip/effect/$(kind) with storage test: equip_work.current.params
