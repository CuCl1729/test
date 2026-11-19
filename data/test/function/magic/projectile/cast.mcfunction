data remove storage test: status

# 確定ビームの待ち行列から起きた弾は、乗せ替え+1.75ではなく実行位置にそのまま出す
execute if data storage test: magic.player.fixed_origin run data modify storage test: status.exact_origin set from storage test: magic.player.fixed_origin

data modify storage test: status.Tags set value []
data modify storage test: status.Tags set from storage test: magic.player.projectile.behavior
execute if data storage test: magic.player.projectile.gravity unless data storage test: status{Tags:["gravity"]} run data modify storage test: status.Tags append value "gravity"
data modify storage test: status.speed set from storage test: magic.player.projectile.speed
data modify storage test: status.range set from storage test: magic.player.projectile.range
data modify storage test: status.gravity set from storage test: magic.player.projectile.gravity
data modify storage test: status.data set from storage test: magic.player.data

# 付与するバフの一覧も投射体に運ばせる(着弾時にmagic.playerが別の魔法で上書きされている可能性があるため)
execute if data storage test: magic.player.buff[0] run data modify storage test: status.data.buff set from storage test: magic.player.buff

# 範囲タイプと組み合わせた場合、着弾地点で円状に効果を出すため半径を投射体へ持たせる
data modify storage test: status.aoe_radius set from storage test: magic.player.aoe.radius

# 組み合わせたタイプのidを投射体のタグとして持たせる(着弾時のイベント振り分けに使う)。
# リストなので[]付きで全要素をまとめてコピーできる
data modify storage test: status.Tags append from storage test: magic.player.types[]

# 爆風(範囲と組んだときに着弾で破裂させる数)と、つないだ魔法の残りの段・通し番号も弾に運ばせる。
# 次の段が「着弾で」なら、弾にそのタグを付けて着弾の出来事(test:projectile/on/<出来事>/on_land)を受け取る
execute if data storage test: magic.player.blast run data modify storage test: status.data.blast set from storage test: magic.player.blast
execute if data storage test: magic.player.chain[0] run data modify storage test: status.data.chain set from storage test: magic.player.chain
execute if data storage test: magic.player.uid run data modify storage test: status.data.uid set from storage test: magic.player.uid
execute if data storage test: magic.player.cast run data modify storage test: status.data.cast set from storage test: magic.player.cast
data remove storage test: chain_work.peek
data modify storage test: chain_work.peek set from storage test: magic.player.chain[0]
execute if data storage test: chain_work{peek:{link:"on_land"}} run data modify storage test: status.Tags append value "on_land"

# 一定間隔: 飛びながら、間隔ごとに今の位置で次の段を繰り返し始める
execute if data storage test: chain_work{peek:{link:"periodic"}} run data modify storage test: status.Tags append value "periodic"
execute if data storage test: chain_work{peek:{link:"periodic"}} run data modify storage test: status.data.periodic.behavior set from storage test: chain_work.peek.link_behavior
execute if data storage test: chain_work{peek:{link:"periodic"}} run function test:magic/periodic/interval with storage test: chain_work.peek.link_params
execute if data storage test: chain_work{peek:{link:"periodic"}} store result storage test: status.data.periodic.interval_ticks int 1 run scoreboard players get #periodic_result test.temporary
execute if data storage test: chain_work{peek:{link:"periodic"}} run data modify storage test: status.data.periodic.count set from storage test: chain_work.peek.link_params.count

# 追尾: 相手を探す距離と回る速さを弾に運ばせる(test:projectile/move が毎 tick 少しずつ向きを回す)。
# 発射直後に向きを変えないdelay_ticksは、プレイヤーが直接撃った弾(magic/combo/behavior/shotが立てるtest.magic.manual_launch)だけに効く。
# 設置物・弾が起こした段(aimed・radial・periodicの子)は、乗せ替えのとき0に直す
execute if data storage test: magic.player.homing run data modify storage test: status.data.homing set from storage test: magic.player.homing
execute if data storage test: magic.player.homing unless score @s test.magic.manual_launch matches 1 run data modify storage test: status.data.homing.delay_ticks set value 0

execute if data storage test: magic.player{device_radial:1b} run data modify storage test: status.radial set value 1b
# 狙いを付けて撃つ(設置物の追尾)。向きは呼び出し元が execute facing で決めている
execute if data storage test: magic.player{aimed:1b} run data modify storage test: status.aimed set value 1b
function test:projectile/shot

