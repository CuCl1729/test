# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/mine/generated/veins
# 鉱脈(スプレッドシートの「鉱脈」タブ)。asset.vein.<id> = {block, ore, rank, weights:[{rare,weight}], weight_total, structure}。
# 鉱山をリセットすると、範囲の中の鉱脈のアマスタ(data.vein)の位置に structure を置き直す(test:mine/place_vein)。
# 鉱石ブロック(block)を掘ると、鉱脈のidを持つ目印が落ちる(生成したブロックのルートテーブル)。asset.vein_ids は全鉱脈のid

data modify storage test: asset.vein.copper_vein set value {block:"minecraft:deepslate_copper_ore",ore:"copper",rank:1,weights:[{rare:1,weight:60},{rare:2,weight:25},{rare:3,weight:10},{rare:4,weight:4},{rare:5,weight:1}],weight_total:100,structure:"test:vein/copper_vein"}
data modify storage test: asset.vein_ids append value "copper_vein"
data modify storage test: asset.vein.iron_vein set value {block:"minecraft:deepslate_iron_ore",ore:"iron",rank:2,weights:[{rare:1,weight:60},{rare:2,weight:25},{rare:3,weight:10},{rare:4,weight:4},{rare:5,weight:1}],weight_total:100,structure:"test:vein/iron_vein"}
data modify storage test: asset.vein_ids append value "iron_vein"
