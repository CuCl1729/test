#> test:battle/ui/cart_holder
# @s = トロッコ。実際にアイコンを持つ人だけを処理する。地面へ捨てたアイコンも無効にする。
$execute as @a[distance=..8] at @s if items entity @s player.cursor *[minecraft:custom_data~{test:{battle_input:{epoch:$(epoch),slot:$(slot)b}}}] run function test:battle/ui/cart_answer {action:"$(action)",slot:$(slot),epoch:$(epoch)}
$execute as @a[distance=..8] at @s if items entity @s container.* *[minecraft:custom_data~{test:{battle_input:{epoch:$(epoch),slot:$(slot)b}}}] run function test:battle/ui/cart_answer {action:"$(action)",slot:$(slot),epoch:$(epoch)}
$execute as @e[type=item,distance=..8] if items entity @s contents *[minecraft:custom_data~{test:{battle_input:{epoch:$(epoch),slot:$(slot)b}}}] run kill @s
