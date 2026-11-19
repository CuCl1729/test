#> test:status/gear/one
# @s = プレイヤー。@macro status: ステータス名。
# 装備だけから作る取り分を test.status.gear.<名前> に入れ直す(職業・レベルのボーナスとバフは含めない。
# 合流は test:status/compose)。メインハンドは storage test: status_gear.weapon(本物の武器の custom_data。
# test:status/gear が live / saved のどちらかを入れてある)、オフハンドと防具の集計は今の値を読む。
# 範囲に収まらなかったら 0 を返し、前のキャッシュはそのまま残す(途中まで書いた値を公開しない)
#
# floor(基礎 ×(10000+乗率) /10000) + 固定値。昔はスコアで直に足し引きしていたため、小計が32bitを
# 超えると符号が化けていた(基礎 2147483600 + 100 が負になり、化けた値をキャッシュに公開していた)。
# 部品は一つずつ storage test: status_gear.p に読み(スコアで += はしない)、小計は native の
# 検査つき加算で作る。小計が収まらなかったときだけ test:status/gear/wide が部品のまま核へ渡すので、
# 小計が32bitを出ても最終値が収まる装備は通り、最終値が出るものだけが 0 を返す

function #oh_my_dat:please

# 部品を一つずつ読む。読めなかった部品は 0 のまま(前の呼び出しの値が残らない)
data modify storage test: status_gear.p set value {b:[0,0,0,0,0],m:[0,0,0,0,0,0],f:[0,0,0,0]}

# 基礎(乗率がかかる側): スコアの基礎値 + メイン/オフの base_status_add と status_bonus_add
$execute store result storage test: status_gear.p.b[0] int 1 run scoreboard players get @s test.status.base.$(status)
$execute store result storage test: status_gear.p.b[1] int 1 run data get storage test: status_gear.weapon.base_status{type:$(status)_add}.value 100
$execute store result storage test: status_gear.p.b[2] int 1 run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.base_status{type:$(status)_add}.value 100
$execute store result storage test: status_gear.p.b[3] int 1 run data get storage test: status_gear.weapon.status_bonus{type:$(status)_add}.value 100
$execute store result storage test: status_gear.p.b[4] int 1 run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.status_bonus{type:$(status)_add}.value 100

# 乗率(×100): メインハンド / オフハンド / 防具・アクセサリー・セット効果(test:equip/recalcの集計値)
$execute store result storage test: status_gear.p.m[0] int 1 run data get storage test: status_gear.weapon.status_bonus{type:$(status)_m}.value 100
$execute store result storage test: status_gear.p.m[1] int 1 run data get storage test: status_gear.weapon.base_status{type:$(status)_m}.value 100
$execute store result storage test: status_gear.p.m[2] int 1 run data get storage test: status_gear.weapon.substatus[{type:$(status)_m}].value 100
$execute store result storage test: status_gear.p.m[3] int 1 run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.status_bonus{type:$(status)_m}.value 100
$execute store result storage test: status_gear.p.m[4] int 1 run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.substatus[{type:$(status)_m}].value 100
$execute store result storage test: status_gear.p.m[5] int 1 run scoreboard players get @s test.equip.$(status)_m

# 乗率のあとに足す固定値: メインの substatus_add / オフの mainstatus_add と substatus_add / 防具の集計値
$execute store result storage test: status_gear.p.f[0] int 1 run data get storage test: status_gear.weapon.substatus[{type:$(status)_add}].value 100
$execute store result storage test: status_gear.p.f[1] int 1 run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.mainstatus{type:$(status)_add}.value 100
$execute store result storage test: status_gear.p.f[2] int 1 run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components.minecraft:custom_data.substatus[{type:$(status)_add}].value 100
$execute store result storage test: status_gear.p.f[3] int 1 run scoreboard players get @s test.equip.$(status)_add

# 小計を native の検査つき加算で作る(#gear_fit が 0 なら、どれかの小計が32bitに収まらなかった)
scoreboard players set #gear_fit test.buff.work 1
data modify storage test: buff_math.arg.values set from storage test: status_gear.p.b
function test:buff/math/addn with storage test: buff_math.arg
scoreboard players operation #gear_b test.buff.work = #math_sum test.buff.work
execute if score #math_ok test.buff.work matches 0 run scoreboard players set #gear_fit test.buff.work 0
data modify storage test: buff_math.arg.values set from storage test: status_gear.p.m
function test:buff/math/addn with storage test: buff_math.arg
scoreboard players operation #gear_m test.buff.work = #math_sum test.buff.work
execute if score #math_ok test.buff.work matches 0 run scoreboard players set #gear_fit test.buff.work 0
data modify storage test: buff_math.arg.values set from storage test: status_gear.p.f
function test:buff/math/addn with storage test: buff_math.arg
scoreboard players operation #gear_f test.buff.work = #math_sum test.buff.work
execute if score #math_ok test.buff.work matches 0 run scoreboard players set #gear_fit test.buff.work 0

# 普通の装備(小計が全部収まる): 分子を一度もスコアに作らず、2項に分けて正確な核へ渡す
execute if score #gear_fit test.buff.work matches 1 run data modify storage test: buff_eval.arg set value {terms:[{stat:"b",percent:10000},{stat:"b",percent:0}],flat:0,refs:{b:0}}
execute if score #gear_fit test.buff.work matches 1 store result storage test: buff_eval.arg.refs.b int 1 run scoreboard players get #gear_b test.buff.work
execute if score #gear_fit test.buff.work matches 1 store result storage test: buff_eval.arg.terms[1].percent int 1 run scoreboard players get #gear_m test.buff.work
execute if score #gear_fit test.buff.work matches 1 store result storage test: buff_eval.arg.flat int 1 run scoreboard players get #gear_f test.buff.work
execute if score #gear_fit test.buff.work matches 0 run function test:status/gear/wide

# 最後に一度だけfloorと範囲検査。収まらなければキャッシュは書かない
function test:buff/eval/signed
execute if data storage test: buff_eval.result{ok:0b} run return 0

$execute store result score @s test.status.gear.$(status) run data get storage test: buff_eval.result.value
return 1
