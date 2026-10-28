#> test:debug/spawn_enemy_id
# @macro id: 敵のid(スプレッドシートの「敵」タブ)。@s (プレイヤー) の近くに、その敵を test:turn 次元内に召喚する

$execute in test:turn positioned ~1 ~ ~ run function test:asset/enemy/spawn {id:"$(id)"}
