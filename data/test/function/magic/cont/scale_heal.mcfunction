#> test:magic/cont/scale_heal
# @s = 持続物の本体。回復量(= 再生を何回ぶん掛けるか)を1パルスぶんに縮め、
# 割り切れないぶんを本体に持ち越す。回復量1・間隔1tick なら、20回ぶんでちょうど1回ぶんになる
execute unless data storage test: magic.player.heal.power run return 0
execute unless score @s test.magic.frac.heal matches -2147483648..2147483647 run scoreboard players set @s test.magic.frac.heal 0

execute store result score #cont_v test.temporary run data get storage test: magic.player.heal.power
scoreboard players operation #cont_v test.temporary *= #cont_period test.temporary
scoreboard players operation #cont_v test.temporary += @s test.magic.frac.heal

scoreboard players operation @s test.magic.frac.heal = #cont_v test.temporary
scoreboard players operation @s test.magic.frac.heal %= #20 test.constant

scoreboard players operation #cont_v test.temporary /= #20 test.constant
execute store result storage test: magic.player.heal.power int 1 run scoreboard players get #cont_v test.temporary
