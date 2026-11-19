#> test:magic/field/vehicle_alive
# @s = 場が乗っている元。今 tick の終わりに消される予定でなければ「まだ居る」
execute unless entity @s[tag=kill] run scoreboard players set #field_vehicle test.temporary 1
