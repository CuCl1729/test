#> test:item/weapon/lore/part_unit
# @macro unit: 値の単位("%" か、実数のステータスなら空文字)

$data modify storage test: lore_work.line append value {text:"$(unit)",color:"aqua"}
