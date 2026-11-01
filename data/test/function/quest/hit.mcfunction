#> test:quest/hit
# @s = プレイヤー(oh_my_dat は @s を指している)。@macro id/stage/need/add: クエストの今の段階が stage なら、数を add 増やす。need に届いたら次の段階へ

$function test:quest/st_get {id:"$(id)"}
execute unless data storage test: quest_work.st{state:"active"} run return 0
$execute unless data storage test: quest_work.st{stage:$(stage)} run return 0
execute store result score #qc test.temporary run data get storage test: quest_work.st.count
$scoreboard players add #qc test.temporary $(add)
execute store result storage test: quest_work.st.count int 1 run scoreboard players get #qc test.temporary
$function test:quest/st_set {id:"$(id)"}
$execute if score #qc test.temporary matches $(need).. run return run function test:quest/advance {id:"$(id)"}
$function test:quest/notify {id:"$(id)"}
