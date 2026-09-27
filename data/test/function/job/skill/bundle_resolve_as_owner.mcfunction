#> test:job/skill/bundle_resolve_as_owner
# @s = 特定できたオーナー。@macro job/node: 取り出された印アイテムのcustom_data.test
# 職業スキルを発動してから、バンドルを満杯へ戻す(位置・並びを保ったまま補充するだけで、
# skill_order自体はここでは一切変更しない)

function #oh_my_dat:please

$function test:job/skill/use {job:"$(job)",node:"$(node)"}

function test:job/bundle/rebuild
