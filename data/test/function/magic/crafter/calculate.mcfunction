#> test:magic/crafter/calculate
# @s = クラフター本体(barrelの位置)。data.crafter_ui.build が変わるたび(追加/削除/全消去/クラフト後)
# に呼ぶ。効果と名前を、この台の組み立て列と本から計算する
#
# 削除時のUndo計算を避けるため、常に「reset→現在のbuildを先頭から全部再生」で組み立て直す
# (旧・素材アイテム式のクラフターがクラフトのたびにスロット9〜17を全スキャンし直していたのと同じ考え方)
#
# 組み立て列はつなぎ(types の role:"link")で「段」に区切る。段ごとに今までどおり1つの status を組み立て、
# 1段目を magic.loot.status に、2段目以降を magic.loot.status.chain = [{link, link_params, stage}] に入れる
# (つなぎの無い魔法は今までと全く同じ形になる)。段やつなぎの決まりに合わなければ magic.loot.invalid を立てる

data modify storage test: magic_recipe.build set value []
execute if data entity @s data.crafter_ui.build[0] run data modify storage test: magic_recipe.build set from entity @s data.crafter_ui.build
# 通常のクラフターUIには段ごと数値設定は無い。先の生成レシピの残りが紛れ込まないよう必ず消す
data remove storage test: magic_recipe.settings

function test:magic/recipe/compile

function test:magic/build_name
# 名前の枠(23)に本と羽根ペンがあれば、その1ページ目を名前にする
function test:magic/crafter/book_name

