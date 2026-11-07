#> test:magic/crafter/main
# @s = 魔法台のマーカー(作成モード。barrelの位置、test:station/tickから毎tick呼ばれる)。各行のスロットが取られていないか
# 確認して処理する(test:battle/ui/skill_effect_cart_tick と同じ「消えていたら処理」方式)

# 名前の枠(23)ができる前に置いた魔法台を、一度だけ直す
execute unless data entity @s data.station.keep.s23 run function test:magic/crafter/keep_name_slot

data modify storage test: registry_work.magic_clicks set value {}

# 上段の矢印(0=先頭ページでは非表示 / 8=続きが無ければ非表示。表示していないぶんは検知しない)
execute unless entity @s[nbt={data:{crafter_ui:{page:0}}}] unless data block ~ ~ ~ Items[{Slot:0b}] run data modify storage test: registry_work.magic_clicks.s0 set value 1b
execute if entity @s[nbt={data:{crafter_ui:{has_next:1b}}}] unless data block ~ ~ ~ Items[{Slot:8b}] run data modify storage test: registry_work.magic_clicks.s8 set value 1b

# 上段の要素(スロット1〜7 ↔ page_ids[0]〜[6])
execute if data entity @s data.crafter_ui.page_ids[0] unless data block ~ ~ ~ Items[{Slot:1b}] run data modify storage test: registry_work.magic_clicks.s1 set value 1b
execute if data entity @s data.crafter_ui.page_ids[1] unless data block ~ ~ ~ Items[{Slot:2b}] run data modify storage test: registry_work.magic_clicks.s2 set value 1b
execute if data entity @s data.crafter_ui.page_ids[2] unless data block ~ ~ ~ Items[{Slot:3b}] run data modify storage test: registry_work.magic_clicks.s3 set value 1b
execute if data entity @s data.crafter_ui.page_ids[3] unless data block ~ ~ ~ Items[{Slot:4b}] run data modify storage test: registry_work.magic_clicks.s4 set value 1b
execute if data entity @s data.crafter_ui.page_ids[4] unless data block ~ ~ ~ Items[{Slot:5b}] run data modify storage test: registry_work.magic_clicks.s5 set value 1b
execute if data entity @s data.crafter_ui.page_ids[5] unless data block ~ ~ ~ Items[{Slot:6b}] run data modify storage test: registry_work.magic_clicks.s6 set value 1b
execute if data entity @s data.crafter_ui.page_ids[6] unless data block ~ ~ ~ Items[{Slot:7b}] run data modify storage test: registry_work.magic_clicks.s7 set value 1b

# 中段(スロット9〜17 ↔ view[0]〜[8]。いま出しているページの分。test:magic/crafter/populate_build)
execute if data entity @s data.crafter_ui.view[0] unless data block ~ ~ ~ Items[{Slot:9b}] run data modify storage test: registry_work.magic_clicks.s9 set value 1b
execute if data entity @s data.crafter_ui.view[1] unless data block ~ ~ ~ Items[{Slot:10b}] run data modify storage test: registry_work.magic_clicks.s10 set value 1b
execute if data entity @s data.crafter_ui.view[2] unless data block ~ ~ ~ Items[{Slot:11b}] run data modify storage test: registry_work.magic_clicks.s11 set value 1b
execute if data entity @s data.crafter_ui.view[3] unless data block ~ ~ ~ Items[{Slot:12b}] run data modify storage test: registry_work.magic_clicks.s12 set value 1b
execute if data entity @s data.crafter_ui.view[4] unless data block ~ ~ ~ Items[{Slot:13b}] run data modify storage test: registry_work.magic_clicks.s13 set value 1b
execute if data entity @s data.crafter_ui.view[5] unless data block ~ ~ ~ Items[{Slot:14b}] run data modify storage test: registry_work.magic_clicks.s14 set value 1b
execute if data entity @s data.crafter_ui.view[6] unless data block ~ ~ ~ Items[{Slot:15b}] run data modify storage test: registry_work.magic_clicks.s15 set value 1b
execute if data entity @s data.crafter_ui.view[7] unless data block ~ ~ ~ Items[{Slot:16b}] run data modify storage test: registry_work.magic_clicks.s16 set value 1b
execute if data entity @s data.crafter_ui.view[8] unless data block ~ ~ ~ Items[{Slot:17b}] run data modify storage test: registry_work.magic_clicks.s17 set value 1b

# 下段: 中段のページ送り(19=前 / 21=次。出しているときだけ検知する)
execute if entity @s[nbt={data:{crafter_ui:{bprev:1b}}}] unless data block ~ ~ ~ Items[{Slot:19b}] run data modify storage test: registry_work.magic_clicks.s19 set value 1b
execute if entity @s[nbt={data:{crafter_ui:{bnext:1b}}}] unless data block ~ ~ ~ Items[{Slot:21b}] run data modify storage test: registry_work.magic_clicks.s21 set value 1b
# 名前の枠(23)。本と羽根ペンが置かれた・外された・書き換わったら組み立て直す(test:magic/crafter/book_name)
data remove storage test: registry_work.book_now
data modify storage test: registry_work.book_now set from block ~ ~ ~ Items[{Slot:23b}]
execute unless data storage test: registry_work.book_now run data modify storage test: registry_work.book_now set value {}
execute store success score #book_changed test.buff.work run data modify entity @s data.crafter_ui.book set from storage test: registry_work.book_now
execute if score #book_changed test.buff.work matches 1 run data modify storage test: registry_work.magic_clicks.book set value 1b
# 下段: 全て消去(18) / クラフト(26)。どちらも常時表示なので条件なしで検知できる
execute unless data block ~ ~ ~ Items[{Slot:18b}] run data modify storage test: registry_work.magic_clicks.s18 set value 1b
execute unless data block ~ ~ ~ Items[{Slot:26b}] run data modify storage test: registry_work.magic_clicks.s26 set value 1b

execute store result score #magic_click_count test.buff.work run data get storage test: registry_work.magic_clicks
execute if score #magic_click_count test.buff.work matches 1.. run function test:magic/crafter/process_clicks

# UI用アイテム(矢印・要素・ボタン・プレビュー)は取っても意味が無いので、誤って手元に
# 残らないようこのtick内で必ず回収する(目印を持たない物は対象外なので、プレイヤーが元々
# 持っている本物の矢印等を巻き込むことはない)
clear @p[distance=..3] *[custom_data~{test:{crafter_ui:1b}}]
