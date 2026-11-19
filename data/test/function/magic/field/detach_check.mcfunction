#> test:magic/field/detach_check
# @s = 出した元に乗っている場。元がもう居ない(または今 tick の終わりに消される)なら、
# 乗るのをやめてその場に残る。残りの時間はそのまま続く
#
# 「乗っているか」は execute on vehicle で調べる(乗り物が無ければそのコマンドは走らない)。
# 消される予定(kill タグ)の元からも降りておくこと: test:tick の最後は消えるものの
# passengers にも kill を広げるため、乗ったままだと場も道連れになる。
# 弾 →着弾で→ 継続+範囲 は、弾が同じ tick のうちに kill タグを付けられるのでこの経路に当たる
scoreboard players set #field_vehicle test.temporary 0
execute on vehicle run function test:magic/field/vehicle_alive

execute if score #field_vehicle test.temporary matches 1 run return 0

tag @s remove field_parented
ride @s dismount
