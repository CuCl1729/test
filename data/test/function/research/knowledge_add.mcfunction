#> test:research/knowledge_add
# @macro el/n: 属性と足す量。oh_my_dat が指すプレイヤーの test.research.knowledge.<el> に足す(知識は研究しても減らない)

$execute store result score #k test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.knowledge.$(el)
$scoreboard players add #k test.temporary $(n)
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.knowledge.$(el) int 1 run scoreboard players get #k test.temporary
