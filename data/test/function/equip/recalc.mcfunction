#> test:equip/recalc
# @s = プレイヤー(#oh_my_dat:please実行済み、player_dataは最新)。test:cache/updateがインベントリ変化のたびに呼ぶ。
# 防具4部位・アクセサリー・セット効果のステータスを test.equip.<type>(×100)へ集計し直し、
# 4部位のセット効果(特殊効果)の一覧を oh_my_dat の test.equip.effects に入れる。
# status/updateはこの集計値を足すだけなので、装備のNBTを毎回読まずに済む

function test:equip/reset

data modify storage test: equip_work.sets set value []
data modify storage test: equip_work.effects set value []

# 防具4部位(custom_data.equipがあるものだけ)
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.head.components."minecraft:custom_data".equip run function test:equip/add_slot {slot:"head"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.chest.components."minecraft:custom_data".equip run function test:equip/add_slot {slot:"chest"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.legs.components."minecraft:custom_data".equip run function test:equip/add_slot {slot:"legs"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.feet.components."minecraft:custom_data".equip run function test:equip/add_slot {slot:"feet"}

# アクセサリー: インベントリにあるものを先頭から上限(asset.equip.accessory_limit)個まで
data modify storage test: equip_work.accessories set value []
data modify storage test: equip_work.accessories append from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.Inventory[{components:{"minecraft:custom_data":{equip:{slot:"accessory"}}}}]
execute store result score #equip_acc_left test.temporary run data get storage test: asset.equip.accessory_limit
function test:equip/accessory_loop

# セット効果(シリーズのレジストリを順に見て、着ている部位数で2部位/4部位のボーナスを足す)
data modify storage test: equip_work.set_queue set from storage test: asset.equip.sets
function test:equip/set_loop

data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.effects set from storage test: equip_work.effects
scoreboard players set @s test.equip.has_effects 0
execute if data storage test: equip_work.effects[0] run scoreboard players set @s test.equip.has_effects 1

# 属性耐性は test.<属性>_resist に直接入れる(基準値0。init/asset/status/defense)
function test:equip/apply_resist

# 主要ステータスを組み直す。ターン制のアイテム式UI中はメインハンドが行動アイテムなので組み直さない
# (status/recalcと同じ条件。次の手番の配り直しやbattle/ui/itemで正しく組み直される)
scoreboard players set #equip_rebuild test.temporary 1
execute if score @s test.battle.id matches 1.. if score @s test.settings.battle_ui matches 2 run scoreboard players set #equip_rebuild test.temporary 0
execute if score #equip_rebuild test.temporary matches 1 run function test:equip/rebuild_status
