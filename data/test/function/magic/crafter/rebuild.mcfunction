#> test:magic/crafter/rebuild
# @s = クラフター本体(barrelの位置)。data.crafter_ui.build が変わるたび(追加/削除/全消去/クラフト後)
# に呼ぶ。効果をゼロから積み直し、名前を組み立て直し、中段とプレビューを描画し直す
#
# 削除時のUndo計算を避けるため、常に「reset→現在のbuildを先頭から全部再生」で組み立て直す
# (旧・素材アイテム式のクラフターがクラフトのたびにスロット9〜17を全スキャンし直していたのと同じ考え方)

function test:asset/magic/reset

data modify storage test: registry_work.build_queue set value []
execute if data entity @s data.crafter_ui.build[0] run data modify storage test: registry_work.build_queue set from entity @s data.crafter_ui.build
function test:magic/crafter/build_effect_loop

# 範囲拡大(range)等、順序非依存に集計した数値をここでまとめて反映する(既存のクラフト・ターン制詠唱と共通)
function test:magic/crafter/finalize

function test:magic/build_name

function test:magic/crafter/populate_build
function test:magic/crafter/populate_preview
