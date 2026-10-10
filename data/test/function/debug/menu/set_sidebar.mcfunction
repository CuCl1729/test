#> test:debug/menu/set_sidebar
# @macro value: 1=表示 / 0=非表示(既存のtest:debug/on・offを呼ぶ)

$scoreboard players set #sidebar_request test.temporary $(value)
execute if score #sidebar_request test.temporary matches 1 run function test:debug/on
execute if score #sidebar_request test.temporary matches 1 run function test:debug/menu/done {msg:"サイドバー表示をONにしました"}
execute if score #sidebar_request test.temporary matches 0 run function test:debug/off
execute if score #sidebar_request test.temporary matches 0 run function test:debug/menu/done {msg:"サイドバー表示をOFFにしました"}
