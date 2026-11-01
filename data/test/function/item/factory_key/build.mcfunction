#> test:item/factory_key/build
# 工場の鍵(右クリックで工場の区画へ行く / 元の場所へ戻る。test:factory/key)を loot.item に作る。
# 右クリックを拾うため、ステータス確認のアイテムと同じく consumable を付ける(食べ終わらないほど長い時間にしてある)

data remove storage test: loot.item
data modify storage test: loot.item set value {id:"minecraft:clock",components:{"minecraft:custom_data":{test:{right_click:true,factory_key:1b}},"minecraft:custom_name":{text:"工場の鍵",italic:false},"minecraft:item_model":"minecraft:trial_key","minecraft:consumable":{consume_seconds:100000,animation:"none"}}}
