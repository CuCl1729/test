#> test:magic/combo/has
# @macro id: 要素id。combo_work.flags にその要素が立っているかを #combo_has test.temporary に入れる
scoreboard players set #combo_has test.temporary 0
$execute if data storage test: combo_work.flags{$(id):1b} run scoreboard players set #combo_has test.temporary 1
