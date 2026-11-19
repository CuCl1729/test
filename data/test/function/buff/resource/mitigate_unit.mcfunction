#> test:buff/resource/mitigate_unit
# 内部。@s = 的。@macro type: 属性、i: 行の添字。mq の先頭の段を1件軽減して buff_event.units へ戻す。
# 与ダメージ補正(%)を掛けてから、既存のダメージ計算と同じ防御・耐性・被ダメージ増加率を掛ける
# (test:damage/def_rate・type_scale。会心と神秘は通さない)。補正の得点を控えていない者は、補正100・貫通0
data modify storage test: buff_resource.mu set from storage test: buff_resource.mq[0]
data remove storage test: buff_resource.mq[0]

scoreboard players set #bm_v test.buff.work 0
$execute store result score #bm_v test.buff.work run data get storage test: buff_resource.mu.eff.effects[$(i)].value
execute if score #bm_v test.buff.work matches ..0 run scoreboard players set #bm_v test.buff.work 0

scoreboard players set #bm_bonus test.buff.work 100
$execute if data storage test: buff_resource.mu.eff.refs.$(type)_damage_bonus store result score #bm_bonus test.buff.work run data get storage test: buff_resource.mu.eff.refs.$(type)_damage_bonus
$scoreboard players operation #victim test.$(type)_damage = #bm_v test.buff.work
$execute unless score #bm_bonus test.buff.work matches 100 run scoreboard players operation #victim test.$(type)_damage *= #bm_bonus test.buff.work
$execute unless score #bm_bonus test.buff.work matches 100 run scoreboard players operation #victim test.$(type)_damage /= #100 test.constant
$execute if score #victim test.$(type)_damage matches ..-1 run scoreboard players set #victim test.$(type)_damage 0

scoreboard players set #damage test.def.pene 0
execute if data storage test: buff_resource.mu.eff.refs.def_pene store result score #damage test.def.pene run data get storage test: buff_resource.mu.eff.refs.def_pene
$scoreboard players set #damage test.$(type)_resist.pene 0
$execute if data storage test: buff_resource.mu.eff.refs.$(type)_resist_pene store result score #damage test.$(type)_resist.pene run data get storage test: buff_resource.mu.eff.refs.$(type)_resist_pene

function test:damage/def_rate
$function test:damage/type_scale {type:"$(type)"}
$execute store result storage test: buff_resource.mu.eff.effects[$(i)].value int 1 run scoreboard players get #victim test.$(type)_damage

data modify storage test: buff_event.units append from storage test: buff_resource.mu
$execute if data storage test: buff_resource.mq[0] run function test:buff/resource/mitigate_unit {type:"$(type)",i:$(i)}
