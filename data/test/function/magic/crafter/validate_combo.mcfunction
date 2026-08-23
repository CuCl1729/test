#> test:magic/crafter/validate_combo
# 選ばれたタイプの組み合わせが成立するか検証する共通処理(クラフト時と戦闘のタイプ選択の両方から呼ぶ)
# 入力: storage test: registry_work.combo.type_flags (使われたタイプidのバイトフラグ)
#       #delivery_count test.temporary (デリバリタイプの個数)
# 出力: #combo_invalid test.temporary (0=成立 1=不正)
# ルールはレジストリ(test:init/asset/magic/types)のデータ駆動なので、タイプを増やしても無改修

scoreboard players set #combo_invalid test.temporary 0

# デリバリタイプ(届け方)は排他。2つ以上入っていたら不正
execute if score #delivery_count test.temporary matches 2.. run scoreboard players set #combo_invalid test.temporary 1

# 各タイプのconflictsを走査し、相反するタイプが同時に選ばれていないか調べる
function test:magic/registry/queue_types
function test:magic/crafter/validate_loop
