#> test:job/skill/bundle_resolve_as_owner
# @s = 特定できたオーナー。@macro kind(+job/node): 取り出された印アイテムのcustom_data.test
# 種別に応じて発動してから、バンドルを満杯へ戻す(位置・並びを保ったまま補充するだけで、
# skill_order自体はここでは一切変更しない)

function #oh_my_dat:please

execute if data storage test: job_work.consume_entry{kind:"sword"} run function test:attack/aoe
$execute if data storage test: job_work.consume_entry{kind:"job"} run function test:job/skill/use {job:"$(job)",node:"$(node)"}

function test:job/bundle/rebuild
