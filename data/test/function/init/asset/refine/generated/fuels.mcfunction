# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/refine/generated/fuels
# 機械の燃料(スプレッドシートの「燃料」タブ)。asset.fuel."<アイテムid>" = {count}(1個で何回処理できるか)。
# アイテムのidだけで判定する(custom_data は見ない)

data modify storage test: asset.fuel."minecraft:coal" set value {count:8}
data modify storage test: asset.fuel."minecraft:charcoal" set value {count:8}
data modify storage test: asset.fuel."minecraft:coal_block" set value {count:80}
data modify storage test: asset.fuel."minecraft:blaze_rod" set value {count:12}
