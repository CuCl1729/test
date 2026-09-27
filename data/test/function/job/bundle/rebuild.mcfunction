#> test:job/bundle/rebuild
# @s = 対象プレイヤー(please実行済みであること)。oh_my_dat側のtest.job.skill_order(職業スキル
# 解放順の固定リスト。使用によって並びが変わることは無い)から職業スキルぶんの中身を反転した順序で
# 組み立ててバンドルへ書き戻す。剣スキルは入れない(バンドルをメインハンドに持つと剣のデータを
# 読めないため。範囲攻撃剣は剣自体の右クリックで発動する)

data modify storage test: job_work.owner_uuid set from entity @s UUID

data modify storage test: registry_work.reverse_src set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop

data modify storage test: job_work.build_queue set from storage test: registry_work.reverse_dst
data modify storage test: job_work.bundle_items set value []
function test:job/bundle/rebuild_loop

# スキルバンドルを持っていないプレイヤー(スキル解放時など)には新しく渡さない
execute unless items entity @s container.* *[custom_data~{test:{skill_bundle:1b}}] unless items entity @s weapon.offhand *[custom_data~{test:{skill_bundle:1b}}] run return 0

# プレイヤーのNBTは/dataで書き換えられないため、test:loot/giveと同じくオーバーワールドの
# 0 -64 0(シュルカーボックス)で完成品のバンドルを組み立てる
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with bundle[custom_data={test:{skill_bundle:1b}},custom_name={text:"スキルバンドル",italic:false}]
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:bundle_contents" set from storage test: job_work.bundle_items

function test:job/bundle/deliver
