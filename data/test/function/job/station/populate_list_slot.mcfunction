#> test:job/station/populate_list_slot
# @s = Jobステーション本体(please実行済み)。@macro id/label/color/requires/slot:
# レジストリの1件ぶん(registry_work.job_entry)と詰め先スロット番号

data modify entity @s data.job_ui.page_ids append value ""
$data modify entity @s data.job_ui.page_ids[-1] set value "$(id)"

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(id) run scoreboard players set #job_unlocked test.temporary 1
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(id) run scoreboard players set #job_unlocked test.temporary 0

execute if score #job_unlocked test.temporary matches 1 run function test:job/station/populate_list_slot_unlocked with storage test: registry_work.job_entry
execute if score #job_unlocked test.temporary matches 0 run function test:job/station/populate_list_slot_locked with storage test: registry_work.job_entry
