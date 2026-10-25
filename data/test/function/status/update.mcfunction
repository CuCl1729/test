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
# 防具・アクセサリー・セット効果(test:equip/recalcがインベントリ変化のたびに集計した合計。×100)
 scoreboard players set #equip test.multiplier 0
 $scoreboard players operation #equip test.multiplier = @s test.equip.$(status)_m

scoreboard players operation #mainhand test.multiplier += #offhand test.multiplier
scoreboard players operation #mainhand test.multiplier += #equip test.multiplier

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
# 防具・アクセサリー・セット効果(乗率と同じくtest:equip/recalcの集計値)
scoreboard players set #equip test.calc.add 0
$scoreboard players operation #equip test.calc.add = @s test.equip.$(status)_add

scoreboard players operation #mainhand test.calc.add += #offhand test.calc.add
scoreboard players operation #mainhand test.calc.add += #equip test.calc.add

scoreboard players operation #mainhand test.calc.base += #mainhand test.calc.add

$scoreboard players operation @s test.status.$(status) = #mainhand test.calc.base

# バフ/デバフによる増減を最後に足す。この関数は装備からステータスを毎回組み立て直すため、
# バフが test.status.<名前> を直接書いても消えてしまう。そこで蓄積用の test.buff.<名前> を
# 経由させ、組み立ての最後にここで合流させる(test:buff/stat/add 参照)
$scoreboard players operation @s test.status.$(status) += @s test.buff.$(status)

# 解放済み職業のレベルによるボーナスも同じ理由でここで合流させる(test:job/recalc_bonus参照。
# レベルアップ時にしか変わらないため、バフのような差分更新の仕組みは無く単純な加算のみ)
$scoreboard players operation @s test.status.$(status) += @s test.job_bonus.$(status)