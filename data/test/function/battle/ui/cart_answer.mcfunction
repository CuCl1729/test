#> test:battle/ui/cart_answer
# @s = 取得者。カーソルと持ち物から今回のアイコンを取り除き、本人の手番だけ処理する。
$execute if items entity @s player.cursor *[minecraft:custom_data~{test:{battle_input:{epoch:$(epoch),slot:$(slot)b}}}] run item replace entity @s player.cursor with air
$clear @s *[minecraft:custom_data~{test:{battle_input:{epoch:$(epoch),slot:$(slot)b}}}]
execute unless function test:battle/ui/current_actor run return 0
$function test:battle/ui/$(action) {index:$(slot)}
