#> test:action/material/on_hit
# 実行位置 = 鍛冶で生成中の武器(loot.item)。@macro id,trigger,buff: 攻撃を当てたときに確率で発動するバフ
# (test.buff_on_hit。1件の形は魔法・敵と共通の{id,stacks,chance}。付与処理はtest:buff/apply_list)を1件追加する

execute unless data storage test: loot.item.components.minecraft:custom_data.test.buff_on_hit run data modify storage test: loot.item.components.minecraft:custom_data.test.buff_on_hit set value []
$data modify storage test: loot.item.components.minecraft:custom_data.test.buff_on_hit append value $(buff)
