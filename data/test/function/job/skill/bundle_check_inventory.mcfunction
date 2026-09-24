#> test:job/skill/bundle_check_inventory
# @s = 全プレイヤー(tick.mcfunctionから毎tick呼ばれる)。バンドルから取り出された印アイテムが
# インベントリ(メインハンド/ホットバー含む)に出現していないか調べる

execute unless data entity @s Inventory[{components:{"minecraft:custom_data":{test:{skill_marker:1b}}}}] run return 0

data modify storage test: job_work.consume_entry set from entity @s Inventory[{components:{"minecraft:custom_data":{test:{skill_marker:1b}}}}].components."minecraft:custom_data".test
data remove entity @s Inventory[{components:{"minecraft:custom_data":{test:{skill_marker:1b}}}}]

function test:job/skill/bundle_resolve with storage test: job_work.consume_entry
