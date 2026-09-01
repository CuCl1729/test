#> test:craft/magic/research/click_top
# @s = 研究ステーション本体。@macro index: 取られたスロットのpage_ids内インデックス(0〜6)
# クラフターと違い積み上げず、その場で習得を試みる

data modify storage test: registry_work.click set value {id:""}
$data modify storage test: registry_work.click.id set from entity @s data.research_ui.page_ids[$(index)]

execute as @p[distance=..3] run function test:craft/magic/research/click_top_learn with storage test: registry_work.click

function test:craft/magic/research/populate_top
