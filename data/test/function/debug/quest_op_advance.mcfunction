#> test:debug/quest_op_advance
# @s = プレイヤー。@macro id: 受けているクエストを、次の段階へ進める(最後なら完了)

$function test:quest/st_get {id:"$(id)"}
execute unless data storage test: quest_work.st{state:"active"} run return run tellraw @s {text:"受けていない",color:"gray"}
$function test:quest/advance {id:"$(id)"}
