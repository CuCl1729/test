#> test:equip/proc/queue
# @s = 自動発動の魔法を持つプレイヤー。@macro event: 起きたこと。test:equip/eventが呼ぶ。
#
# ここでは唱えず、タグで予約するだけにする(唱えるのはtickの test:equip/proc/run)。
# - イベントはダメージ計算や範囲攻撃の途中で起きるので、その場で唱えると外側の作業用データ
#   (magic.player・#damage・hitタグ・damage_attackerタグなど)を壊す
# - タグなので、範囲攻撃で何体にも当たっても1tickに1回にまとまる
# - #oh_my_dat:please を呼ばずに済む(ダメージ処理の途中で個別ストレージの参照先を切り替えない)

$tag @s add equip_proc.$(event)
tag @s add equip_proc_queued
