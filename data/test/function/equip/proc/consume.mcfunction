#> test:equip/proc/consume
# @s = プレイヤー。@macro key/item/event: 枠のキー・消耗品のid・イベント(ログ用)。消耗品を持ち物から1個使う。
# 先に clear を実行し、1個減らせたときだけ効果を実行する(持っているかを先に調べない)

scoreboard players set #consumable_used test.temporary 0
$execute store success score #consumable_used test.temporary run clear @s *[custom_data~{test:{consumable:"$(item)"}}] 1
$execute if score #consumable_used test.temporary matches 0 run return run function test:debug/log {msg:"自動使用: 消耗品「$(item)」を持っていない($(key)・$(event))"}

$function test:consumable/use {id:"$(item)"}
$function test:debug/log {msg:"自動使用: 消耗品「$(item)」を使った($(key)・$(event))"}
