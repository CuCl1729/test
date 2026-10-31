#> test:research/eval_know_have
# @macro el: 属性。今の量を #k と research_work.kh.have に入れる

$execute store result score #k test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.knowledge.$(el)
execute store result storage test: research_work.kh.have int 1 run scoreboard players get #k test.temporary
