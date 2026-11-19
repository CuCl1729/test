#> test:magic/beam/root/watch
# tick から毎tick、持続中のビームのループの直前に呼ぶ。magic_beam_roots を1件ずつ確かめ、
# ルートが失効した・持ち主がログアウトした・状態が変わった古いビームを片付ける。
# 記録が無ければ何もしない(毎tickの空振りを避ける)
execute unless data storage test: magic_beam_roots[0] run return 0

data modify storage test: beam_root_work.watch_in set from storage test: magic_beam_roots
data modify storage test: beam_root_work.keep set value []
function test:magic/beam/root/watch_loop

data modify storage test: magic_beam_roots set from storage test: beam_root_work.keep
