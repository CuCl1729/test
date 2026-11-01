#> test:money/pay_bank
# @s = プレイヤー。コインでは足りなかった。足りない分(#pn − #pc)を口座から引く

scoreboard players operation #pn test.temporary -= #pc test.temporary
scoreboard players operation @s test.money -= #pn test.temporary
scoreboard players operation #md test.temporary = #pn test.temporary
scoreboard players operation #md test.temporary *= #-1 test.constant
function test:money/show
