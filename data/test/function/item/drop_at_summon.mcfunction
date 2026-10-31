#> test:item/drop_at_summon
# @macro item: 落とすアイテム(loot.item のコピー)。実行位置に、動かないアイテムとして出す

$summon item ~ ~ ~ {Item:$(item),Motion:[0.0d,0.0d,0.0d]}
