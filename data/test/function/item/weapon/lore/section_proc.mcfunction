#> test:item/weapon/lore/section_proc
# 装備の自動発動の枠(equip.procs)を、見出しの下に1枠1行で描く。
#   ✦ 自動発動
#     ダメージを受けたとき: <魔法の名前>  消費MP <cost>
#     攻撃が当たったとき: なし(魔法付与台で付ける)

data modify storage test: loot.item.components."minecraft:lore" append value [{text:""}]
function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"✦ ",color:"light_purple"}
data modify storage test: lore_work.line append value {text:"自動発動",color:"gray"}
function test:item/weapon/lore/commit

data modify storage test: lore_work.proc_queue set from storage test: lore_work.data.equip.procs
function test:item/weapon/lore/proc_loop
