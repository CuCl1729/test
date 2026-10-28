#> test:consumable/use
# @s = 使う人。@macro id: 消耗品のid。asset.consumable.<id> の効果を実行する(アイテムを減らすのは呼び出し側)。
# 装備の自動使用(test:equip/proc/use_item)からも、ターン制の「アイテム」の行動(test:battle/action/item_use)からも使えるよう、
# 効果の実行だけを行う。定義の無いidなら何もせずに0を返し、実行したら1を返す

$execute unless data storage test: asset.consumable.$(id) run return 0

$data modify storage test: consumable_work.effect set from storage test: asset.consumable.$(id).effect
function test:consumable/dispatch with storage test: consumable_work.effect
return 1
