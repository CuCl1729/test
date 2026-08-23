#> test:battle/action/skill_known_entry
# @macro id: タイプid。習得済みなら数に加え、そのidを控える

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.known{$(id):1b} run return 0

scoreboard players add #known_type_count test.temporary 1
$data modify storage test: registry_work.only_type.id set value "$(id)"
