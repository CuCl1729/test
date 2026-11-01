# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/shop/generated/shops
# 店(スプレッドシートの「店」タブ)。asset.shop.<店> = {items:[{kind, id, count, buy, sell}]}(買えない・売れないものは -1)。画面は test:npc/cart/shop/

data modify storage test: asset.shop.general set value {items:[{kind:"consumable",id:"healing_potion",count:1,buy:30,sell:-1},{kind:"consumable",id:"mana_dust",count:2,buy:20,sell:-1},{kind:"gather_tool",id:"copper_sickle",count:1,buy:100,sell:-1},{kind:"material",id:"bone",count:3,buy:-1,sell:5},{kind:"material",id:"herb_leaf",count:2,buy:-1,sell:8}]}
data modify storage test: asset.shop_ids append value "general"
