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

# ターン制用
 scoreboard objectives add test.battle.id dummy
 scoreboard objectives add test.battle.turn_order dummy
 scoreboard objectives add test.battle.current_turn dummy
 scoreboard objectives add test.battle.member_count dummy
 scoreboard objectives add test.battle.next_id dummy

 scoreboard objectives add test.battle.acting dummy
 scoreboard objectives add test.battle.enemy_delay dummy
 scoreboard objectives add test.settings.battle_ui dummy
 scoreboard objectives add test.battle.chat_select trigger
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
# 魔法要素の習得状況(研究ステーションで解放)
 scoreboard objectives add test.magic.known.projectile dummy
 scoreboard objectives add test.magic.known.self dummy
 scoreboard objectives add test.magic.known.fire dummy
 scoreboard objectives add test.magic.known.gravity dummy
 scoreboard objectives add test.magic.known.heal dummy
 scoreboard objectives add test.magic.known.atk dummy
# デバッグ用
 scoreboard objectives add test.debug.enabled dummy
 scoreboard objectives add test.debug.display dummy