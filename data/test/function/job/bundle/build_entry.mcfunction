#> test:job/bundle/build_entry
# @s = 対象プレイヤー。@macro job/node: 職業スキル参照1件(job_work.build_entryとして展開済み、
# job_work.owner_uuidは呼び出し元rebuildが設定済み)。レジストリからラベルを引いて印アイテムを
# 組み立て、job_work.bundle_itemsの先頭へ差し込む(build_queueは末尾から取り出しているため、
# 先頭挿入で元のskill_order順に戻る)

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

data modify storage test: job_work.built_item set value {id:"nether_star",count:1,components:{"minecraft:custom_name":{text:"",italic:false,color:"light_purple"},"minecraft:max_stack_size":1,"minecraft:custom_data":{test:{skill_marker:1b,kind:"job"}}}}
data modify storage test: job_work.built_item.components."minecraft:custom_name".text set from storage test: job_work.skill_entry.label
$data modify storage test: job_work.built_item.components."minecraft:custom_data".test.job set value "$(job)"
$data modify storage test: job_work.built_item.components."minecraft:custom_data".test.node set value "$(node)"
data modify storage test: job_work.built_item.components."minecraft:custom_data".test.owner_uuid set from storage test: job_work.owner_uuid

data modify storage test: job_work.bundle_items prepend from storage test: job_work.built_item
