#> test:item/weapon/lore/stat_entry_main
# @macro key/sign: custom_dataのどのステータス(base_status / status_bonus)を、どの符号で描くか

$data modify storage test: lore_work.stat set from storage test: lore_work.data.$(key)
$data modify storage test: lore_work.stat.sign set value "$(sign)"
function test:item/weapon/lore/stat_line with storage test: lore_work.stat
