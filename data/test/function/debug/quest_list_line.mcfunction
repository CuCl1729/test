#> test:debug/quest_list_line
# @s = プレイヤー。@macro id: クエスト。名前・種類・状態(state / stage / count)と、操作のボタン

$function test:quest/st_get {id:"$(id)"}
data modify storage test: debug_work.qk set value "サブ"
$execute if data storage test: asset.quest.$(id){main:1b} run data modify storage test: debug_work.qk set value "メイン"
$tellraw @s [{text:" ",color:"white"},{storage:"test:",nbt:"asset.quest.$(id).name",interpret:true,color:"white"},{text:" (",color:"gray"},{storage:"test:",nbt:"debug_work.qk",interpret:true,color:"gray"},{text:") ",color:"gray"},{storage:"test:",nbt:"quest_work.st.state",interpret:true,color:"aqua"},{text:" 段階",color:"gray"},{storage:"test:",nbt:"quest_work.st.stage",color:"aqua"},{text:" 数",color:"gray"},{storage:"test:",nbt:"quest_work.st.count",color:"aqua"},{text:" "},{text:"[受ける]",color:"green",click_event:{action:"run_command",command:"/function test:debug/quest_op {id:$(id),op:start}"}},{text:"[進める]",color:"yellow",click_event:{action:"run_command",command:"/function test:debug/quest_op {id:$(id),op:advance}"}},{text:"[完了]",color:"gold",click_event:{action:"run_command",command:"/function test:debug/quest_op {id:$(id),op:complete}"}},{text:"[戻す]",color:"red",click_event:{action:"run_command",command:"/function test:debug/quest_op {id:$(id),op:reset}"}}]
