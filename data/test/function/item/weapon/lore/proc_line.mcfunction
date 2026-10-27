#> test:item/weapon/lore/proc_line
# @macro event: 自動発動の枠のイベント(magic・nameも渡ってくるが、ここではproc_queue[0]から読む)。
# 「  <イベントの表示名>: <魔法の名前>  消費MP <cost>」の1行を描く。表示名は asset.equip.proc_events(init/asset/equip/)

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"  ",color:"gray"}
$data modify storage test: lore_work.line[-1].text set from storage test: asset.equip.proc_events[{id:"$(event)"}].label
data modify storage test: lore_work.line append value {text:": ",color:"gray"}
execute unless data storage test: lore_work.proc_queue[0].magic run data modify storage test: lore_work.line append value {text:"なし(魔法付与台で付ける)",color:"dark_gray"}
execute if data storage test: lore_work.proc_queue[0].magic run function test:item/weapon/lore/proc_magic
function test:item/weapon/lore/commit
