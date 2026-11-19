#> test:buff/resource/credit_cand
# 内部。cands を削りながら、候補の術者を1人ぶん調べる。身元の鍵が同じ単位ぜんぶを
# 足し合わせ(src の字面が違っていてもまとめる)、今までの最良と上の桁から比べる。
# 同じ術者が二度候補に出たら足し合わせを飛ばす(結果は同じで、命令数だけ食う)

data modify storage test: buff_resource.cand set from storage test: buff_resource.cands[0]
data remove storage test: buff_resource.cands[0]

# 身元の鍵。本物のUUIDがあればそれだけで照らし合わせる(IDは使い回される手がかりなので、
# UUIDが同じなら同一人物)。UUIDの無い古い単位はIDだけ。kind は部分一致の衝突を防ぐ札
# (使い回されたIDを実体から引き直したりはしない。-1 の術者は -1 のまま不明)
data modify storage test: buff_resource.ckey set value {kind:"id"}
data modify storage test: buff_resource.ckey.caster set from storage test: buff_resource.cand.caster
execute if data storage test: buff_resource.cand.eff.caster_uuid run data modify storage test: buff_resource.ckey set value {kind:"uuid"}
execute if data storage test: buff_resource.cand.eff.caster_uuid run data modify storage test: buff_resource.ckey.uuid set from storage test: buff_resource.cand.eff.caster_uuid

# 既に足し合わせた術者なら、合計も seq も同じで最良は動かないので飛ばす。
# ただし残りの候補は続けて見る(ここで return すると後ろの術者が落ちる)
data modify storage test: buff_resource.karg set value {}
data modify storage test: buff_resource.karg.key set from storage test: buff_resource.ckey
scoreboard players set #br_dup test.buff.work 0
function test:buff/resource/credit_seen with storage test: buff_resource.karg
execute if score #br_dup test.buff.work matches 1 if data storage test: buff_resource.cands[0] run function test:buff/resource/credit_cand
execute if score #br_dup test.buff.work matches 1 run return 0
data modify storage test: buff_resource.seen append from storage test: buff_resource.ckey

scoreboard players set #br_lo test.buff.work 0
scoreboard players set #br_mid test.buff.work 0
scoreboard players set #br_hi test.buff.work 0
scoreboard players set #br_seq test.buff.work -1
# UUIDの鍵には caster が無いので、記録に出すIDは seq が一番大きい一致単位から取る
data modify storage test: buff_resource.kcaster set from storage test: buff_resource.cand.caster
data modify storage test: buff_resource.sum set from storage test: buff_event.units
execute if data storage test: buff_resource.sum[0] run function test:buff/resource/credit_sum with storage test: buff_resource.arg

scoreboard players set #br_win test.buff.work 0
execute if score #br_have test.buff.work matches 0 run scoreboard players set #br_win test.buff.work 1
execute if score #br_hi test.buff.work > #br_bhi test.buff.work run scoreboard players set #br_win test.buff.work 1
execute if score #br_hi test.buff.work = #br_bhi test.buff.work if score #br_mid test.buff.work > #br_bmid test.buff.work run scoreboard players set #br_win test.buff.work 1
execute if score #br_hi test.buff.work = #br_bhi test.buff.work if score #br_mid test.buff.work = #br_bmid test.buff.work if score #br_lo test.buff.work > #br_blo test.buff.work run scoreboard players set #br_win test.buff.work 1
execute if score #br_hi test.buff.work = #br_bhi test.buff.work if score #br_mid test.buff.work = #br_bmid test.buff.work if score #br_lo test.buff.work = #br_blo test.buff.work if score #br_seq test.buff.work > #br_bseq test.buff.work run scoreboard players set #br_win test.buff.work 1

execute if score #br_win test.buff.work matches 1 run scoreboard players operation #br_bhi test.buff.work = #br_hi test.buff.work
execute if score #br_win test.buff.work matches 1 run scoreboard players operation #br_bmid test.buff.work = #br_mid test.buff.work
execute if score #br_win test.buff.work matches 1 run scoreboard players operation #br_blo test.buff.work = #br_lo test.buff.work
execute if score #br_win test.buff.work matches 1 run scoreboard players operation #br_bseq test.buff.work = #br_seq test.buff.work
execute if score #br_win test.buff.work matches 1 run data remove storage test: buff_resource.best
execute if score #br_win test.buff.work matches 1 run data modify storage test: buff_resource.best set value {}
execute if score #br_win test.buff.work matches 1 run data modify storage test: buff_resource.best.caster set from storage test: buff_resource.kcaster
execute if score #br_win test.buff.work matches 1 if data storage test: buff_resource.ckey.uuid run data modify storage test: buff_resource.best.caster_uuid set from storage test: buff_resource.ckey.uuid
execute if score #br_win test.buff.work matches 1 store result storage test: buff_resource.best.seq int 1 run scoreboard players get #br_seq test.buff.work
scoreboard players set #br_have test.buff.work 1

execute if data storage test: buff_resource.cands[0] run function test:buff/resource/credit_cand
