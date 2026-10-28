#> test:debug/spawn_enemy_id
# @macro id: 敵のid(スプレッドシートの「敵」タブ)。@s (プレイヤー) のすぐ横、今いる次元に召喚する。
# 殴るとバトルになるのとフィールドのAIは test:turn でのみ動く(test:action ではそのままダメージが入る)

$execute positioned ~1 ~ ~ run function test:asset/enemy/spawn {id:"$(id)"}
