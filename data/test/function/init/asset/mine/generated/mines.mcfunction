# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/mine/generated/mines
# 鉱山(スプレッドシートの「鉱山」タブ)。asset.mine.<id> = {name, area:{x1,y1,z1,dx,dy,dz}(小さい方の角とセレクターの幅),
#   entrance:{x,y,z}, interval(秒)}。中で掘れるものは、範囲の中に置いた鉱脈のアマスタ(tag=mine_vein)が決める。
# asset.mine_ids は全鉱山のidの一覧(test:mine/tick_second が毎秒見回る)

data modify storage test: asset.mine.first_mine set value {name:"始まりの鉱山",area:{x1:100,y1:30,z1:200,dx:40,dy:40,dz:40},entrance:{x:98,y:40,z:220},interval:0}
data modify storage test: asset.mine_ids append value "first_mine"
data modify storage test: asset.mine.test_mine set value {name:"デバッグ用",area:{x1:6,y1:0,z1:-10,dx:20,dy:10,dz:20},entrance:{x:5,y:0,z:0},interval:0}
data modify storage test: asset.mine_ids append value "test_mine"
