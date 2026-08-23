#> test:magic/crafter/validate
# @s = クラフター本体。組み立て終わったmagic.loot.statusの組み合わせが成立するか検証する
# (検証本体は戦闘のタイプ選択と共通のtest:magic/crafter/validate_combo)

data remove storage test: registry_work.combo
data modify storage test: registry_work.combo.type_flags set from storage test: magic.loot.status.type_flags

function test:magic/crafter/validate_combo
