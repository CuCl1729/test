$execute store result score #substatus test.temporary run data get storage test: loot.table.substatus[{type:"$(type)"}].value 100

scoreboard players operation #substatus test.temporary += #status test.temporary

$execute store result storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].value double 0.01 run scoreboard players get #substatus test.temporary

# 強化回数を実データとして加算（表示用の文字列パースには依存しない）
$execute store result score #grow test.temporary run data get storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].grow
scoreboard players add #grow test.temporary 1
$execute store result storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].grow int 1 run scoreboard players get #grow test.temporary
# 説明文の +N は、test:item/weapon/lore/renderがこのgrowから描く