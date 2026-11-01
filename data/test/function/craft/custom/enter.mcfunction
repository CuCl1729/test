#> test:craft/custom/enter
# @s = カスタムクラフターのマーカー(実行位置は樽)。モードに入ったとき(test:station/enter_mode)。
# 前の判定の記録を消し、次の main で材料の枠を判定し直させる(材料の枠の中身は樽にそのまま残る)

data remove entity @s data.crafter
