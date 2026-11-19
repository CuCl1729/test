#> test:magic/field/pulse
# 武器弾由来の場(magic.player.data.action.kind="weapon"、呼び出し元のtest:magic/field/tickが
# 既に読んである)はtest:action/weapon/groupで包んでから本体(pulse_body)を呼ぶ。
# 純粋な魔法の場はそのまま本体を呼ぶ
execute if data storage test: magic.player.data.action{kind:"weapon"} run return run function test:action/weapon/group {body:"test:magic/field/pulse_body"}
return run function test:magic/field/pulse_body
