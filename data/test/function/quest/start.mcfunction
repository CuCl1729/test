#> test:quest/start
# @s = プレイヤー(oh_my_dat は @s を指している)。@macro id: 受けるクエスト(処理 start:)。まだ受けていなければ段階1から始める。
# メインクエストはパーティで共有(全員に知らせる)

$function test:quest/st_get {id:"$(id)"}
execute unless data storage test: quest_work.st{state:"none"} run return 0
data modify storage test: quest_work.st set value {state:"active",stage:1,count:0}
$function test:quest/st_set {id:"$(id)"}
$execute if data storage test: asset.quest.$(id){main:1b} run tellraw @a [{text:"クエスト開始: ",color:"gold"},{storage:"test:",nbt:"asset.quest.$(id).name",interpret:true,color:"white"}]
$execute unless data storage test: asset.quest.$(id){main:1b} run tellraw @s [{text:"クエスト開始: ",color:"gold"},{storage:"test:",nbt:"asset.quest.$(id).name",interpret:true,color:"white"}]
$function test:quest/notify {id:"$(id)"}
