data remove storage test: status

data modify storage test: status.Tags set from storage test: magic.player.projectile.behavior
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

function test:projectile/shot
