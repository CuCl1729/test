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

# ターン制の戦闘中は、当たった敵(attack_hit の equip_event_target)を覚えておき、投射の魔法の狙いにする
# (test:equip/proc/cast_battle。手番の終わりの test:battle/proc_all が外す)
execute if score @s test.battle.id matches 1.. run tag @e[tag=equip_event_target] add equip_proc_target
