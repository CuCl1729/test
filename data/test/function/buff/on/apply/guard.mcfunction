#> test:buff/on/apply/guard
# @s = バフ保持者。防御力を底上げする(#buff_stacks test.buff.work にスタック数。guardはmax_stacks:1)
# ダメージ計算式(test:damage/.mcfunction)を修正し、生DEFを増やせば正しく通過ダメージが減るように
# なったため、他のステータス系バフと同じくtest:buff/stat/addを使う

data modify storage test: buff_work.stat_arg set value {stat:"def",amount:1000}
function test:buff/stat/add with storage test: buff_work.stat_arg
