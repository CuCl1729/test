#> test:research/knowledge_lore
# @s = プレイヤー(oh_my_dat は @s を指している)。研究のGUIに出す「知識」の説明文を research_work.klore に作る(属性ごとの量と、スキルポイント)

data modify storage test: research_work.klore set value []
data modify storage test: research_work.kt set from storage test: asset.knowledge_types
function test:research/knowledge_lore_loop
data modify storage test: research_work.kl set value {sp:0}
execute store result storage test: research_work.kl.sp int 1 run scoreboard players get @s test.status.skill_point
function test:research/knowledge_lore_sp with storage test: research_work.kl
