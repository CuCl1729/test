#> test:equip/effect/apply_buff
# event: attack_hit。@s = 攻撃したプレイヤー。@macro id/stacks/chance: 当たった相手(equip_event_target)に付与するバフ/デバフ。
# 確率判定と付与は武器・敵の「命中時に付与するバフ」と同じ test:buff/apply_list が行う

$data modify storage test: buff_work.pending set value [{id:"$(id)",stacks:$(stacks),chance:$(chance)}]
execute as @e[tag=equip_event_target,limit=1] run function test:buff/apply_list
