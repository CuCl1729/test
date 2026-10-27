#> test:item/weapon/lore/proc_line
# @macro event: 自動発動の枠のイベント(他のキーも渡ってくるが、中身はlore_work.proc_curから読む)。
# イベントで動く枠(魔法・アイテム・空)の1行を描く。イベントの表示名は asset.equip.proc_events(init/asset/equip/)
#   魔法:     「  <イベントの表示名>: <魔法の名前>  消費MP <cost>」(kindが無く魔法がある古い枠も魔法として描く)
#   アイテム: 「  <イベントの表示名>: <消耗品の名前> を使う(<every>回ごと)」
#   空:       「  <イベントの表示名>: なし」

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"  "}
data modify storage test: lore_work.line append value {text:"",color:"gray"}
$data modify storage test: lore_work.line[-1].text set from storage test: asset.equip.proc_events[{id:"$(event)"}].label
data modify storage test: lore_work.line append value {text:": ",color:"gray"}

scoreboard players set #lore_proc_drawn test.temporary 0
execute if data storage test: lore_work.proc_cur{kind:"item"} run scoreboard players set #lore_proc_drawn test.temporary 1
execute if data storage test: lore_work.proc_cur{kind:"item"} run function test:item/weapon/lore/proc_item with storage test: lore_work.proc_cur
execute if score #lore_proc_drawn test.temporary matches 0 if data storage test: lore_work.proc_cur.magic run function test:item/weapon/lore/proc_magic
execute if data storage test: lore_work.proc_cur.magic run scoreboard players set #lore_proc_drawn test.temporary 1
execute if score #lore_proc_drawn test.temporary matches 0 run data modify storage test: lore_work.line append value {text:"なし",color:"dark_gray"}

function test:item/weapon/lore/commit
