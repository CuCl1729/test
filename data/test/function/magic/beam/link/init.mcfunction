#> test:magic/beam/link/init
# @s = 持ち主のプレイヤー。magic.player はまだ発動したばかりの持続ビーム。古い beam_link は捨てる。
# 最初のつなぎ(magic.player.chain[0])が「着弾で」か「一定間隔で」なら、ここでだけ beam_link を作る。
# beam_events/link_work(待ち行列・作業場)はここでは触らない(子の構築中に親の待ち行列が別に進んでいることがあるため)
data remove storage test: magic.player.beam_link

# magic.player.chain[0] に直接 {link:"..."} を付けて比べることはできない(添字の後の複合一致は無効)ので、
# 一旦だけの殻 beam_link_init へ写してから、名前の無い複合一致で見る
data remove storage test: beam_link_init
data modify storage test: beam_link_init set value {}
execute if data storage test: magic.player.chain[0] run data modify storage test: beam_link_init set from storage test: magic.player.chain[0]

scoreboard players set #beam_link_kind test.temporary 0
execute if data storage test: beam_link_init{link:"on_land"} run scoreboard players set #beam_link_kind test.temporary 1
execute if data storage test: beam_link_init{link:"periodic"} run scoreboard players set #beam_link_kind test.temporary 2

execute unless score #beam_link_kind test.temporary matches 1.. run return 0

data modify storage test: magic.player.beam_link set value {states:[]}

# 「一定間隔で」は、持ち主の今の短縮率を今だけ読んで間隔(tick)を確定させる(以後ここを呼び直さない)
execute if score #beam_link_kind test.temporary matches 2 run function test:magic/periodic/interval with storage test: beam_link_init.link_params
execute if score #beam_link_kind test.temporary matches 2 store result storage test: magic.player.beam_link.interval_ticks int 1 run scoreboard players get #periodic_result test.temporary
execute if score #beam_link_kind test.temporary matches 2 run data modify storage test: magic.player.beam_link.count set from storage test: beam_link_init.link_params.count
