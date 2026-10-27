#> test:craft/magic/research/enter
# @s = 魔法台のマーカー(実行位置は樽)。研究モードに入ったときに画面を作る(test:station/enter_mode が呼ぶ)

data modify entity @s data.research_ui set value {page:0,has_next:0b,page_ids:[]}
function test:craft/magic/research/populate_top
