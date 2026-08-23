#> test:craft/magic/research/type
# @s = 研究するプレイヤー
# @macro type: 習得したい魔法タイプ(レジストリ test:init/asset/magic/types のid)

$function test:craft/magic/research/learn {id:"$(type)"}
