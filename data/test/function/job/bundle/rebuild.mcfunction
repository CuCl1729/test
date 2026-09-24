#> test:job/bundle/rebuild
# @s = 対象プレイヤー(please実行済みであること)。oh_my_dat側のtest.job.skill_order(職業スキル
# 解放順の固定リスト。使用によって並びが変わることは無い)から職業スキルぶんの中身を反転した順序で
# 組み立て、さらに現在の武器が範囲攻撃対応なら剣スキルぶんを1件足してバンドルへ書き戻す(§5参照)。
# 剣スキルは「解放して保持し続けるもの」ではなく今持っている武器で決まるものなので、
# skill_orderには含めずここで毎回ライブに判定する

data modify storage test: job_work.owner_uuid set from entity @s UUID

data modify storage test: registry_work.reverse_src set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop

data modify storage test: job_work.build_queue set from storage test: registry_work.reverse_dst
data modify storage test: job_work.bundle_items set value []
function test:job/bundle/rebuild_loop

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{aoe_attack:1b} run function test:job/bundle/build_entry_sword

execute if data entity @s Inventory[{components:{"minecraft:custom_data":{test:{skill_bundle:1b}}}}] run data modify entity @s Inventory[{components:{"minecraft:custom_data":{test:{skill_bundle:1b}}}}].components."minecraft:bundle_contents" set from storage test: job_work.bundle_items
execute if data entity @s equipment.offhand.components.minecraft:custom_data.test{skill_bundle:1b} run data modify entity @s equipment.offhand.components."minecraft:bundle_contents" set from storage test: job_work.bundle_items
