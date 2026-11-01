#> test:quest/notify
# @s = プレイヤー。@macro id: クエスト。今の段階の説明と進み具合を、アクションバーと効果音で知らせる(メインは全員に)。
# 例:「薬草集め: ゴブリンを倒す 1/3」

$function test:quest/st_get {id:"$(id)"}
execute unless data storage test: quest_work.st{state:"active"} run return 0
$data modify storage test: quest_work.na set value {id:"$(id)",stage:0}
data modify storage test: quest_work.na.stage set from storage test: quest_work.st.stage
function test:quest/notify_load with storage test: quest_work.na
