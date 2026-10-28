#> test:debug/spawn_goblin
# @s (プレイヤー) のすぐ横、今いる次元に動いて戦うテスト用の敵(ゴブリン)を召喚する。
# dummyと違い、test:turn では自分から巡回・追跡し、接触すると自分からバトルを仕掛けてくる。
# フィールドのAIは test:turn でのみ動くので、test:action では動かない。

execute positioned ~1 ~ ~ run function test:asset/enemy/spawn {id:"goblin"}
