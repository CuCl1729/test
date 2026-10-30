#> test:item/drop_at_move
# @s = test:item/drop_at が組み立てたアイテム。目印の marker(tag=drop_at)の位置へ移し、動きを止める

tp @s @e[type=marker,tag=drop_at,limit=1]
data modify entity @s Motion set value [0.0d,0.0d,0.0d]
