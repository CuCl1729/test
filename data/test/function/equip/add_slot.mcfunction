#> test:equip/add_slot
# @s = プレイヤー。@macro slot: 防具の部位(head/chest/legs/feet)。その部位の防具の能力を足し、シリーズを控える

$data modify storage test: equip_work.item set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.$(slot).components."minecraft:custom_data"
function test:equip/add_item

# セット効果の部位数を数えるため、シリーズidを控える(数えるときに{id}で絞れるようcompoundにしておく)
execute if data storage test: equip_work.item.equip.set run data modify storage test: equip_work.sets append value {id:""}
execute if data storage test: equip_work.item.equip.set run data modify storage test: equip_work.sets[-1].id set from storage test: equip_work.item.equip.set
