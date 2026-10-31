#> test:debug/research_show_knowledge_one
# @s = プレイヤー。@macro id/label: 属性

$execute store result score #k test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.knowledge.$(id)
$tellraw @s [{text:" $(label) ",color:"gray"},{score:{name:"#k",objective:"test.temporary"},color:"aqua"}]
