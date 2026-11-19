#> test:buff/attribute/remove
# @s = バフ保持者。@macro attribute: 属性id / modifier: 自分の修飾子id
# test:buff/attribute/addで入れた自分の修飾子だけを外す(終了イベントから呼ぶ)

$attribute @s $(attribute) modifier remove $(modifier)
