function #oh_my_dat:please

$scoreboard players operation #mainhand test.status.base.$(status) = @s test.status.base.$(status)

$execute store result score #mainhand test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.base_status{type:$(status)_add}.value 100
$scoreboard players operation #mainhand test.status.base.$(status) += #mainhand test.status.$(status)

$execute store result score #offhand test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.base_status{type:$(status)_add}.value 100
$scoreboard players operation #mainhand test.status.base.$(status) += #offhand test.status.$(status)

$tellraw @a {score:{name:"#mainhand",objective:"test.status.base.$(status)"}}

$execute store result score #mainhand test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.status_bonus{type:$(status)_add}.value 100
$scoreboard players operation #mainhand test.status.base.$(status) += #mainhand test.status.$(status)

$execute store result score #offhand test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.status_bonus{type:$(status)_add}.value 100
$scoreboard players operation #mainhand test.status.base.$(status) += #offhand test.status.$(status)

# メインハンド
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

$scoreboard players operation #mainhand test.status.base.$(status) *= #mainhand test.multiplier 
$scoreboard players operation #mainhand test.status.base.$(status) /= #10000 test.constant

$tellraw @a {score:{name:"#mainhand",objective:"test.status.base.$(status)"}}

# メインハンド
 $scoreboard players set #mainhand test.status.$(status) 0
 $execute store result score #substatus test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
 $scoreboard players operation #mainhand test.status.$(status) += #substatus test.status.$(status)
# オフハンド
 $execute store result score #offhand test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
 $execute store result score #substatus test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
 $scoreboard players operation #offhand test.status.$(status) += #substatus test.status.$(status)
# 頭
 $execute store result score #head test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.head.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
 $execute store result score #substatus test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.head.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
 $scoreboard players operation #head test.status.$(status) += #substatus test.status.$(status)
# 胸
 $execute store result score #chest test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.chest.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
 $execute store result score #substatus test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.chest.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
 $scoreboard players operation #chest test.status.$(status) += #substatus test.status.$(status)
# 足
 $execute store result score #legs test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.legs.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
 $execute store result score #substatus test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.legs.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
 $scoreboard players operation #legs test.status.$(status) += #substatus test.status.$(status)
# 靴
 $execute store result score #feet test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.feet.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
 $execute store result score #substatus test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.feet.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
 $scoreboard players operation #feet test.status.$(status) += #substatus test.status.$(status)
# サドル
 $execute store result score #saddle test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.saddle.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
 $execute store result score #substatus test.status.$(status) run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.saddle.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
 $scoreboard players operation #saddle test.status.$(status) += #substatus test.status.$(status)

$scoreboard players operation #mainhand test.status.$(status) += #offhand test.status.$(status)
$scoreboard players operation #mainhand test.status.$(status) += #head test.status.$(status)
$scoreboard players operation #mainhand test.status.$(status) += #chest test.status.$(status)
$scoreboard players operation #mainhand test.status.$(status) += #legs test.status.$(status)
$scoreboard players operation #mainhand test.status.$(status) += #feet test.status.$(status)
$scoreboard players operation #mainhand test.status.$(status) += #saddle test.status.$(status)
$tellraw @a {score:{name:"#mainhand",objective:"test.status.$(status)"}}
$scoreboard players operation #mainhand test.status.base.$(status) += #mainhand test.status.$(status)

$scoreboard players operation @s test.status.$(status) = #mainhand test.status.base.$(status)

