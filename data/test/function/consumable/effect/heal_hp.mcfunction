#> test:consumable/effect/heal_hp
# @s = 使う人。@macro percent: 最大HPの何%回復するか / flat: 固定で回復する量(装備の説明文と同じ単位)。
# 両方を足した分だけ回復する(test:consumable/heal)

$function test:consumable/heal {stat:"hp",percent:$(percent),flat:$(flat)}
