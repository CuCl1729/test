#> test:magic/chain/press
# @s = 詠唱者。右クリックの検知(using_item)は押している間ずっと毎 tick 来るので、つないだ魔法は押し始めだけを受け付ける
# (押しっぱなしで「置く」と「再使用で起動」が続けて起きないように)。前の検知から2 tick 以内なら押し続けとして 0 を返す
execute store result score #press_now test.temporary run time query gametime
scoreboard players operation #press_gap test.temporary = #press_now test.temporary
scoreboard players operation #press_gap test.temporary -= @s test.magic.press
scoreboard players operation @s test.magic.press = #press_now test.temporary
execute if score #press_gap test.temporary matches ..2 run return 0
return 1
