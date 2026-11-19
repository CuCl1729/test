#> test:magic/field/pulse_body
# @s = 場(at @s)。ダメージ・回復・蘇生・爆風の1パルスぶん。
# magic.player はこの場のぶんに差し替えてある(呼び出し元の test:magic/field/tick が読んである)
#
# バフ/デバフはこの経路に任せない: 場は「中に入ったときに掛け、出たときに外す」ので、
# 毎パルス掛け直すと段数が毎秒増えてしまう。付け外しは test:magic/field/members が毎 tick 行う
function test:magic/beam/prepare

data modify storage test: magic_buff.buff set value []
data modify storage test: magic_buff.debuff set value []

scoreboard players operation #field_owner test.temporary = @s test.owner
execute as @a if score @s OhMyDatID = #field_owner test.temporary run tag @s add damage_attacker

execute store result score #aoe_radius test.temporary run data get storage test: magic.player.aoe.radius
scoreboard players set #beam_apply test.temporary 1
function test:magic/aoe/scan
function test:magic/aoe/apply

tag @a remove damage_attacker
