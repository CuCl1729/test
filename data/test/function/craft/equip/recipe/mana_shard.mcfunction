# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:craft/equip/recipe/mana_shard
# 素材 mana_shard のレシピ(スプレッドシートの「防具工房レシピ」タブ)。スロット10の型紙の部位(loot.equip_part)ごとに作る装備

execute if data storage test: {loot:{equip_part:"head"}} run return run function test:asset/equip/apply {id:"mage_hat"}
execute if data storage test: {loot:{equip_part:"chest"}} run return run function test:asset/equip/apply {id:"mage_robe"}
execute if data storage test: {loot:{equip_part:"legs"}} run return run function test:asset/equip/apply {id:"mage_leggings"}
execute if data storage test: {loot:{equip_part:"feet"}} run return run function test:asset/equip/apply {id:"mage_boots"}
execute if data storage test: {loot:{equip_part:"accessory"}} run return run function test:asset/equip/apply {id:"fire_charm"}
