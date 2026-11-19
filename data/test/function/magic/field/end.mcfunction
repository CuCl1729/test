#> test:magic/field/end
# @s = 終わる場。この場が掛けていたバフ/デバフを、掛けた相手から残らず外してから消える。
# 掛けた記録(data.members)をそのまま「出た者」として扱えば、退出時と同じ処理で済む
# 外す相手を探すのに、この場の名前(付与元のキー)が要る
execute store result storage test: field_work.fid int 1 run scoreboard players get @s test.magic.eid

data modify storage test: field_work.members set from entity @s data.members
data modify storage test: field_work.inside set value []
data modify storage test: field_work.keep set value []
function test:magic/field/leave_loop

function test:magic/root/kill
