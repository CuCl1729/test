# @s = 撃つ人(詠唱者)。実行位置・向き = 撃ち出す所。
# 複数発射の数はプレイヤーの設定(test.multi_shot)。初回ログイン時に 1 を入れているが、
# その仕組みより前から居るプレイヤーは 0 のままなので、ここで 1 に直す(0 本になるのを防ぐ)
execute unless score @s test.multi_shot matches 1.. run scoreboard players set @s test.multi_shot 1

# 狙いを付けて撃つ(追尾の設置物)。向きはもう決まっているので散らさない
execute if data storage test: status{aimed:1b} run return run function test:projectile/aimed
# 設置物や弾から撃つ(水平の放射。持ち主の位置やカメラによらない)
execute if data storage test: status{radial:1b} run return run function test:projectile/radial

scoreboard players operation @s test.temporary = @s test.multi_shot
scoreboard players add @s test.temporary 1

# 扇の幅(度)はスプレッドシートの「定数」タブ(asset.config.magic_fan_angle)。#angle は度 × 100
execute store result score #angle test.temporary run data get storage test: asset.config.magic_fan_angle 100
scoreboard players operation #angle test.temporary /= @s test.temporary

scoreboard players reset @s test.repeat

# tan(#angle)をcomputeで求める(定義はcontext_float_provider/projectile/spread_tan)。
# #dummyはtan×100、storage test: outはtest:projectile/summonが$(out)として使うtanの値
execute store result score #dummy test.temporary run compute default float test:projectile/spread_tan 100
execute store result storage test: out double 0.0001 run compute default float test:projectile/spread_tan 10000

scoreboard players remove @s test.temporary 2
scoreboard players operation @s test.temporary *= #5 test.constant

execute store result storage test: teleport float -0.001 run scoreboard players operation #dummy test.temporary *= @s test.temporary

# 弾の向きは「撃った人と反対向き」で決める。いちばん近いプレイヤーではなく撃った本人を見るため、
# 一時タグで本人を指しておく(2人目が自分より近いと向きが狂う・反転する)
tag @s add shot_caster
function test:projectile/pre_summon with storage test:
tag @s remove shot_caster
