# 旧版は詠唱時に全属性の通常攻撃補正を同じ値で上書きしていた。個別に設定された補正は維持する。
tag @s add attack_bonus_split
execute if score @s test.physics_damage.bonus matches 100 run return 0
execute unless score @s test.fire_damage.bonus = @s test.physics_damage.bonus run return 0
execute unless score @s test.water_damage.bonus = @s test.physics_damage.bonus run return 0
execute unless score @s test.wood_damage.bonus = @s test.physics_damage.bonus run return 0
execute unless score @s test.metal_damage.bonus = @s test.physics_damage.bonus run return 0
execute unless score @s test.earth_damage.bonus = @s test.physics_damage.bonus run return 0
function test:init/asset/status/attack_bonus
