#> test:battle/action/item_list
# @s = プレイヤー。持っている消耗品を asset.consumable_ids の順に数え、battle.temporary.item_slot に {id, count} で並べる
# (最大8件。トロッコのスロット0〜7、チャットの番号1〜8に対応)。持っている種類の数を返す

data modify storage test: battle.temporary.item_slot set value []
data modify storage test: registry_work.item_queue set value []
data modify storage test: registry_work.item_queue set from storage test: asset.consumable_ids
scoreboard players set #item_slot test.temporary 0
function test:battle/action/item_list_loop
return run scoreboard players get #item_slot test.temporary
