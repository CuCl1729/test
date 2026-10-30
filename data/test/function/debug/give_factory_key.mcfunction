#> test:debug/give_factory_key
# @s = プレイヤー。工場の鍵(右クリックで工場の区画へ行く / 元の場所へ戻る。test:factory/key)を渡す。
# 右クリックを拾うため、ステータス確認のアイテムと同じく consumable を付ける(食べ終わらないほど長い時間にしてある)

give @s clock[custom_data={test:{right_click:true,factory_key:1b}},custom_name={text:"工場の鍵",italic:false},item_model="minecraft:trial_key",consumable={consume_seconds:100000,animation:none}]
