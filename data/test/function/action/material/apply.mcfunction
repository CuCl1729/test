#> test:action/material/apply
# 実行位置 = 鍛冶で生成中の武器(loot.item)。forge_work.active(鍛冶レシピ構築中の間だけ立つ)が無ければ
# 何も適用せずに戻る。通常の武器生成(鍛冶以外)がforge_work.specialsを拾って漏れることはない

scoreboard players set #material_invalid test.temporary 0
execute unless data storage test: forge_work.active run return 1

data modify storage test: material_work.queue set value []
data modify storage test: material_work.queue set from storage test: forge_work.specials
function test:action/material/apply_loop
