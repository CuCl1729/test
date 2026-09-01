#> test:magic/crafter/click_build
# @s = クラフター本体。@macro index: 取られたスロットのbuild内インデックス(0〜8)
# その1件だけ取り除く(NBTのリスト削除で残りは自動的に詰まる)。上段の表示は変わらないので無関係

$data remove entity @s data.crafter_ui.build[$(index)]

function test:magic/crafter/rebuild
