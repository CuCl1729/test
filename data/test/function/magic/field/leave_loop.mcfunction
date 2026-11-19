#> test:magic/field/leave_loop
# field_work.members を1つずつ見る。まだ中に居る相手は enter_check が keep に移してあるので、
# ここで扱うのは「もう中に居ない相手」だけ
execute unless data storage test: field_work.members[0] run return 0

data modify storage test: field_work.leave set from storage test: field_work.members[0]
data remove storage test: field_work.members[0]
function test:magic/field/leave_one with storage test: field_work.leave

function test:magic/field/leave_loop
