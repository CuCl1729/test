#> test:quest/advance
# @s = プレイヤー。@macro id: クエスト。次の段階へ進める(数は0から)。最後の段階を終えていれば完了にする

$function test:quest/st_get {id:"$(id)"}
execute store result score #qs test.temporary run data get storage test: quest_work.st.stage
scoreboard players add #qs test.temporary 1
execute store result storage test: quest_work.st.stage int 1 run scoreboard players get #qs test.temporary
data modify storage test: quest_work.st.count set value 0
$execute store result score #ql test.temporary run data get storage test: asset.quest.$(id).last
$execute if score #qs test.temporary > #ql test.temporary run return run function test:quest/complete {id:"$(id)"}
$function test:quest/st_set {id:"$(id)"}
$function test:quest/notify {id:"$(id)"}
