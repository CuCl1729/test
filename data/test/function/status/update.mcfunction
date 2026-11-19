#> test:status/update
# @s = プレイヤー。@macro status: ステータス名。手に持っている本物の武器を含めて装備から組み立て直し、
# バフ・職業・レベルのぶんを合流させて test.status.<名前> に入れ直す。
# 中身は test:status/gear(装備ぶんのキャッシュ)と test:status/compose(合流)の2段に分けてある
# (戦闘中のUI持ちや敵も同じ合流を通すため。test:buff/runtime/commit_one 参照)

$execute store result score #recalc_gear_ok test.buff.work run function test:status/gear {status:"$(status)"}
$execute if score #recalc_gear_ok test.buff.work matches 1 run function test:status/compose {status:"$(status)"}
