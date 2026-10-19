#> test:item/weapon/lore/line_begin
# 1行ぶんの部品リストを始める。リスト形式のテキストは先頭の要素が後続の親になるので、
# 先頭を空文字のitalic:falseにして行全体の斜体(説明文の既定)を消す

data modify storage test: lore_work.line set value [{text:"",italic:false}]
