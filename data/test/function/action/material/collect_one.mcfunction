#> test:action/material/collect_one
# 実行位置 = 鍛冶場マーカー。@macro id: 樽にその特殊素材(kind)が1つでもあれば、記述子(material_work.entry)を
# forge_work.specials に1件だけ追加する。無い場合や未登録のidは無視する

$execute if data block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{material:{kind:"$(id)"}}}}}] run data modify storage test: forge_work.specials append from storage test: material_work.entry
