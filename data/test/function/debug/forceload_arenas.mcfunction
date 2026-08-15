#> test:debug/forceload_arenas
# 既存ワールド用の一度きりの補完コマンド。test:arena の各アリーナ座標を常時ロードにする。
# (新規ワールドでは test:init/ が自動で行うため、このコマンドは不要)

execute in test:arena run forceload add 0 0 0 0
execute in test:arena run forceload add 500 0 500 0
execute in test:arena run forceload add 1000 0 1000 0
execute in test:arena run forceload add 1500 0 1500 0
