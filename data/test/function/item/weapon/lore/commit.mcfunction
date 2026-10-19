#> test:item/weapon/lore/commit
# 組み立てた1行(lore_work.line)を説明文の末尾に足す

data modify storage test: loot.item.components."minecraft:lore" append from storage test: lore_work.line
