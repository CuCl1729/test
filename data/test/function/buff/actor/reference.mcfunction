#> test:buff/actor/reference
# @s = 効果を出す側(caster)。式が見る参照値を一度だけ書く。失敗時に部分書き込みは残らない
#   storage test: buff_actor.result = {ok:1b,refs:{<asset.buff.stats の全ステータス>:<P+R>,hp:<今のHP>,mp:<今のMP>},
#     caster_uuid:<@s の本物の UUID / IntArray>}
#   範囲に収まらなければ {ok:0b,error:"out_of_range"}、本物の武器の控えが無くて装備ぶんを作れなければ
#   {ok:0b,error:"gear_unavailable"}。どちらも refs は書かない
# 最大HP/MP(hp_max・mp_max)は受け身の取り分＋純粋な固定値で、バフの乗率を掛けた実効値ではない。
# 今のHP/MPは実際の資源をそのまま読む。敵は召喚時の基礎値＋固定値。参照値は負にもなり得る

scoreboard players set #ba_mode test.buff.work 1
data modify storage test: buff_actor.refs set value {}
function test:buff/actor/stat_loop

execute store result storage test: buff_actor.refs.hp int 1 run scoreboard players get @s test.status.hp
execute store result storage test: buff_actor.refs.mp int 1 run scoreboard players get @s test.status.mp
# 属性付きダメージの攻撃側の補正(付与した時点で固定する)。得点が無い者は書かない(与ダメ補正は100、貫通は0として扱う)
function test:buff/actor/combat {type:"fire"}
function test:buff/actor/combat {type:"water"}
function test:buff/actor/combat {type:"wood"}
function test:buff/actor/combat {type:"metal"}
function test:buff/actor/combat {type:"earth"}
function test:buff/actor/combat {type:"physics"}
execute if score @s test.def.pene = @s test.def.pene store result storage test: buff_actor.refs.def_pene int 1 run scoreboard players get @s test.def.pene

data modify storage test: buff_actor.result set value {ok:0b,error:"out_of_range"}
execute if score #ba_err test.buff.work matches 2 run data modify storage test: buff_actor.result.error set value "gear_unavailable"
execute if score #ba_err test.buff.work matches 0 run data modify storage test: buff_actor.result set value {ok:1b,refs:{}}
execute if score #ba_err test.buff.work matches 0 run data modify storage test: buff_actor.result.refs set from storage test: buff_actor.refs
# 身元も一緒に控える(OhMyDatID は使い回されるので、あとで誰の仕業かを言えるのは UUID だけ)
execute if score #ba_err test.buff.work matches 0 run data modify storage test: buff_actor.result.caster_uuid set from entity @s UUID
data remove storage test: buff_actor.refs
