#> test:magic/beam/parent_check
# @s = 出した元に乗っている自動ビーム。元がもう居ない(または今 tick の終わりに消される)なら終わる
scoreboard players set #beam_vehicle test.temporary 0
execute on vehicle run function test:magic/beam/parent_alive
execute if score #beam_vehicle test.temporary matches 0 run tag @s add kill
