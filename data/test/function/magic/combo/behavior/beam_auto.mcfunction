#> test:magic/combo/behavior/beam_auto
# @s = 持ち主。実行位置 = ビームの根元。@macro endpoint_aoe: 1 なら行き止まりで範囲の効果も出す。
# 設置物・弾・自分から自動で出るビーム。向きは持ち主のカメラによらず、発生源の位置だけで決まる
$data modify storage test: magic.player.endpoint_aoe set value $(endpoint_aoe)

execute store result score #beam_count test.temporary run function test:magic/root/burst_count
execute if score #beam_count test.temporary matches ..0 run return 0

# 追尾が入っていれば、発生源から一番近い狙える敵へ全部向ける(その後は各ビームが自分で追う。
# 同じ敵を狙っていてもよい)。狙える敵が1つも無ければ、下の放射に落として飛びながら探させる
scoreboard players set #beam_aim test.temporary 0
execute if data storage test: magic.player.homing store result score #beam_aim test.temporary run function test:magic/homing/aim with storage test: magic.player.homing
execute if score #beam_aim test.temporary matches 1 run return run function test:magic/beam/aim_burst

# 水平の基準角を抽選し、360/本数 度ずつに振り分ける
execute store result score #beam_base test.temporary run function test:rng/roll {key:"device_direction",min:0,max:359999}
scoreboard players set #beam_index test.temporary 0
function test:magic/beam/radial_loop
