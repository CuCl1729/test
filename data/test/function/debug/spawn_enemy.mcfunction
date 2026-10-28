#> test:debug/spawn_enemy
# @s (プレイヤー) の近くに、テスト用ダミー敵を test:turn 次元内に召喚する。
# 事前に test:debug/goto_turn 等で test:turn 次元に入っていること。
# 召喚後、近づいて殴ると通常の戦闘開始トリガー(test:attack/damage)経由で戦闘が始まる。
# ほかの敵は test:debug/spawn_enemy_id {id:<id>}(デバッグメニューの「敵」欄)

execute in test:turn positioned ~1 ~ ~ run function test:asset/enemy/spawn {id:"dummy"}
