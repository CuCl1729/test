#> test:job/skill/bundle_check_dropped
# @s = 地面に落ちた印アイテムのエンティティ(tick.mcfunctionのセレクタで既に絞り込み済み。
# インベントリが満杯でバンドルから取り出せず地面に落ちたケース)

data modify storage test: job_work.consume_entry set from entity @s Item.components."minecraft:custom_data".test
kill @s

function test:job/skill/bundle_resolve with storage test: job_work.consume_entry
