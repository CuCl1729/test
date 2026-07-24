$execute store result score #substatus test.temporary run data get storage test: loot.table.substatus[{type:"$(type)"}].value 100

scoreboard players operation #substatus test.temporary += #status test.temporary

$execute store result storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].value double 0.01 run scoreboard players get #substatus test.temporary

# 強化回数を実データとして加算（表示用の文字列パースには依存しない）
$execute store result score #grow test.temporary run data get storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].grow
scoreboard players add #grow test.temporary 1
$execute store result storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].grow int 1 run scoreboard players get #grow test.temporary

# 実データ(grow)から表示テキストを毎回作り直す
data modify entity @n[tag=text] text set value {score:{name:"#grow",objective:"test.temporary"}}
$execute unless data storage test: loot.item.components."minecraft:lore"[$(substatus)].extra[{text:"+"}] run data modify storage test: loot.item.components."minecraft:lore"[$(substatus)].extra append value {italic:false,color:gold,text:"+"}
$execute if score #grow test.temporary matches 1 run data modify storage test: loot.item.components."minecraft:lore"[$(substatus)].extra append value {italic:false,color:gold,text:""}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)].extra[-1].text set from entity @n[tag=text] text