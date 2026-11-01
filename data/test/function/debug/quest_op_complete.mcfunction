#> test:debug/quest_op_complete
# @s = プレイヤー。@macro id: クエストを完了にする(報酬も行う)

$function test:quest/st_get {id:"$(id)"}
execute if data storage test: quest_work.st{state:"done"} run return run tellraw @s {text:"もう完了している",color:"gray"}
$function test:quest/complete {id:"$(id)"}
