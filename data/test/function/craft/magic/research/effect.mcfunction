#> test:craft/magic/research/effect
# @s = 研究するプレイヤー
# @macro effect: 習得したい魔法効果(レジストリ test:init/asset/magic/effects のid)

$function test:craft/magic/research/learn {id:"$(effect)"}
