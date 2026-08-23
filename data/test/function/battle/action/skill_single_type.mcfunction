#> test:battle/action/skill_single_type
# @s = 詠唱者。@macro id: 唯一習得しているタイプid
# タイプ選択を飛ばし、そのタイプを選択済みにしてから効果選択へ進む

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type.$(id) set value 1b
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.delivery set value "$(id)"

function test:battle/ui/skill_effect_select
