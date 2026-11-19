#> test:magic/cont/hold
# @s = 詠唱者。継続の魔法を押し続けていることを記録する。
# 右クリックの検知(using_item)は押している間ずっと毎 tick 来るので、ここが途切れたら「離した」と分かる。
#
# 記録するのは2つ:
#   test.magic.held … 押していた tick の回数。ビームの維持MPはこの回数ぶんだけ請求する。
#                     「今 tick 検知が来たか」を時刻の差で当てるとアドバンスメントと test:tick の
#                     前後関係に左右されるので、回数そのものを数える
#   test.magic.hold … 最後に検知した時刻(gametime)。しばらく来なければビームを止める
execute unless score @s test.magic.held matches -2147483648..2147483647 run scoreboard players set @s test.magic.held 0

# 同じ gametime に二度来ても1 tick ぶんしか数えない(両手の検知など)
execute store result score #hold_now test.temporary run time query gametime
execute if score @s test.magic.hold = #hold_now test.temporary run return 0

scoreboard players add @s test.magic.held 1
scoreboard players operation @s test.magic.hold = #hold_now test.temporary
