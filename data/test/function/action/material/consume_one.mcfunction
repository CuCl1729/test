#> test:action/material/consume_one
# 実行位置 = 鍛冶場マーカー。@macro id: 樽にあるその特殊素材(kind)の枠を、スロットに関わらずすべて取り除く

$data remove block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{material:{kind:"$(id)"}}}}}]
