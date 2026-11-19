#> test:magic/battle_allowed_type_loop
# storage test: battle_magic_check.types_queue (asset.magic.typesの写し)を先頭から読み、
# battle:0bの宣言だけ test:magic/battle_allowed_type_entry へ渡して#battle_magic_ok test.temporaryを更新する

execute unless data storage test: battle_magic_check.types_queue[0] run return 0
data modify storage test: battle_magic_check.entry set from storage test: battle_magic_check.types_queue[0]
data remove storage test: battle_magic_check.types_queue[0]
execute if data storage test: battle_magic_check.entry{battle:0b} run function test:magic/battle_allowed_type_entry with storage test: battle_magic_check.entry
function test:magic/battle_allowed_type_loop
