#> test:magic/field/members
# @s = 場(at @s)。@macro radius: 半径(ほかのキーも渡ってくるが使わない)。
# **毎 tick** 走る(ダメージのパルスとは別)。出た瞬間にその場のバフを外すため、
# パルス間隔(既定20tick)を待たない
#
# 中に入った者にはこの場のバフ/デバフを「この場の名前で」掛け、出た者からは同じ名前のぶんだけを外す。
# 掛けたかどうかの記録は場の data.members = [{e, buff:[{id},…]}]。
# 実際の持ち主付けはバフ側(test:buff/apply_source / remove_source)が持つので、
# ほかの魔法や別の場が掛けた同じidの効果は、段数も残り時間もそのまま残る

# この場を指す名前(付与元のキー)。場ごとに違う通し番号を使う
execute store result storage test: field_work.fid int 1 run scoreboard players get @s test.magic.eid

# この場のぶんの継続時間は「場が残る秒数 + 余裕」。中に居るあいだ切れないようにしておき、
# 出たとき・場が終わるときに明示的に外す
execute store result score #field_secs test.temporary run scoreboard players get @s test.device.life
scoreboard players operation #field_secs test.temporary /= #20 test.constant
scoreboard players add #field_secs test.temporary 2
execute store result storage test: field_work.secs int 1 run scoreboard players get #field_secs test.temporary

# 敵向け(デバフ)と味方向け(バフ)の振り分け
data modify storage test: magic_buff.src set value []
execute if data storage test: magic.player.buff[0] run data modify storage test: magic_buff.src set from storage test: magic.player.buff
function test:magic/buff/prepare
data modify storage test: field_work.buff set from storage test: magic_buff.buff
data modify storage test: field_work.debuff set from storage test: magic_buff.debuff

data modify storage test: field_work.members set from entity @s data.members
data modify storage test: field_work.inside set value []
data modify storage test: field_work.keep set value []

# 中に居る者(HPを持つもの = 敵とプレイヤー。倒れている人はHPが0なので入らない)
$execute as @e[tag=!projectile,tag=!magic_beam,scores={test.status.hp=1..},distance=..$(radius)] run function test:magic/field/inside_one

# もう中に居ない相手から外す(残る相手は keep に移してある)
function test:magic/field/leave_loop
data modify entity @s data.members set from storage test: field_work.keep
