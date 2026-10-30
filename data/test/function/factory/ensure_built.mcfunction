#> test:factory/ensure_built
# @macro n/x0/z0/x1/z1/floor/wall/ceil/cx/cz: 区画(test:factory/plot_area が作る factory_work.plot)。
# 区画ができていれば1を返す。まだなら、区画のチャンクを forceload し(ずっとそのまま。誰もいなくても機械が動く)、
# 読み込まれていれば床・壁・天井を置いて記録し(factory_state.built.p<n>)、1を返す。
# forceload した直後は同じtickではまだ読み込まれていないことがあるので、そのときは0を返す(呼び出し側が次のtick以降に試し直す)。
# 床は岩盤、壁(一番外側の列)と天井はバリア。どちらもサバイバルで壊せないので、区画の外へは出られない

$execute if data storage test: factory_state.built.p$(n) run return 1

$execute in test:factory run forceload add $(x0) $(z0) $(x1) $(z1)
$execute in test:factory unless loaded $(x0) $(floor) $(z0) run return 0
$execute in test:factory unless loaded $(x1) $(floor) $(z1) run return 0
$execute in test:factory unless loaded $(cx) $(floor) $(cz) run return 0

$execute in test:factory run fill $(x0) $(floor) $(z0) $(x1) $(floor) $(z1) minecraft:bedrock
$execute in test:factory run fill $(x0) $(wall) $(z0) $(x1) $(ceil) $(z0) minecraft:barrier
$execute in test:factory run fill $(x0) $(wall) $(z1) $(x1) $(ceil) $(z1) minecraft:barrier
$execute in test:factory run fill $(x0) $(wall) $(z0) $(x0) $(ceil) $(z1) minecraft:barrier
$execute in test:factory run fill $(x1) $(wall) $(z0) $(x1) $(ceil) $(z1) minecraft:barrier
$execute in test:factory run fill $(x0) $(ceil) $(z0) $(x1) $(ceil) $(z1) minecraft:barrier
$data modify storage test: factory_state.built.p$(n) set value 1b
$function test:debug/log {msg:"工場の区画 $(n) を作った"}
return 1
