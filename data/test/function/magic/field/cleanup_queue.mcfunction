#> test:magic/field/cleanup_queue
# @macro e: 見当たらない(オフラインの)相手の通し番号。field_work.leave.buff(この場が掛けていたぶん)と
# field_work.fid(この場の通し番号)を、戻ってきたとき(test:magic/field/rejoin)に外せるよう永続化する
execute unless data storage test: field_cleanup run data modify storage test: field_cleanup set value []
$execute unless data storage test: field_cleanup[{e:$(e)}] run data modify storage test: field_cleanup append value {e:$(e),pending:[]}

data modify storage test: field_work.cleanup_add set value {}
data modify storage test: field_work.cleanup_add.fid set from storage test: field_work.fid
data modify storage test: field_work.cleanup_add.buff set from storage test: field_work.leave.buff

$data modify storage test: field_cleanup[{e:$(e)}].pending append from storage test: field_work.cleanup_add
