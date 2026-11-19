#> test:item/magic/set_lore_element_loop
# レジストリを末尾から1件ずつ取り出し、炎以外の属性ダメージ行をロアに追加する
# (炎は専用の「炎上ダメージ」表記をset_lore側で出すため対象外。末尾[-1]から削ると後続要素がずれないため軽い)

execute unless data storage test: registry_work.lore_element_queue[-1] run return 0

data modify storage test: registry_work.lore_element_entry set from storage test: registry_work.lore_element_queue[-1]
data remove storage test: registry_work.lore_element_queue[-1]

execute unless data storage test: registry_work.lore_element_entry{id:"fire"} run function test:item/magic/set_lore_element with storage test: registry_work.lore_element_entry

function test:item/magic/set_lore_element_loop
