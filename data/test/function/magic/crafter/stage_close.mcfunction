#> test:magic/crafter/stage_close
# @s = クラフター本体。registry_work.stage_ids(今の段の要素)を今までどおり1つの status に組み立て、
# 段の決まりを確かめて registry_work.stages に積む
function test:asset/magic/reset
data modify storage test: registry_work.build_queue set from storage test: registry_work.stage_ids
function test:magic/crafter/build_effect_loop
# 範囲拡大(range)等、順序非依存に集計した数値をここでまとめて反映する(既存のクラフト・ターン制詠唱と共通)
function test:magic/crafter/finalize
# 生成レシピ向けの段ごと数値設定(あれば)を、確定した段の内容に適用する
function test:magic/recipe/settings

# 段の決まり: 届け方が1つで相反しない / 届け方がある / 設置の段は設置だけ / 効果の requires_type が段の中にある
function test:magic/crafter/validate
execute if score #combo_invalid test.temporary matches 1 run scoreboard players set #stage_invalid test.temporary 1
execute unless data storage test: magic.loot.status.magic_type run scoreboard players set #stage_invalid test.temporary 1
execute if data storage test: magic.loot.status{magic_type:"place"} if data storage test: registry_work.stage_ids[1] run scoreboard players set #stage_invalid test.temporary 1
data modify storage test: registry_work.requires_queue set from storage test: registry_work.stage_ids
function test:magic/crafter/stage_requires_loop

# 構造の決まりを通ったら、「この組み合わせが表にあるか」を実行時と同じ表で見る。
# 当たった行の「支払い」が 維持 なら #stage_upkeep が立つ
scoreboard players set #stage_upkeep test.temporary 0
execute if data storage test: magic.loot.status.magic_type run function test:magic/crafter/stage_combo

# 費用。入れないのは2つ:
#   ・「一定間隔」やビームへのつなぎより後ろの段(起こされる側なので無料。入れ子も可)
#   ・押している間だけ払う形の段(ビーム。唱えたときの前払いが無く、維持MPだけ)
# どちらでもなければ今までどおり見積りに足す
execute if score #child_free test.temporary matches 0 if score #stage_upkeep test.temporary matches 0 run scoreboard players operation #cost_total test.temporary += #cost test.temporary

data modify storage test: registry_work.stages append value {link:"",link_params:{},link_behavior:"",status:{}}
data modify storage test: registry_work.stages[-1].link set from storage test: registry_work.stage_link
data modify storage test: registry_work.stages[-1].link_params set from storage test: registry_work.stage_link_params
data modify storage test: registry_work.stages[-1].link_behavior set from storage test: registry_work.stage_link_behavior
data modify storage test: registry_work.stages[-1].status set from storage test: magic.loot.status
data modify storage test: registry_work.stage_ids set value []
