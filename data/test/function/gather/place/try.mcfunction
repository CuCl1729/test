#> test:gather/place/try
# @macro id/type/block/x/y/z/dim: ポイントと、置くマップ。座標が読み込まれていて、まだ無ければ置く:
#   interaction(右クリックを受け取る。tag=gather_point、data.gather = {point, type, dim, def(置いたときの定義)})をブロックの中心に、
#   block_display(見た目だけ。tag=gather_display)をブロックの角に。見た目は次の test:gather/refresh で状態に合わせる

$execute in test:$(dim) unless loaded $(x) $(y) $(z) run return 0
$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz positioned ~0.5 ~ ~0.5 if entity @e[type=interaction,tag=gather_point,distance=..0.5] run return 0
$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz positioned ~0.5 ~ ~0.5 run summon interaction ~ ~ ~ {width:1.0f,height:1.0f,response:1b,Tags:["gather_point"],data:{gather:{point:"$(id)",type:"$(type)",dim:"$(dim)",def:{type:"$(type)",block:"$(block)",x:$(x),y:$(y),z:$(z)}}}}
$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz run summon block_display ~ ~ ~ {Tags:["gather_display"],block_state:{id:"$(block)"}}
