#> test:projectile/aimed
# @s = 持ち主。実行位置・向き = 狙いを付けた所と方向(呼び出し元が execute facing で向けている)。
# 放射と違って散らさず、本数ぶん同じ方向へ撃つ。弾はそれぞれ飛びながら自分で相手を追う
# (同じ敵を狙っていてもよい)。status.radial を立てて test:projectile/summon の再帰を止め、
# 本数はここで数える
execute store result score #aimed_count test.temporary run function test:magic/root/burst_count
execute if score #aimed_count test.temporary matches ..0 run return 0

data modify storage test: status.radial set value 1b
data modify storage test: out set value 0.0f
scoreboard players set #aimed_index test.temporary 0
function test:projectile/aimed_loop
