#> test:craft/custom/unlocked
# @macro recipe: 当てはまったレシピ。craft_work.rec に定義を写し、作れるかを #cc_ok に入れる(1 作れる / 2 未研究)。
# どの研究にも入っていないレシピ(locked が無い)は最初から作れる。研究に入っているものは、近くのプレイヤーが
# test.unlock.recipe.<id> を持っていれば作れる(oh_my_dat は呼び出し元でそのプレイヤーを指している)

$data modify storage test: craft_work.rec set from storage test: asset.recipe.$(recipe)
scoreboard players set #cc_ok test.temporary 2
execute unless data storage test: craft_work.rec.locked run return run scoreboard players set #cc_ok test.temporary 1
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.unlock.recipe.$(recipe) run scoreboard players set #cc_ok test.temporary 1
