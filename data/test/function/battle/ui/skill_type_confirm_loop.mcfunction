#> test:battle/ui/skill_type_confirm_loop
# レジストリを走査し、選択中のデリバリタイプを数えて、その内の1つをidとして控える
# (デリバリが2つ以上ある場合はvalidate_comboが不正と判定するため、控える先は1つで足りる)

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

function test:battle/ui/skill_type_confirm_entry with storage test: registry_work.type_entry

function test:battle/ui/skill_type_confirm_loop
