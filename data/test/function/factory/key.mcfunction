#> test:factory/key
# @s = 工場の鍵(custom_data.test.factory_key)を右クリックしたプレイヤー(test:trigger/right_click/mainhand から)。
# 右クリックを押している間は毎tick呼ばれるので、前に使ってから1秒(20tick)たつまでは何もしない。動きは test:factory/use

scoreboard players add @s test.factory.cooldown 0
execute store result score #fk_now test.temporary run time query gametime
scoreboard players operation #fk_d test.temporary = #fk_now test.temporary
scoreboard players operation #fk_d test.temporary -= @s test.factory.cooldown
execute if score #fk_d test.temporary matches ..19 run return 0
scoreboard players operation @s test.factory.cooldown = #fk_now test.temporary
function test:factory/use
