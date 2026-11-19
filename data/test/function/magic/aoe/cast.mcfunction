#> test:magic/aoe/cast
# 武器弾のAoE(magic.player.data.action.kind="weapon")はtest:action/weapon/groupで包んでから
# 本体(cast_body)を呼ぶ。純粋な魔法のAoEはそのまま本体を呼ぶ
execute if data storage test: magic.player.data.action{kind:"weapon"} run return run function test:action/weapon/group {body:"test:magic/aoe/cast_body"}
return run function test:magic/aoe/cast_body
