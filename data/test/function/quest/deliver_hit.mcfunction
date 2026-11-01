#> test:quest/deliver_hit
# @s = NPC に話しかけたプレイヤー(oh_my_dat は @s を指している)。@macro id/stage/need/pred: 納品の段階。今の段階なら、pred のアイテムを
# need 個以上持っていれば消して次の段階へ。足りなければ「あと◯個」と出す

$function test:quest/st_get {id:"$(id)"}
execute unless data storage test: quest_work.st{state:"active"} run return 0
$execute unless data storage test: quest_work.st{stage:$(stage)} run return 0
$execute store result score #qh test.temporary run clear @s $(pred) 0
$scoreboard players set #qn test.temporary $(need)
scoreboard players operation #qn test.temporary -= #qh test.temporary
execute if score #qn test.temporary matches 1.. run return run execute store success score @s test.ui.bar_shown run title @s actionbar [{text:"あと ",color:"gray"},{score:{name:"#qn",objective:"test.temporary"},color:"aqua"},{text:"個",color:"gray"}]
$clear @s $(pred) $(need)
$function test:quest/hit {id:"$(id)",stage:$(stage),need:$(need),add:$(need)}
