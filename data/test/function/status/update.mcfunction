function #oh_my_dat:please

$scoreboard players operation #mainhand test.calc.base = @s test.status.base.$(status)

$execute store result score #mainhand test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.base_status{type:$(status)_add}.value 100
scoreboard players operation #mainhand test.calc.base += #mainhand test.calc.add

$execute store result score #offhand test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.base_status{type:$(status)_add}.value 100
scoreboard players operation #mainhand test.calc.base += #offhand test.calc.add

$execute store result score #mainhand test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.status_bonus{type:$(status)_add}.value 100
scoreboard players operation #mainhand test.calc.base += #mainhand test.calc.add

$execute store result score #offhand test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.status_bonus{type:$(status)_add}.value 100
scoreboard players operation #mainhand test.calc.base += #offhand test.calc.add

# メインハンド（乗率）※ここは元々良い書き方だったのでそのまま
 $execute store result score #mainhand test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.status_bonus{type:$(status)_m}.value 100
 $execute store result score #status_bonus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.base_status{type:$(status)_m}.value 100
 $execute store result score #substatus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
 scoreboard players operation #mainhand test.multiplier += #substatus test.multiplier
 scoreboard players operation #mainhand test.multiplier += #status_bonus test.multiplier
# オフハンド
 $execute store result score #offhand test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.status_bonus{type:$(status)_m}.value 100
 $execute store result score #substatus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
 scoreboard players operation #offhand test.multiplier += #substatus test.multiplier
# 頭
 $execute store result score #head test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.head.components.minecraft:custom_data.main_status{type:$(status)_m}.value 100
 $execute store result score #substatus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.head.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
 scoreboard players operation #head test.multiplier += #substatus test.multiplier
# 胸
 $execute store result score #chest test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.chest.components.minecraft:custom_data.main_status{type:$(status)_m}.value 100
 $execute store result score #substatus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.chest.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
 scoreboard players operation #chest test.multiplier += #substatus test.multiplier
# 足
 $execute store result score #legs test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.legs.components.minecraft:custom_data.main_status{type:$(status)_m}.value 100
 $execute store result score #substatus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.legs.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
 scoreboard players operation #legs test.multiplier += #substatus test.multiplier
# 靴
 $execute store result score #feet test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.feet.components.minecraft:custom_data.main_status{type:$(status)_m}.value 100
 $execute store result score #substatus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.feet.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
 scoreboard players operation #feet test.multiplier += #substatus test.multiplier
# サドル
 $execute store result score #saddle test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.saddle.components.minecraft:custom_data.main_status{type:$(status)_m}.value 100
 $execute store result score #substatus test.multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.saddle.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
 scoreboard players operation #saddle test.multiplier += #substatus test.multiplier

scoreboard players operation #mainhand test.multiplier += #offhand test.multiplier
scoreboard players operation #mainhand test.multiplier += #head test.multiplier
scoreboard players operation #mainhand test.multiplier += #chest test.multiplier
scoreboard players operation #mainhand test.multiplier += #legs test.multiplier
scoreboard players operation #mainhand test.multiplier += #feet test.multiplier
scoreboard players operation #mainhand test.multiplier += #saddle test.multiplier

scoreboard players add #mainhand test.multiplier 10000

scoreboard players operation #mainhand test.calc.base *= #mainhand test.multiplier
scoreboard players operation #mainhand test.calc.base /= #10000 test.constant

# メインハンド
scoreboard players set #mainhand test.calc.add 0
$execute store result score #substatus test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
scoreboard players operation #mainhand test.calc.add += #substatus test.calc.add
# オフハンド
$execute store result score #offhand test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
$execute store result score #substatus test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
scoreboard players operation #offhand test.calc.add += #substatus test.calc.add
# 頭
$execute store result score #head test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.head.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
$execute store result score #substatus test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.head.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
scoreboard players operation #head test.calc.add += #substatus test.calc.add
# 胸
$execute store result score #chest test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.chest.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
$execute store result score #substatus test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.chest.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
scoreboard players operation #chest test.calc.add += #substatus test.calc.add
# 足
$execute store result score #legs test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.legs.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
$execute store result score #substatus test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.legs.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
scoreboard players operation #legs test.calc.add += #substatus test.calc.add
# 靴
$execute store result score #feet test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.feet.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
$execute store result score #substatus test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.feet.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
scoreboard players operation #feet test.calc.add += #substatus test.calc.add
# サドル
$execute store result score #saddle test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.saddle.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
$execute store result score #substatus test.calc.add run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.saddle.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
scoreboard players operation #saddle test.calc.add += #substatus test.calc.add

scoreboard players operation #mainhand test.calc.add += #offhand test.calc.add
scoreboard players operation #mainhand test.calc.add += #head test.calc.add
scoreboard players operation #mainhand test.calc.add += #chest test.calc.add
scoreboard players operation #mainhand test.calc.add += #legs test.calc.add
scoreboard players operation #mainhand test.calc.add += #feet test.calc.add
scoreboard players operation #mainhand test.calc.add += #saddle test.calc.add

scoreboard players operation #mainhand test.calc.base += #mainhand test.calc.add

$scoreboard players operation @s test.status.$(status) = #mainhand test.calc.base