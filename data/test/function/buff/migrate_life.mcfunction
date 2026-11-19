#> test:buff/migrate_life
# 内部。@macro id: 移すバフ。全段の時間を戻す(refresh_all)バフは、段を足すたびに全段の残り時間がそろうので、
# 付与元ごとの残り時間は保てない。全部を古い表示の残り時間(一番長い残り)で付け直す
$execute unless data storage test: asset.buff.types[{id:"$(id)",stack_lifetime:"refresh_all"}] run return 0
execute if data storage test: buff_work.mig.one.remaining run data modify storage test: buff_work.mig.one.src[].remaining set from storage test: buff_work.mig.one.remaining
