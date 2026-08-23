data remove storage test: status

data modify storage test: status.Tags set from storage test: magic.player.projectile.behavior
data modify storage test: status.speed set from storage test: magic.player.projectile.speed
data modify storage test: status.range set from storage test: magic.player.projectile.range
data modify storage test: status.gravity set from storage test: magic.player.projectile.gravity
data modify storage test: status.data set from storage test: magic.player.data

# 範囲タイプと組み合わせた場合、着弾地点で円状に効果を出すため半径を投射体へ持たせる
data modify storage test: status.aoe_radius set from storage test: magic.player.aoe.radius

# 組み合わせたタイプのidを投射体のタグとして持たせる(着弾時のイベント振り分けに使う)。
# リストなので[]付きで全要素をまとめてコピーできる
data modify storage test: status.Tags append from storage test: magic.player.types[]

function test:projectile/shot
