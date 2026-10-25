#> test:item/weapon/level_up/grow_main_add
# @macro grow_type: 伸ばすステータスの種類。#grow_cur(×100)に1回ぶんの伸びを足す

$execute store result score #status test.temporary run data get storage test: loot.table.grow[{type:"$(grow_type)"}].value 100
scoreboard players operation #grow_cur test.temporary += #status test.temporary
