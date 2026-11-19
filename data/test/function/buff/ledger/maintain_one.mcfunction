#> test:buff/ledger/maintain_one
# @macro = buff_ledger.arg。work.u(同じ付与元の段)1件ぶん。
# 希望より多く持っていれば、古い段から終わらせる(新しい段を残す = 後から付与された段を優先する規則と同じ)。
# 残す段は残り時間・付与者・固定した数値だけ入れ直し、連番・経過時間・周期・タイマーは触らない。
# preserve_snapshot:1b が付いているときは、残り時間だけ入れ直して付与者・固定した数値も据え置く。
# 継続しているだけの段はイベントを出さない

execute if score #lg_excess test.buff.work matches 1.. run scoreboard players set #lg_drop test.buff.work 1
execute if score #lg_excess test.buff.work matches 1.. run function test:buff/ledger/occ with storage test: buff_ledger.work.ev
execute if score #lg_excess test.buff.work matches 1.. run scoreboard players remove #lg_excess test.buff.work 1
execute if score #lg_drop test.buff.work matches 1 run return 0

$data modify storage test: buff_ledger.work.u.remaining set value $(duration)
$execute unless data storage test: buff_ledger.arg{preserve_snapshot:1b} run data modify storage test: buff_ledger.work.u.caster set value $(caster)
execute unless data storage test: buff_ledger.arg{preserve_snapshot:1b} if data storage test: buff_ledger.arg.eff run data modify storage test: buff_ledger.work.u.eff set from storage test: buff_ledger.arg.eff
