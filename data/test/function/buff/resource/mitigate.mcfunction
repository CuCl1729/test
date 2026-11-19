#> test:buff/resource/mitigate
# 内部。@s = 的。@macro type: 属性、row: 宣言された行の添字。buff_event.units の各段の値を、
# その段に固定した攻撃側の補正(eff.refs)と今の的の防御・耐性で軽減した値に置き換える
data modify storage test: buff_resource.mq set from storage test: buff_event.units
data modify storage test: buff_event.units set value []
$execute if data storage test: buff_resource.mq[0] run function test:buff/resource/mitigate_unit {type:"$(type)",i:$(row)}
