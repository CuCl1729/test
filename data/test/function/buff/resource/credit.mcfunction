#> test:buff/resource/credit
# 内部。的(@s)の上で動く。この仕事の中で生の合計が一番大きい術者を選び、
# 的の OhMyDat へ功績を残す(術者の側の状態は何も触らない)。
# 合計は int32 を超えうるので 10億を底にした3桁で持ち、上の桁から比べる

scoreboard players set #br_e9 test.buff.work 1000000000
scoreboard players set #br_have test.buff.work 0
data modify storage test: buff_resource.cands set from storage test: buff_event.units
# 同じ術者が何度候補に出ても足し合わせは一度だけ(96段でも命令数が二乗に増えない)
data modify storage test: buff_resource.seen set value []
execute if data storage test: buff_resource.cands[0] run function test:buff/resource/credit_cand
execute if score #br_have test.buff.work matches 0 run return 0

data modify storage test: buff_resource.killer set value {}
data modify storage test: buff_resource.killer.caster set from storage test: buff_resource.best.caster
data modify storage test: buff_resource.killer.seq set from storage test: buff_resource.best.seq
execute if data storage test: buff_resource.best.caster_uuid run data modify storage test: buff_resource.killer.caster_uuid set from storage test: buff_resource.best.caster_uuid
data modify storage test: buff_resource.killer.id set from storage test: buff_event.id
data modify storage test: buff_resource.killer.row set from storage test: buff_event.row.row
execute store result storage test: buff_resource.killer.damage_parts.hi int 1 run scoreboard players get #br_bhi test.buff.work
execute store result storage test: buff_resource.killer.damage_parts.mid int 1 run scoreboard players get #br_bmid test.buff.work
execute store result storage test: buff_resource.killer.damage_parts.lo int 1 run scoreboard players get #br_blo test.buff.work

# damage は符号つき32bitに収まるときだけ足す(けっして回り込ませない)。
# mid=2 の分かれ道は、2,000,000,000 + lo が収まる lo だけを通す
scoreboard players set #br_fits test.buff.work 0
execute if score #br_bhi test.buff.work matches 0 if score #br_bmid test.buff.work matches 0..1 run scoreboard players set #br_fits test.buff.work 1
execute if score #br_bhi test.buff.work matches 0 if score #br_bmid test.buff.work matches 2 if score #br_blo test.buff.work matches ..147483647 run scoreboard players set #br_fits test.buff.work 1
execute if score #br_fits test.buff.work matches 1 run scoreboard players operation #br_t test.buff.work = #br_bmid test.buff.work
execute if score #br_fits test.buff.work matches 1 run scoreboard players operation #br_t test.buff.work *= #br_e9 test.buff.work
execute if score #br_fits test.buff.work matches 1 run scoreboard players operation #br_t test.buff.work += #br_blo test.buff.work
execute if score #br_fits test.buff.work matches 1 store result storage test: buff_resource.killer.damage int 1 run scoreboard players get #br_t test.buff.work

data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_killer set from storage test: buff_resource.killer
