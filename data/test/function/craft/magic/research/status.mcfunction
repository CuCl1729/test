#> test:craft/magic/research/status
# @s = 研究するプレイヤー
# @macro status: 習得したい魔法ステータス強化(レジストリ test:init/asset/magic/effects のid)

$function test:craft/magic/research/learn {id:"$(status)"}
