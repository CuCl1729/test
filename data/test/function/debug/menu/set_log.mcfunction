#> test:debug/menu/set_log
# @macro cat/label/value: ログの種類・表示名・1=オン/0=オフ

$scoreboard players set #log_$(cat) test.debug.enabled $(value)
$execute if score #log_$(cat) test.debug.enabled matches 1 run function test:debug/menu/done {msg:"$(label)のログをONにしました"}
$execute if score #log_$(cat) test.debug.enabled matches 0 run function test:debug/menu/done {msg:"$(label)のログをOFFにしました"}
