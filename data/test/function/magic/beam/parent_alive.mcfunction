#> test:magic/beam/parent_alive
# @s = ビームが乗っている元。今 tick の終わりに消される予定でなければ「まだ居る」
execute unless entity @s[tag=kill] run scoreboard players set #beam_vehicle test.temporary 1
