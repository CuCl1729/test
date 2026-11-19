#> test:magic/beam/upkeep
# @s = ビームを出しているプレイヤー。押していた tick の回数ぶん(#beam_owed)の維持MPを払う。
# 払えなければ 0 を返す(= 全部止める)。払えなかったときは何も減らさない(端数も進めない)。
#
# 表示の数値は「1本・1秒あたり」なので、1 tick ぶんは 毎秒 × 本数 ÷ 20。
# 割り切れないぶんは test.magic.mp_frac に残して持ち越す。この端数は離しても唱え直しても捨てない
# (捨てると、押してすぐ離すのを繰り返して実質無料で撃ててしまう)。
# 端数は必ずプレイヤー個人の値として読む: 未設定のままだと作業用の値が別のプレイヤーのぶんを
# 引き継いでしまうため、ここで0に作っておく
execute unless score @s test.magic.mp_frac matches -2147483648..2147483647 run scoreboard players set @s test.magic.mp_frac 0

scoreboard players set #beam_rate test.temporary 0
execute store result score #beam_rate test.temporary run data get storage test: magic.player.continuous.mp_per_second

scoreboard players operation #beam_count test.temporary = @s test.multi_shot
execute if score #beam_count test.temporary matches ..0 run scoreboard players set #beam_count test.temporary 1
scoreboard players operation #beam_rate test.temporary *= #beam_count test.temporary

# 維持MPが0(無料)に設定されているビームは、MPを見ずにそのまま続ける
execute if score #beam_rate test.temporary matches ..0 run return 1

# ここから先は維持MPが正。MPが尽きていたら、この tick の請求が切り捨てで0になる場合でも止める
# (MPが無いのにダメージを出し続けられないようにするため)
execute if score @s test.status.mp matches ..0 run return 0

# 押していた tick の回数ぶんまとめて
scoreboard players operation #beam_rate test.temporary *= #beam_owed test.temporary

scoreboard players operation #beam_acc test.temporary = @s test.magic.mp_frac
scoreboard players operation #beam_acc test.temporary += #beam_rate test.temporary

scoreboard players operation #beam_pay test.temporary = #beam_acc test.temporary
scoreboard players operation #beam_pay test.temporary /= #20 test.constant

execute if score @s test.status.mp < #beam_pay test.temporary run return 0

scoreboard players operation @s test.status.mp -= #beam_pay test.temporary
scoreboard players operation @s test.magic.mp_frac = #beam_acc test.temporary
scoreboard players operation @s test.magic.mp_frac %= #20 test.constant
return 1
