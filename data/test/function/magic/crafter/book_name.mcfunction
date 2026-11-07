#> test:magic/crafter/book_name
# @s = クラフター本体(barrelの位置)。名前の枠(23)に本と羽根ペンがあり、1ページ目に文字があれば、それを魔法の名前
# (magic.loot.name)にする。無ければ自動の名前(test:magic/build_name)のまま。本は消費しない。
# 文字はマクロを通さず set from で写すので、どんな文字でも壊れない。1ページ目は {raw:…} の形も文字列の形も読む
execute unless data block ~ ~ ~ Items[{Slot:23b,id:"minecraft:writable_book"}] run return 0
data remove storage test: registry_work.book_page
data modify storage test: registry_work.book_page set from block ~ ~ ~ Items[{Slot:23b}].components."minecraft:writable_book_content".pages[0]
data remove storage test: registry_work.book_text
execute if data storage test: registry_work.book_page.raw run data modify storage test: registry_work.book_text set from storage test: registry_work.book_page.raw
execute unless data storage test: registry_work.book_page.raw run data modify storage test: registry_work.book_text set from storage test: registry_work.book_page
execute unless data storage test: registry_work.book_text run return 0
execute if data storage test: registry_work{book_text:""} run return 0
data modify storage test: magic.loot.name set value [{text:"",italic:false}]
data modify storage test: magic.loot.name[0].text set from storage test: registry_work.book_text
