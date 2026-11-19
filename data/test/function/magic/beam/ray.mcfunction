#> test:magic/beam/ray
# 実行位置 = ビームの根元、向き = ビームの方向。1本ぶんの線を引く。
#   ・触れた敵は貫通して進む(同じ敵には同じ線の同じパルスで1回だけ当てる)
#   ・壁に入ったら、その一歩手前で止まる
#   ・何にも阻まれなければ射程の終わりで止まる
# 止まった所(行き止まり / 射程の終わり)でだけ、範囲と組んでいれば円状の効果も出す。
# 貫いた敵それぞれでは出さないので、同じ相手に直撃と範囲の二重当たりは起きない
#
# #beam_apply test.temporary が 0 の tick は、見た目と壁の判定だけを行って誰にも当てない
# (ダメージはパルスの間隔ごと、線は毎 tick という作りのため)
data remove storage test: link_work.wall
scoreboard players set #beam_step test.temporary 0
# 射程は投射と同じ値(ブロック)。0.5 ブロックずつ進むので歩数は2倍
execute store result score #beam_len test.temporary run data get storage test: magic.player.projectile.range 2

execute if score #beam_apply test.temporary matches 1 run tag @e remove beam_hit
function test:magic/beam/ray_step
