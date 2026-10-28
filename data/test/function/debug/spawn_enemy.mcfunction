#> test:debug/spawn_enemy
# @s (プレイヤー) のすぐ横、今いる次元にテスト用ダミー敵を召喚する。
# test:turn では殴ると通常の戦闘開始トリガー(test:attack/damage)経由で戦闘が始まる。
# test:action ではそのままダメージが入る。
# ほかの敵は test:debug/spawn_enemy_id {id:<id>}(デバッグメニューの「敵」欄)

execute positioned ~1 ~ ~ run function test:asset/enemy/spawn {id:"dummy"}
