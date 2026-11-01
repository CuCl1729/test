#> test:quest/notify_load
# @s = プレイヤー。@macro id/stage: クエストと今の段階。表示に使う名前・説明・数を quest_work.nt に入れて出す

data modify storage test: quest_work.nt set value {name:"",desc:"",c:0,n:0,tgt:"@s"}
$data modify storage test: quest_work.nt.name set from storage test: asset.quest.$(id).name
$data modify storage test: quest_work.nt.desc set from storage test: asset.quest.$(id).stages.s$(stage).desc
$data modify storage test: quest_work.nt.n set from storage test: asset.quest.$(id).stages.s$(stage).count
data modify storage test: quest_work.nt.c set from storage test: quest_work.st.count
$execute if data storage test: asset.quest.$(id){main:1b} run data modify storage test: quest_work.nt.tgt set value "@a"
function test:quest/notify_show with storage test: quest_work.nt
