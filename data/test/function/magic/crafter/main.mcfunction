#> test:magic/crafter/main
# @s = クラフター本体(barrelの位置、test:tickから毎tick呼ばれる)。各行のスロットが取られていないか
# 確認して処理する(test:battle/ui/skill_effect_cart_tick と同じ「消えていたら処理」方式)

execute unless block ~ ~ ~ barrel run kill @n[type=item,nbt={Item:{id:"minecraft:barrel"}}]
execute unless block ~ ~ ~ barrel run function test:asset/machine/magic/crafter
execute unless block ~ ~ ~ barrel run return run tag @s add kill

# 上段の矢印(0=先頭ページでは非表示 / 8=続きが無ければ非表示。表示していないぶんは検知しない)
execute unless entity @s[nbt={data:{crafter_ui:{page:0}}}] unless data block ~ ~ ~ Items[{Slot:0b}] run function test:magic/crafter/click_arrow {dir:-1}
execute if entity @s[nbt={data:{crafter_ui:{has_next:1b}}}] unless data block ~ ~ ~ Items[{Slot:8b}] run function test:magic/crafter/click_arrow {dir:1}

# 上段の要素(スロット1〜7 ↔ page_ids[0]〜[6])
execute if data entity @s data.crafter_ui.page_ids[0] unless data block ~ ~ ~ Items[{Slot:1b}] run function test:magic/crafter/click_top {index:0}
execute if data entity @s data.crafter_ui.page_ids[1] unless data block ~ ~ ~ Items[{Slot:2b}] run function test:magic/crafter/click_top {index:1}
execute if data entity @s data.crafter_ui.page_ids[2] unless data block ~ ~ ~ Items[{Slot:3b}] run function test:magic/crafter/click_top {index:2}
execute if data entity @s data.crafter_ui.page_ids[3] unless data block ~ ~ ~ Items[{Slot:4b}] run function test:magic/crafter/click_top {index:3}
execute if data entity @s data.crafter_ui.page_ids[4] unless data block ~ ~ ~ Items[{Slot:5b}] run function test:magic/crafter/click_top {index:4}
execute if data entity @s data.crafter_ui.page_ids[5] unless data block ~ ~ ~ Items[{Slot:6b}] run function test:magic/crafter/click_top {index:5}
execute if data entity @s data.crafter_ui.page_ids[6] unless data block ~ ~ ~ Items[{Slot:7b}] run function test:magic/crafter/click_top {index:6}

# 中段(スロット9〜17 ↔ build[0]〜[8])
execute if data entity @s data.crafter_ui.build[0] unless data block ~ ~ ~ Items[{Slot:9b}] run function test:magic/crafter/click_build {index:0}
execute if data entity @s data.crafter_ui.build[1] unless data block ~ ~ ~ Items[{Slot:10b}] run function test:magic/crafter/click_build {index:1}
execute if data entity @s data.crafter_ui.build[2] unless data block ~ ~ ~ Items[{Slot:11b}] run function test:magic/crafter/click_build {index:2}
execute if data entity @s data.crafter_ui.build[3] unless data block ~ ~ ~ Items[{Slot:12b}] run function test:magic/crafter/click_build {index:3}
execute if data entity @s data.crafter_ui.build[4] unless data block ~ ~ ~ Items[{Slot:13b}] run function test:magic/crafter/click_build {index:4}
execute if data entity @s data.crafter_ui.build[5] unless data block ~ ~ ~ Items[{Slot:14b}] run function test:magic/crafter/click_build {index:5}
execute if data entity @s data.crafter_ui.build[6] unless data block ~ ~ ~ Items[{Slot:15b}] run function test:magic/crafter/click_build {index:6}
execute if data entity @s data.crafter_ui.build[7] unless data block ~ ~ ~ Items[{Slot:16b}] run function test:magic/crafter/click_build {index:7}
execute if data entity @s data.crafter_ui.build[8] unless data block ~ ~ ~ Items[{Slot:17b}] run function test:magic/crafter/click_build {index:8}

# 下段: 全て消去(18) / クラフト(26)。どちらも常時表示なので条件なしで検知できる
execute unless data block ~ ~ ~ Items[{Slot:18b}] run function test:magic/crafter/click_clear
execute unless data block ~ ~ ~ Items[{Slot:26b}] run function test:magic/crafter/click_craft

# UI用アイテム(矢印・要素・ボタン・プレビュー)は取っても意味が無いので、誤って手元に
# 残らないようこのtick内で必ず回収する(目印を持たない物は対象外なので、プレイヤーが元々
# 持っている本物の矢印等を巻き込むことはない)
clear @p[distance=..3] *[custom_data~{test:{crafter_ui:1b}}]
