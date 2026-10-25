#> test:item/weapon/level_up/mainstatus
# storage test: loot.item のメインステータス(status_bonus、あればbase_status)をレベルアップ1回ぶん伸ばす。
# 防具・アクセサリーはbase_statusを持たないので、あるものだけを伸ばす
# (以前は両方をまとめてマクロに渡しており、片方が無いと展開に失敗して成長がすべて止まっていた)

execute if data storage test: loot.item.components."minecraft:custom_data".status_bonus run function test:item/weapon/level_up/grow_main {key:"status_bonus"}
execute if data storage test: loot.item.components."minecraft:custom_data".base_status run function test:item/weapon/level_up/grow_main {key:"base_status"}
