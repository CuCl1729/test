#> test:item/weapon/lore/proc_rune
# ルーンの枠(lore_work.proc_cur)の1行を描く。ルーンはイベントで動かないので、イベント名の代わりに「ルーン」と出す。
#   「  ルーン: <ルーンの名前>  ⚔ 攻撃力 +5%  …」(能力は枠に写したstatusを、ステータスの行と同じ書き方で並べる)

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"  ルーン: ",color:"gray"}
function test:item/weapon/lore/proc_name {color:"light_purple"}

data modify storage test: lore_work.rune_queue set value []
data modify storage test: lore_work.rune_queue set from storage test: lore_work.proc_cur.status
function test:item/weapon/lore/proc_rune_loop

function test:item/weapon/lore/commit
