#> test:job/skill/bundle_check_inventory
# @s = 全プレイヤー(tick.mcfunctionから毎tick呼ばれる)。バンドルから取り出された印アイテムが
# カーソル(インベントリ画面で右クリックして取り出した場合)かインベントリ(メインハンド/
# ホットバー含む)に出現していないか調べる。
# プレイヤーのNBTは読み取れても/dataで書き換えられないため、取り除くのはclearで行う

execute if items entity @s player.cursor *[custom_data~{test:{skill_marker:1b}}] run return run function test:job/skill/bundle_check_cursor

execute unless items entity @s container.* *[custom_data~{test:{skill_marker:1b}}] run return 0

data modify storage test: job_work.consume_entry set from entity @s Inventory[{components:{"minecraft:custom_data":{test:{skill_marker:1b}}}}].components."minecraft:custom_data".test
clear @s *[custom_data~{test:{skill_marker:1b}}]

function test:job/skill/bundle_resolve with storage test: job_work.consume_entry
