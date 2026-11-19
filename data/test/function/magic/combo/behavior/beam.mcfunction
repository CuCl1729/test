#> test:magic/combo/behavior/beam
# @s = 詠唱者。@macro endpoint_aoe: 1 なら行き止まりで範囲の効果も出す。
# プレイヤーが押している間だけ続くビーム。実体は持たず、毎 tick に詠唱者の目から視線方向へ
# 本数ぶんの線を引く(test:magic/beam/tick)。扇は視線を追うので、向きを覚える必要がない。
# 唱えたときの費用(消費MP)は test:magic/ が払い済み。ここから先は押していた tick ぶんの維持MPだけ
function #oh_my_dat:please

$data modify storage test: magic.player.endpoint_aoe set value $(endpoint_aoe)
execute unless function test:magic/beam/root/register run return run function test:magic/beam/stop
function test:magic/beam/link/init
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.beam set from storage test: magic.player

scoreboard players set @s test.magic.beam 1
# 請求は「押していた tick の回数」で行う。出し始めの時点までを請求済みにしておく
# (未設定のままだと作業用の値が他人のぶんを引き継ぐので、必ず個人の値として作る)
execute unless score @s test.magic.held matches -2147483648..2147483647 run scoreboard players set @s test.magic.held 0
execute unless score @s test.magic.mp_frac matches -2147483648..2147483647 run scoreboard players set @s test.magic.mp_frac 0
# この唱えた tick ぶんの held は test:magic/cont/hold で既に数えてしまっているので、
# billed をそのまま held に合わせると出し始めの1 tick ぶんが無請求になる。1引いて残しておく
scoreboard players operation @s test.magic.billed = @s test.magic.held
scoreboard players remove @s test.magic.billed 1
execute if score @s test.magic.billed matches ..-1 run scoreboard players set @s test.magic.billed 0

# 最初のダメージは「間隔を丸ごと押し続けた後」。連打で1パルスぶんを撒けないようにするため、
# ここでは間隔いっぱいから数え始める(線は押した次の tick から見える)
execute store result score @s test.device.timer run data get storage test: magic.player.continuous.period
