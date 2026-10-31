#> test:craft/magic/research/main
# @s = 魔法台のマーカー(研究モード。barrelの位置、test:station/tickから毎tick呼ばれる)

# 上段の矢印(0=先頭ページでは非表示 / 8=続きが無ければ非表示)
execute unless entity @s[nbt={data:{research_ui:{page:0}}}] unless data block ~ ~ ~ Items[{Slot:0b}] run function test:craft/magic/research/click_arrow {dir:-1}
execute if entity @s[nbt={data:{research_ui:{has_next:1b}}}] unless data block ~ ~ ~ Items[{Slot:8b}] run function test:craft/magic/research/click_arrow {dir:1}

# 上段の要素(スロット1〜7 ↔ page_ids[0]〜[6])
execute if data entity @s data.research_ui.page_ids[0] unless data block ~ ~ ~ Items[{Slot:1b}] run function test:craft/magic/research/click_top {index:0}
execute if data entity @s data.research_ui.page_ids[1] unless data block ~ ~ ~ Items[{Slot:2b}] run function test:craft/magic/research/click_top {index:1}
execute if data entity @s data.research_ui.page_ids[2] unless data block ~ ~ ~ Items[{Slot:3b}] run function test:craft/magic/research/click_top {index:2}
execute if data entity @s data.research_ui.page_ids[3] unless data block ~ ~ ~ Items[{Slot:4b}] run function test:craft/magic/research/click_top {index:3}
execute if data entity @s data.research_ui.page_ids[4] unless data block ~ ~ ~ Items[{Slot:5b}] run function test:craft/magic/research/click_top {index:4}
execute if data entity @s data.research_ui.page_ids[5] unless data block ~ ~ ~ Items[{Slot:6b}] run function test:craft/magic/research/click_top {index:5}
execute if data entity @s data.research_ui.page_ids[6] unless data block ~ ~ ~ Items[{Slot:7b}] run function test:craft/magic/research/click_top {index:6}

# 知識の表示(スロット13)を取られたら置き直す
execute unless data block ~ ~ ~ Items[{Slot:13b}] run function test:craft/magic/research/populate_top

# UI用アイテム(矢印・要素)は取っても意味が無いので、誤って手元に残らないよう
# このtick内で必ず回収する(目印を持たない物は対象外)
clear @p[distance=..3] *[custom_data~{test:{crafter_ui:1b}}]
