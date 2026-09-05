#> test:debug/spawn_goblin
# @s (プレイヤー) の近くに、動いて戦うテスト用の敵(ゴブリン)を test:turn 次元内に召喚する。
# 事前に test:debug/goto_turn 等で test:turn 次元に入っていること。
# dummyと違い自分から巡回・追跡し、接触すると自分からバトルを仕掛けてくる。

function test:asset/enemy/goblin/
execute in test:turn positioned ~1 ~ ~ run function test:asset/enemy/summon {id:"armor_stand"}
