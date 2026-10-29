# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/mine/generated/mines
# 鉱山(スプレッドシートの「鉱山」タブ)。asset.mine.<id> = {name, block, ore, rank, weights:[{rare,weight}], weight_total,
#   area:{x1,y1,z1,dx,dy,dz}(小さい方の角とセレクターの幅), entrance:{x,y,z}, structures:[{id,x,y,z}], interval(秒)}。
# asset.mine_ids は全鉱山のidの一覧(test:mine/tick_second が毎秒見回る)

data modify storage test: asset.mine.copper_mine set value {name:"銅の鉱山",block:"minecraft:deepslate_copper_ore",ore:"copper",rank:1,weights:[{rare:1,weight:60},{rare:2,weight:25},{rare:3,weight:10},{rare:4,weight:4},{rare:5,weight:1}],weight_total:100,area:{x1:100,y1:30,z1:200,dx:40,dy:40,dz:40},entrance:{x:98,y:40,z:220},structures:[{id:"test:mine/copper_0",x:100,y:30,z:200}],interval:0}
data modify storage test: asset.mine_ids append value "copper_mine"
data modify storage test: asset.mine.iron_mine set value {name:"鉄の鉱山",block:"minecraft:deepslate_iron_ore",ore:"iron",rank:2,weights:[{rare:1,weight:60},{rare:2,weight:25},{rare:3,weight:10},{rare:4,weight:4},{rare:5,weight:1}],weight_total:100,area:{x1:200,y1:30,z1:200,dx:40,dy:40,dz:40},entrance:{x:198,y:40,z:220},structures:[{id:"test:mine/iron_0",x:200,y:30,z:200}],interval:0}
data modify storage test: asset.mine_ids append value "iron_mine"
