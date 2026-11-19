#> test:buff/attribute/add
# @s = バフ保持者。@macro attribute: 属性id / modifier: 自分の修飾子id(例: test:speed_up) / amount: 量 / operation: add_value等
#
# ネイティブの属性修飾子を使うバフの共通ヘルパー。同名の修飾子を先に外してから入れ直すので、
# 掛け直し(expireで外した直後にapplyで入れる)でも増殖しない。他の修飾子(バニラのポーション等)には触れない

$attribute @s $(attribute) modifier remove $(modifier)
$attribute @s $(attribute) modifier add $(modifier) $(amount) $(operation)
