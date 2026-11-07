$data modify storage test: station_action.inv set from entity @s Inventory[{components:{"minecraft:custom_data":{test:{station_action:{ticket:$(ticket)}}}}}].Slot
execute store result storage test: station_action.slot int 1 run data get storage test: station_action.inv
function test:station/action/inventory_slot with storage test: station_action
