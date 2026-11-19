#> test:magic/crafter/stage_combo
# @s = クラフター本体。閉じたばかりの段(magic.loot.status)が、組み合わせの表のどれかに当たるかを見る。
# 実行時と全く同じ表・同じ関数(test:magic/combo/match)を使うので、クラフトできたものは必ず動く
#
# 発生元は段の位置で決まる: 1段目はプレイヤーが直接唱える、2段目以降は設置物や弾が起こす。
# 当たる行が無ければ不正にし、理由(未定義の組み合わせ)を残す。当たったら説明を段に覚えさせ、
# 魔法台のプレビューとアイテムのロアがそれを出す。
# 当たった行の「支払い」が 維持 なら、その段ぶんの費用は見積りに入れない(#stage_upkeep)
scoreboard players set #stage_upkeep test.temporary 0

data remove storage test: combo_work.flags
data modify storage test: combo_work.flags set from storage test: magic.loot.status.type_flags
data modify storage test: combo_work.apply set value "stage"
data modify storage test: combo_work.emitter set value "player"
execute if data storage test: registry_work.stages[0] run data modify storage test: combo_work.emitter set value "source"
function test:magic/combo/match

execute if score #combo_found test.temporary matches 0 run return run function test:magic/crafter/stage_combo_none

data modify storage test: magic.loot.status.combo set from storage test: combo_work.hit.desc

# 押している間だけ払う形(ビーム)。唱えたときの前払いは無く、維持MPだけになる
execute if data storage test: combo_work.hit{pay:"upkeep"} run scoreboard players set #stage_upkeep test.temporary 1
execute if data storage test: combo_work.hit{pay:"upkeep"} run data modify storage test: magic.loot.status.upkeep set from storage test: magic.loot.status.continuous.mp_per_second
return 1
