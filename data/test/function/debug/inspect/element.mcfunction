#> test:debug/inspect/element
# @s = 表示する対象。@macro type/label: 属性名(fire等)と表示名

$tellraw @a[tag=debug_viewer] [{text:"  $(label): ",color:gray},{score:{name:"@s",objective:"test.$(type)_damage"},color:white},{text:" / ",color:gray},{score:{name:"@s",objective:"test.$(type)_resist"},color:white},{text:" / ",color:gray},{score:{name:"@s",objective:"test.$(type)_resist.pene"},color:white},{text:" / ",color:gray},{score:{name:"@s",objective:"test.$(type)_resist.debuff"},color:white},{text:" / ",color:gray},{score:{name:"@s",objective:"test.$(type)_damage_inc.bonus"},color:white}]
