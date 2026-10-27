#> test:craft/equip_magic/return_loop
# @s = 付与台マーカー。上書きした枠に入っていたルーン(equip_magic_work.returns のid)を1つずつ作り直して返す。
# loot/give は作業用の loot.item を使い回すので、付与した装備を渡し終えた後に呼ぶこと

execute unless data storage test: equip_magic_work.returns[0] run return 0

data modify storage test: equip_magic_work.return_arg.id set from storage test: equip_magic_work.returns[0]
function test:craft/equip_magic/return_rune with storage test: equip_magic_work.return_arg

data remove storage test: equip_magic_work.returns[0]
function test:craft/equip_magic/return_loop
