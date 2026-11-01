#> test:quest/list
# @s = /trigger test.quest を押したプレイヤー。受けているクエストの名前・今の段階の説明・進み具合と、口座の残高・持っているコインを出す

scoreboard players set @s test.quest 0
scoreboard players enable @s test.quest
function #oh_my_dat:please
tellraw @s {text:"― クエスト ―",color:"gold"}
scoreboard players set #ql_shown test.temporary 0
data modify storage test: quest_work.lq set from storage test: asset.quest_ids
function test:quest/list_loop
execute if score #ql_shown test.temporary matches 0 run tellraw @s {text:" 受けているクエストは無い",color:"gray"}
execute store result score #ql_coin test.temporary run function test:money/coins
scoreboard players add @s test.money 0
tellraw @s [{text:" 口座 ",color:"gray"},{score:{name:"@s",objective:"test.money"},color:"yellow"},{text:"G / コイン ",color:"gray"},{score:{name:"#ql_coin",objective:"test.temporary"},color:"yellow"},{text:"G",color:"gray"}]
