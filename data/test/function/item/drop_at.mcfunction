#> test:item/drop_at
# storage test: loot.item を、実行位置(どのディメンションでもよい)にアイテムとして落とす。動き(Motion)は0にするので、
# 真下にホッパーがあればそのまま吸い込まれる。その場で summon するので、同じtickに何度呼んでもよい
# (前はオーバーワールドで組み立てて別のディメンションへ移していたが、続けて呼ぶと2つ目以降が届かなかった)

data modify storage test: drop_work.arg set value {}
data modify storage test: drop_work.arg.item set from storage test: loot.item
function test:item/drop_at_summon with storage test: drop_work.arg
