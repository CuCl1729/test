#> test:magic/root/begin
# @macro id / max_alive: 新しいキャスト(発動ルート)のルート元帳(magic_roots)を用意する。
# 既に同じidがあれば何もしない(リロード等で再び呼ばれても残り回数をリセットしないため)
execute unless data storage test: magic_roots run data modify storage test: magic_roots set value []
$execute if data storage test: magic_roots[{id:$(id)}] run return 1

$data modify storage test: magic_roots append value {id:$(id),refs:0,alive:0,max_alive:$(max_alive),next_source:1,sources:[{id:0,alive:0}]}
data modify storage test: magic_roots[-1].remaining set from storage test: asset.config.magic_root_limit
return 1
