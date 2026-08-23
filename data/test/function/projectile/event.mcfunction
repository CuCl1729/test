#> test:projectile/event
# @s = イベントが起きた投射体。@macro event: hit_entity | hit_block | expire
#
# 投射体に乗っているタイプのうち、レジストリでそのイベントを宣言しているものの
# ハンドラ(test:projectile/on/<event>/<id>)を呼ぶ。
# ハンドラは #event_result test.temporary に結果を書いて、弾をどうするかを自分で決める:
#   0 = 既定動作にまかせる(何かした上で既定動作もさせたい場合もこれ)
#   1 = 処理済み。既定動作はしない。弾は残す
#   2 = 処理済み。既定動作はしない。弾を消す
# 複数のタイプが乗っている場合は大きい値が優先される(消す指示が最も強い)。
# 既定動作(未処理=0のとき何をするか)は呼び出し元のtest:projectile/moveが持つ

scoreboard players set #event_result test.temporary 0

$data modify storage test: registry_work.event set value "$(event)"

function test:magic/registry/queue_types
function test:projectile/event_loop
