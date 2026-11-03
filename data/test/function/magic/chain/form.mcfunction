#> test:magic/chain/form
# @s = 持ち主のプレイヤー。実行位置 = この段を始める所。@macro magic_type: この段の形態(ほかのキーも渡ってくるが使わない)
#   範囲: この位置を中心に爆発 / 設置: この位置に置く / 投射: この位置から撃つ(弾の向きは今までどおり、
#   いちばん近いプレイヤーと反対向き) / 自己: 持ち主に掛かる
$function test:magic/chain/form_$(magic_type)
