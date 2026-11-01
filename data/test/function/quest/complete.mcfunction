#> test:quest/complete
# @s = プレイヤー。@macro id: クエスト。完了にして報酬の処理を行い、「クエスト完了」と出す。メインクエストは、報酬をパーティの全員に行う

data modify storage test: quest_work.st.state set value "done"
$function test:quest/st_set {id:"$(id)"}
$execute if data storage test: asset.quest.$(id){main:1b} run return run function test:quest/complete_main {id:"$(id)"}
$function test:quest/reward {id:"$(id)"}
$tellraw @s [{text:"クエスト完了: ",color:"gold"},{storage:"test:",nbt:"asset.quest.$(id).name",interpret:true,color:"white"}]
execute at @s run playsound minecraft:ui.toast.challenge_complete master @s
