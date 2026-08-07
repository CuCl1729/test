#> test:debug/give_status_check
# ステータス確認アイテムを @s に配布する

give @s clock[custom_data={test:{right_click:true,status_check:1b}},custom_name={text:"ステータス確認",italic:false},consumable={consume_seconds:100000,animation:none}]
