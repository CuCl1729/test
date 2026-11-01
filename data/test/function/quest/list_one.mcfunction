#> test:quest/list_one
# @s = プレイヤー。@macro id: クエスト。受けていれば「名前(メイン): 段階の説明 数/必要数」を出す

$function test:quest/st_get {id:"$(id)"}
execute unless data storage test: quest_work.st{state:"active"} run return 0
scoreboard players add #ql_shown test.temporary 1
$data modify storage test: quest_work.na set value {id:"$(id)",stage:0}
data modify storage test: quest_work.na.stage set from storage test: quest_work.st.stage
function test:quest/list_show with storage test: quest_work.na
