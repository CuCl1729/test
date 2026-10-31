#> test:debug/fishing_here_line
# 実行位置 = プレイヤー。@macro id/pool/weather/time/x1/y1/z1/dx/dy/dz: 釣り場の1行。範囲に入っていれば出す

$execute positioned $(x1) $(y1) $(z1) unless entity @a[tag=debug_fish_viewer,dx=$(dx),dy=$(dy),dz=$(dz)] run return 0
$tellraw @a[tag=debug_fish_viewer] [{text:" $(id)",color:"gold"},{text:" 天気:$(weather) 時間帯:$(time) → ",color:"gray"},{text:"$(pool)",color:"aqua"}]
