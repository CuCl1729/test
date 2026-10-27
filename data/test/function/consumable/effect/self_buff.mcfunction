#> test:consumable/effect/self_buff
# @s = 使う人。@macro id: バフのid(init/asset/buff/buffs) / stacks: 段数。自分にバフを付ける

$function test:buff/apply {id:"$(id)",stacks:$(stacks)}
