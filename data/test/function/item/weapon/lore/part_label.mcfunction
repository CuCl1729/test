#> test:item/weapon/lore/part_label
# @macro icon/color/label: 行頭のアイコン(ステータスの色)と名前(灰色)

$data modify storage test: lore_work.line append value {text:"$(icon) ",color:"$(color)"}
$data modify storage test: lore_work.line append value {text:"$(label) ",color:"gray"}
