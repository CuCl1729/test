#> test:equip/event
# @s = 装備している人(プレイヤー)。@macro event: 起きたこと(magic_cast / attack_hit / damaged)。
# 4部位のセット効果(oh_my_dat の test.equip.effects、test:equip/recalcが集計)のうち、eventが一致するものを
# test:equip/effect/<kind> へ振り分ける。各効果は {event, kind, params, desc} の形で、paramsがマクロ引数になる
#
# イベントごとの文脈(呼び出し側が用意する):
#   magic_cast: storage test: magic.player(詠唱する魔法)。詠唱者の test.<属性>_damage を書き換えてよい
#   attack_hit: 当たった相手に一時タグ equip_event_target が付いている
#   damaged:    @s 自身がダメージを受けた直後

# 防具の自動発動の魔法は、ここでは予約(タグ)だけしてtickで唱える(test:equip/proc/queue)。
# 自動発動した魔法自身の magic_cast では予約しない(連鎖を防ぐ)。ターン制の戦闘中は、予約を手番の終わり
# (test:battle/proc_all)に実行する
$execute if score @s test.equip.has_procs matches 1 unless entity @s[tag=equip_proc_casting] run function test:equip/proc/queue {event:"$(event)"}

# セット効果を持っていない人では何もしない(ダメージ処理などの途中で個別ストレージの参照先を切り替えないため)
execute unless score @s test.equip.has_effects matches 1 run return 0

function #oh_my_dat:please
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.effects[0] run return 0

# 効果の中でさらにイベントが起きても混ざらないよう、作業用の一覧はイベントごとに分ける
$data modify storage test: equip_work.event_queue.$(event) set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.effects
$function test:equip/event_loop {event:"$(event)"}
