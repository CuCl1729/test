#> test:consumable/dispatch
# @s = 使う人。@macro kind: 効果の種類。test:consumable/effect/<kind> に consumable_work.effect.params をマクロ引数として渡す
# (効果を増やすときは effect/<kind> と、説明文の lore/<kind> を1つずつ書き、スプレッドシートの「効果」にその名前を書く)

$function test:consumable/effect/$(kind) with storage test: consumable_work.effect.params
