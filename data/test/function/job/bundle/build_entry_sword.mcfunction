#> test:job/bundle/build_entry_sword
# 剣スキル(範囲攻撃)ぶんの印アイテムを組み立ててjob_work.bundle_itemsの先頭へ差し込む

data modify storage test: job_work.built_item set value {id:"iron_sword",count:1,components:{"minecraft:custom_name":{text:"剣技: 範囲攻撃",italic:false,color:"aqua"},"minecraft:max_stack_size":1,"minecraft:custom_data":{test:{skill_marker:1b,kind:"sword"}}}}
data modify storage test: job_work.built_item.components."minecraft:custom_data".test.owner_uuid set from storage test: job_work.owner_uuid

data modify storage test: job_work.bundle_items prepend from storage test: job_work.built_item
