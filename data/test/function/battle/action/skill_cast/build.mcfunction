#> test:battle/action/skill_cast/build
# @s = 詠唱者(#oh_my_dat:pleaseは呼び出し元で実行済み)
# 選択中のタイプ・効果からstorage test: magic.playerを組み立て、消費MPを#skill_cost test.temporaryへ返す
#
# クラフト時と同じアセット関数(test:asset/magic/type|effect|status/<id>)をそのまま呼ぶことで、
# 戦闘中の消費MPや効果の内容がクラフトした魔法と必ず一致するようにしている。
# レジストリ駆動なのでタイプ・効果を増やしてもここは無改修

function test:asset/magic/reset

data modify storage test: registry_work.combo.type_flags set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type

function test:magic/registry/queue_types
function test:battle/action/skill_cast/build_type_loop

function test:magic/registry/queue_effects
function test:battle/action/skill_cast/build_effect_loop

# 範囲拡大の合算はクラフト時と同じ仕上げ工程を使う
function test:magic/crafter/finalize

data remove storage test: magic.player
data modify storage test: magic.player set from storage test: magic.loot.status
scoreboard players operation #skill_cost test.temporary = #cost test.temporary
