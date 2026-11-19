#> test:projectile/move
# 武器弾(data.action.kind="weapon")はtest:action/weapon/groupで包んでから本体(move_body)を呼ぶ。
# 着弾が引き起こす直後の段(子AoE/連鎖)がすべて終わってから一度だけ戦闘を開始するための入れ子スコープ。
# 純粋な投射魔法はそのまま本体を呼ぶ
execute if data entity @s data.action{kind:"weapon"} run return run function test:action/weapon/group {body:"test:projectile/move_body"}
return run function test:projectile/move_body
