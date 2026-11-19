#> test:magic/beam/render
# 武器弾由来のビーム(magic.player.data.action.kind="weapon"、呼び出し元が既に読んである)は
# every render(#beam_apply0の壁/一定間隔コールバックを含む)をtest:action/weapon/groupで包んでから
# 本体(render_body)を呼ぶ。視覚だけの中継でも壁/一定間隔コールバックがダメージを伴う子AoEを
# 出しうるため、ここではaction_hitの新旧を見ずに常にこのフラグで包む。
# 純粋な詠唱描画はそのまま本体を呼ぶ
execute if data storage test: magic.player.data.action{kind:"weapon"} run return run function test:action/weapon/group {body:"test:magic/beam/render_body"}
return run function test:magic/beam/render_body
