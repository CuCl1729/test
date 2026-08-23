#> test:battle/ui/skill_effect_categories
# @s = 詠唱中のプレイヤー(#oh_my_dat:pleaseは呼び出し元で実行済み)
# 選択中のタイプが受け付ける効果のcategoryを集計し、registry_work.combo.categoriesへフラグを立てる
# (効果選択UIはこのフラグを見て出し分けるため、効果・タイプを増やしても表示ロジックは無改修)

data remove storage test: registry_work.combo.categories
data modify storage test: registry_work.combo.type_flags set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type

function test:magic/registry/queue_types
function test:battle/ui/skill_effect_categories_loop
