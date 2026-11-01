#> test:craft/custom/grid_snapshot
# 実行位置 = カスタムクラフターの樽。材料の枠9つの中身(Slot 付き)を craft_work.grid に写す(変わったかを比べるため)

data modify storage test: craft_work.grid set value []
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:3b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:4b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:5b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:12b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:13b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:14b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:21b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:22b}]
data modify storage test: craft_work.grid append from block ~ ~ ~ Items[{Slot:23b}]
