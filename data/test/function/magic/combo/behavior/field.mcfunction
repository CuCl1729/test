#> test:magic/combo/behavior/field
# @s = 持ち主。実行位置 = 場を出す所。有限の時間だけ残り、一定間隔で円状に効果を出す。
# 場は「出した元」について動く(直接の詠唱ならプレイヤー、設置物なら設置物、飛んでいる弾なら弾)。
# 元が消えても場は終わらず、消えた位置に残って残りの時間ぶん効き続ける(test:magic/field/detach_check)
function test:magic/field/spawn
