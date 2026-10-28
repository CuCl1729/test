#> test:init/asset/material/
# 素材のレジストリ。asset.material.<id> = {item, name, role, data}
#   role: material(鍛冶場・工房の材料) / catalyst(触媒) / special(特殊素材。効果はコード) / pattern(型紙)
#   data: アイテムの custom_data.test に入る中身({material:{kind:"<id>"}} か、型紙なら {pattern:{part}})
# 作るのは test:item/material/build {id}。敵のドロップ(loot_table/enemy/*.json)も同じ定義から生成している

data modify storage test: asset.material set value {}
data modify storage test: asset.material_ids set value []

# 各素材の宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/material/generated/materials
