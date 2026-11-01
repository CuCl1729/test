#> test:money/show
# @s = プレイヤー。#md = 口座の残高が変わった量。「口座 1230G(+50)」とアクションバーに出す

execute if score #md test.temporary matches 0.. run return run title @s actionbar [{text:"口座 ",color:"gray"},{score:{name:"@s",objective:"test.money"},color:"yellow"},{text:"G",color:"yellow"},{text:"(+",color:"green"},{score:{name:"#md",objective:"test.temporary"},color:"green"},{text:")",color:"green"}]
title @s actionbar [{text:"口座 ",color:"gray"},{score:{name:"@s",objective:"test.money"},color:"yellow"},{text:"G",color:"yellow"},{text:"(",color:"red"},{score:{name:"#md",objective:"test.temporary"},color:"red"},{text:")",color:"red"}]
