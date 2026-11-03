#> test:magic/crafter/rebuild
# @s = クラフター本体(barrelの位置)。data.crafter_ui.build が変わるたび(追加/削除/全消去/クラフト後)
# に呼ぶ。効果をゼロから積み直し、名前を組み立て直し、中段とプレビューを描画し直す
#
# 削除時のUndo計算を避けるため、常に「reset→現在のbuildを先頭から全部再生」で組み立て直す
# (旧・素材アイテム式のクラフターがクラフトのたびにスロット9〜17を全スキャンし直していたのと同じ考え方)
#
# 組み立て列はつなぎ(types の role:"link")で「段」に区切る。段ごとに今までどおり1つの status を組み立て、
# 1段目を magic.loot.status に、2段目以降を magic.loot.status.chain = [{link, link_params, stage}] に入れる
# (つなぎの無い魔法は今までと全く同じ形になる)。段やつなぎの決まりに合わなければ magic.loot.invalid を立てる

scoreboard players set #cost_total test.temporary 0
scoreboard players set #stage_invalid test.temporary 0
data modify storage test: registry_work.stages set value []
data modify storage test: registry_work.stage_ids set value []
data modify storage test: registry_work.stage_link set value ""
data modify storage test: registry_work.stage_link_params set value {}

# 組み立て列を前から読む(reverse_loop で反転したものを末尾から取ると、元の順になる)
data modify storage test: registry_work.reverse_src set value []
execute if data entity @s data.crafter_ui.build[0] run data modify storage test: registry_work.reverse_src set from entity @s data.crafter_ui.build
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop
# 段の検証(validate → queue_types)も reverse_dst を使うので、読む列は別の場所に移してから読む
data modify storage test: registry_work.stage_seq set value []
data modify storage test: registry_work.stage_seq set from storage test: registry_work.reverse_dst
execute if data entity @s data.crafter_ui.build[0] run function test:magic/crafter/stage_loop
execute if data entity @s data.crafter_ui.build[0] run function test:magic/crafter/stage_close

function test:magic/crafter/stage_assemble

function test:magic/build_name

function test:magic/crafter/populate_build
function test:magic/crafter/populate_preview
