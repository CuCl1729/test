#> test:magic/field/stay_check
# @s = まだ場の中に居る者。@macro e: 通し番号。
# 覚えている内容はそのまま次のパルスへ持ち越し(keep)、自然に切れていたバフだけ
# 同じ段数で掛け直す。覚えている段数は増やさないので、中に居続けても段数は増えない
$data modify storage test: field_work.stay set from storage test: field_work.members[{e:$(e)}]
data modify storage test: field_work.keep append from storage test: field_work.stay

data modify storage test: field_work.renew set value []
data modify storage test: field_work.renew set from storage test: field_work.stay.buff
function test:magic/field/renew_loop
