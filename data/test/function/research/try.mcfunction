#> test:research/try
# @s = 研究の項目をクリックしたプレイヤー。@macro id: 研究のid。
# 条件を全部満たしていればスキルポイントを払って研究し、解放のものを全部解放する。足りなければ最初に足りないものを1つ出す

function #oh_my_dat:please
$function test:research/eval {id:"$(id)"}
execute if score #rs_done test.temporary matches 1 run return run tellraw @s {text:"研究済み",color:"gray"}
execute if score #rs_ok test.temporary matches 0 run return run function test:research/try_missing with storage test: research_work
execute store result score #rs_cost test.temporary run data get storage test: research_work.def.cost
scoreboard players operation @s test.status.skill_point -= #rs_cost test.temporary
$function test:research/grant {id:"$(id)"}
function test:research/try_done with storage test: research_work.def
