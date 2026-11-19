#> test:buff/resource/credit_sum
# 内部。マクロ {i:<宣言された行の添字>}。sum を削りながら、候補と身元の鍵が同じ単位の
# 「生の」値を 10億を底にした3桁(hi,mid,lo)へ繰り上がり付きで足す。
# 容量で切った値ではなく生の値で足す(切ると別人どうしが偽の同点になる)

data modify storage test: buff_resource.su set from storage test: buff_resource.sum[0]
data remove storage test: buff_resource.sum[0]

# 「何も変わらなかった」判定で鍵の等しさを見る(#br_ne=0 なら同じ術者)。
# 鍵の作り方は credit_cand と同じでなければならない(UUIDがあればUUIDだけ)
data modify storage test: buff_resource.cmp set value {kind:"id"}
data modify storage test: buff_resource.cmp.caster set from storage test: buff_resource.su.caster
execute if data storage test: buff_resource.su.eff.caster_uuid run data modify storage test: buff_resource.cmp set value {kind:"uuid"}
execute if data storage test: buff_resource.su.eff.caster_uuid run data modify storage test: buff_resource.cmp.uuid set from storage test: buff_resource.su.eff.caster_uuid
execute store success score #br_ne test.buff.work run data modify storage test: buff_resource.cmp set from storage test: buff_resource.ckey

scoreboard players set #br_v test.buff.work 0
$execute if score #br_ne test.buff.work matches 0 store result score #br_v test.buff.work run data get storage test: buff_resource.su.eff.effects[$(i)].value
execute if score #br_v test.buff.work matches ..-1 run scoreboard players set #br_v test.buff.work 0

scoreboard players operation #br_vl test.buff.work = #br_v test.buff.work
scoreboard players operation #br_vl test.buff.work %= #br_e9 test.buff.work
scoreboard players operation #br_vh test.buff.work = #br_v test.buff.work
scoreboard players operation #br_vh test.buff.work /= #br_e9 test.buff.work

# 下の桁は足しても最大 1,999,999,998 なので、繰り上げる前でも int32 に収まる
scoreboard players operation #br_lo test.buff.work += #br_vl test.buff.work
scoreboard players operation #br_mid test.buff.work += #br_vh test.buff.work
execute if score #br_lo test.buff.work >= #br_e9 test.buff.work run scoreboard players add #br_mid test.buff.work 1
execute if score #br_lo test.buff.work >= #br_e9 test.buff.work run scoreboard players operation #br_lo test.buff.work -= #br_e9 test.buff.work
execute if score #br_mid test.buff.work >= #br_e9 test.buff.work run scoreboard players add #br_hi test.buff.work 1
execute if score #br_mid test.buff.work >= #br_e9 test.buff.work run scoreboard players operation #br_mid test.buff.work -= #br_e9 test.buff.work

# 同点のときの決め手。この術者の受け入れられた単位のうち一番大きい seq
scoreboard players set #br_s test.buff.work -1
execute if score #br_ne test.buff.work matches 0 store result score #br_s test.buff.work run data get storage test: buff_resource.su.seq
execute if score #br_s test.buff.work > #br_seq test.buff.work run data modify storage test: buff_resource.kcaster set from storage test: buff_resource.su.caster
execute if score #br_s test.buff.work > #br_seq test.buff.work run scoreboard players operation #br_seq test.buff.work = #br_s test.buff.work

execute if data storage test: buff_resource.sum[0] run function test:buff/resource/credit_sum with storage test: buff_resource.arg
