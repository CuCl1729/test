#> test:magic/combo/behavior/aimed
# @s = 持ち主。実行位置 = 撃つ所(設置物や飛んでいる弾の位置)。
# 狙える敵が居れば、発生源から見て一番近いものへ向けて本数ぶん撃つ(弾はそれぞれ飛びながら
# 自分で相手を追う。同じ敵を狙っていてもよい)。居なければ放射に落として飛びながら探させる。
# 狙いは発生源の位置だけで決まり、持ち主の位置やカメラにはよらない
execute store result score #aim_found test.temporary run function test:magic/homing/aim with storage test: magic.player.homing
execute if score #aim_found test.temporary matches 0 run return run function test:magic/combo/behavior/radial

data modify storage test: magic.player.aimed set value 1b
execute facing entity @e[tag=homing_target,limit=1] eyes run function test:magic/projectile/cast
tag @e remove homing_target
