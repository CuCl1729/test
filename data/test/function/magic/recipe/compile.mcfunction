#> test:magic/recipe/compile
# storage test: magic_recipe.build (要素IDの配列) を組み立て列として段を計算する中核部分。
# calculate.mcfunction から crafter UI 依存を抜いた本体(呼び出し元が build を用意する)
#
# 削除時のUndo計算を避けるため、常に「reset→現在のbuildを先頭から全部再生」で組み立て直す
# (旧・素材アイテム式のクラフターがクラフトのたびにスロット9〜17を全スキャンし直していたのと同じ考え方)
#
# 組み立て列はつなぎ(types の role:"link")で「段」に区切る。段ごとに今までどおり1つの status を組み立て、
# 1段目を magic.loot.status に、2段目以降を magic.loot.status.chain = [{link, link_params, stage}] に入れる
# (つなぎの無い魔法は今までと全く同じ形になる)。段やつなぎの決まりに合わなければ magic.loot.invalid を立てる

scoreboard players set #cost_total test.temporary 0
scoreboard players set #stage_invalid test.temporary 0
# 「一定間隔」やビームへのつなぎを通った後の段は費用を取らない(入れ子も可)
scoreboard players set #child_free test.temporary 0
data remove storage test: registry_work.invalid_reason
data modify storage test: registry_work.stages set value []
data modify storage test: registry_work.stage_ids set value []
data modify storage test: registry_work.stage_link set value ""
data modify storage test: registry_work.stage_link_params set value {}
data modify storage test: registry_work.stage_link_behavior set value ""

# 信頼済み生成レシピ用の任意の段ごと数値設定(通常のUI組み立てには無い)。入力は書き換えない
data modify storage test: registry_work.recipe_settings set value []
execute if data storage test: magic_recipe.settings[0] run data modify storage test: registry_work.recipe_settings set from storage test: magic_recipe.settings

# 組み立て列を前から読む(reverse_loop で反転したものを末尾から取ると、元の順になる)
data modify storage test: registry_work.reverse_src set value []
execute if data storage test: magic_recipe.build[0] run data modify storage test: registry_work.reverse_src set from storage test: magic_recipe.build
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop
# 段の検証(validate → queue_types)も reverse_dst を使うので、読む列は別の場所に移してから読む
data modify storage test: registry_work.stage_seq set value []
data modify storage test: registry_work.stage_seq set from storage test: registry_work.reverse_dst
execute if data storage test: magic_recipe.build[0] run function test:magic/crafter/stage_loop
execute if data storage test: magic_recipe.build[0] run function test:magic/crafter/stage_close

function test:magic/crafter/stage_assemble
