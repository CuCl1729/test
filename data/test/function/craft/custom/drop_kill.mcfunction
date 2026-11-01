#> test:craft/custom/drop_kill
# @s = 樽が壊れたカスタムクラフターのマーカー(test:station/no_barrel から)。@macro show: 結果の枠に置いていたもの。
# まだ取られていない結果は、樽と一緒に落ちても材料を使っていないので消す(材料の枠の材料は、そのまま落ちる)

$kill @e[type=item,distance=..2,limit=1,nbt={Item:$(show)}]
data remove entity @s data.crafter
