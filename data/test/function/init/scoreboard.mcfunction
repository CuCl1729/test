#> test:init/scoreboard
#
# @Within function test:init/

scoreboard objectives add test.X0 dummy
scoreboard objectives add test.Y0 dummy
scoreboard objectives add test.Z0 dummy

scoreboard objectives add test.X1 dummy
scoreboard objectives add test.Y1 dummy
scoreboard objectives add test.Z1 dummy

scoreboard objectives add test.speed dummy
scoreboard objectives add test.constant dummy

function test:init/set_constant

scoreboard objectives add test.temporary dummy

scoreboard objectives add test.multi_shot dummy

scoreboard objectives add test.repeat dummy

scoreboard objectives add test.time dummy

scoreboard objectives add test.gravity dummy
scoreboard objectives add test.gravity_time dummy

scoreboard objectives add test.boolean dummy

scoreboard objectives add test.range dummy

scoreboard objectives add test.substatus dummy

scoreboard objectives add test.multiplier dummy
scoreboard objectives add test.calc.base dummy
scoreboard objectives add test.calc.add dummy

scoreboard objectives add test.scale dummy

scoreboard objectives add test.fire_damage dummy
scoreboard objectives add test.water_damage dummy
scoreboard objectives add test.wood_damage dummy
scoreboard objectives add test.metal_damage dummy
scoreboard objectives add test.earth_damage dummy
scoreboard objectives add test.physics_damage dummy

scoreboard objectives add test.fire_damage.bonus dummy
scoreboard objectives add test.water_damage.bonus dummy
scoreboard objectives add test.wood_damage.bonus dummy
scoreboard objectives add test.metal_damage.bonus dummy
scoreboard objectives add test.earth_damage.bonus dummy
scoreboard objectives add test.physics_damage.bonus dummy

scoreboard objectives add test.fire_resist dummy
scoreboard objectives add test.water_resist dummy
scoreboard objectives add test.wood_resist dummy
scoreboard objectives add test.metal_resist dummy
scoreboard objectives add test.earth_resist dummy
scoreboard objectives add test.physics_resist dummy

scoreboard objectives add test.fire_resist.pene dummy
scoreboard objectives add test.water_resist.pene dummy
scoreboard objectives add test.wood_resist.pene dummy
scoreboard objectives add test.metal_resist.pene dummy
scoreboard objectives add test.earth_resist.pene dummy
scoreboard objectives add test.physics_resist.pene dummy

scoreboard objectives add test.fire_resist.debuff dummy
scoreboard objectives add test.water_resist.debuff dummy
scoreboard objectives add test.wood_resist.debuff dummy
scoreboard objectives add test.metal_resist.debuff dummy
scoreboard objectives add test.earth_resist.debuff dummy
scoreboard objectives add test.physics_resist.debuff dummy

scoreboard objectives add test.fire_damage_inc.bonus dummy
scoreboard objectives add test.water_damage_inc.bonus dummy
scoreboard objectives add test.wood_damage_inc.bonus dummy
scoreboard objectives add test.metal_damage_inc.bonus dummy
scoreboard objectives add test.earth_damage_inc.bonus dummy
scoreboard objectives add test.physics_damage_inc.bonus dummy

scoreboard objectives add test.def.pene dummy
scoreboard objectives add test.def.debuff dummy
scoreboard objectives add test.def.coefficient dummy

scoreboard objectives add test.slotnumber dummy

# 範囲タイプと組み合わせた投射体が着弾時に円状へ効果を出すための半径
scoreboard objectives add test.aoe_radius dummy

# 投射体を撃った詠唱者のOhMyDatID。着弾は詠唱の数tick後になるため、
# ダメージ表示で詠唱者を引けるようにここへ控えておく
scoreboard objectives add test.owner dummy

# ターン制用
 scoreboard objectives add test.battle.id dummy
 scoreboard objectives add test.battle.turn_order dummy
 scoreboard objectives add test.battle.current_turn dummy
 scoreboard objectives add test.battle.member_count dummy
 scoreboard objectives add test.battle.next_id dummy

 scoreboard objectives add test.battle.acting dummy
 scoreboard objectives add test.battle.enemy_delay dummy
 scoreboard objectives add test.battle.awaiting_skill dummy
 scoreboard objectives add test.settings.battle_ui dummy
 scoreboard objectives add test.battle.chat_select trigger
 scoreboard objectives add test.battle.skill_select trigger
 scoreboard objectives add test.battle.skill_effect trigger
 scoreboard objectives add test.battle.skill_category trigger
 scoreboard objectives add test.battle.active_skill_select trigger
 scoreboard objectives add test.battle.awaiting_target dummy
 scoreboard objectives add test.battle.target_select trigger
 scoreboard objectives add test.battle.pending_target_action dummy
 scoreboard objectives add test.battle.target_max dummy
 scoreboard objectives add test.battle.turn_start_retry dummy
 scoreboard objectives add test.battle.weapon_aoe dummy
 scoreboard objectives add test.battle.weapon_aoe_multiplier dummy
 scoreboard objectives add test.arena.occupied dummy
 scoreboard objectives add test.battle.arena dummy

 scoreboard objectives add test.battle.return_x dummy
 scoreboard objectives add test.battle.return_y dummy
 scoreboard objectives add test.battle.return_z dummy
# ステータス用
 scoreboard objectives add test.status.level dummy
 scoreboard objectives add test.status.exp dummy
 scoreboard objectives add test.status.skill_point dummy

 scoreboard objectives add test.status.atk dummy
 
 scoreboard objectives add test.status.def dummy
 
 scoreboard objectives add test.status.hp_max dummy
 scoreboard objectives add test.status.hp dummy
 
 scoreboard objectives add test.status.crit_rate dummy
 scoreboard objectives add test.status.crit_damage dummy
 
 scoreboard objectives add test.status.effect_damage dummy
 scoreboard objectives add test.status.magic_efficiency dummy
 
 scoreboard objectives add test.status.mp_max dummy
 scoreboard objectives add test.status.mp dummy
 
 scoreboard objectives add test.status.burnout dummy
 scoreboard objectives add test.status.divergence dummy
 
 scoreboard objectives add test.status.mp_regene dummy
 scoreboard objectives add test.status.hp_regene dummy
 
 scoreboard objectives add test.status.downed_timer dummy

 scoreboard objectives add test.hp_display.cur dummy
 scoreboard objectives add test.hp_display.max dummy

 scoreboard objectives add test.settings.damage_display dummy
 scoreboard objectives add test.damage_pop.value dummy
 scoreboard objectives add test.damage_pop.life dummy
 
# 基礎ステータス用
 scoreboard objectives add test.status.base.atk dummy
 
 scoreboard objectives add test.status.base.def dummy
 
 scoreboard objectives add test.status.base.hp_max dummy
 
 scoreboard objectives add test.status.base.crit_rate dummy
 scoreboard objectives add test.status.base.crit_damage dummy
 
 scoreboard objectives add test.status.base.effect_damage dummy
 scoreboard objectives add test.status.base.magic_efficiency dummy
 
 scoreboard objectives add test.status.base.mp_max dummy
 
 scoreboard objectives add test.status.base.divergence dummy
 
 scoreboard objectives add test.status.base.mp_regene dummy
 scoreboard objectives add test.status.base.hp_regene dummy
# バフ/デバフ用
# test.buff.<ステータス名> は「バフ由来の増減の蓄積値」。test.status.<名前>を直接書くと
# status/updateが装備から組み立て直すときに消えてしまうため、必ずこちらを経由する
# (実効値への反映は test:status/recalc)。レジストリは test:init/asset/buff/buffs
 scoreboard objectives add test.buff.atk dummy
 scoreboard objectives add test.buff.def dummy
 scoreboard objectives add test.buff.hp_max dummy
 scoreboard objectives add test.buff.mp_max dummy
 scoreboard objectives add test.buff.crit_rate dummy
 scoreboard objectives add test.buff.crit_damage dummy
 scoreboard objectives add test.buff.effect_damage dummy
 scoreboard objectives add test.buff.magic_efficiency dummy
 scoreboard objectives add test.buff.divergence dummy
 scoreboard objectives add test.buff.hp_regene dummy
 scoreboard objectives add test.buff.mp_regene dummy

# バフ処理のループ用。イベント関数が test.temporary を自由に使えるよう、
# 進行状態は専用のobjectiveに持つ(共有スコアが入れ子呼び出しで壊れるのを避けるため)
 scoreboard objectives add test.buff.work dummy

# 魔法要素の習得状況と、戦闘中の詠唱で使うと選んだタイプ/効果は
# oh_my_datの個別ストレージ(_[-4]×8.test.magic.known / .test.magic.select)に保持する。
# タイプ・効果を増やすたびにobjectiveを足さずに済むようにするため(レジストリはtest:init/asset/magic/)

# 職業(job)用。職業ごとのレベル/EXP/スキルポイント/解放済みスキルはoh_my_datの個別ストレージ
# (_[-4]×8.test.job.unlocked.<job_id> / .test.job.data.<job_id> / .test.job.skill_order)に保持する
# (「習得済み魔法」と同じ理由。職業を増やしてもobjectiveを足さずに済む。レジストリはtest:init/asset/job/)
 scoreboard objectives add test.job_bonus.atk dummy
 scoreboard objectives add test.job_bonus.def dummy
 scoreboard objectives add test.job_bonus.hp_max dummy
 scoreboard objectives add test.job_bonus.mp_max dummy
 scoreboard objectives add test.job_bonus.crit_rate dummy
 scoreboard objectives add test.job_bonus.crit_damage dummy
 scoreboard objectives add test.job_bonus.effect_damage dummy
 scoreboard objectives add test.job_bonus.magic_efficiency dummy
 scoreboard objectives add test.job_bonus.divergence dummy
 scoreboard objectives add test.job_bonus.hp_regene dummy
 scoreboard objectives add test.job_bonus.mp_regene dummy

# 職業関連のループ処理・一時判定用(test.buff.workと同じ理由で専用のobjectiveに分ける。
# 職業の判定処理からbuff/apply_list等の別系統の関数を呼ぶことがあるため、共有スコアの衝突を避ける)
 scoreboard objectives add test.job.work dummy

# デバッグ用
 scoreboard objectives add test.debug.enabled dummy
 scoreboard objectives add test.debug.display dummy