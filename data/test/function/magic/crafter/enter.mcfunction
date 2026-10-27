#> test:magic/crafter/enter
# @s = 魔法台のマーカー(実行位置は樽)。作成モードに入ったときに画面を作る(test:station/enter_mode が呼ぶ)。
# 組み立て中の要素(crafter_ui.build)は、研究モードとの切り替えをまたいでも残す

execute unless data entity @s data.crafter_ui run data modify entity @s data.crafter_ui set value {page:0,has_next:0b,page_ids:[],build:[]}
data modify entity @s data.crafter_ui.page set value 0

function test:magic/crafter/populate_top
function test:magic/crafter/rebuild
