#> test:equip/rebuild_status
# @s = プレイヤー。装備が変わったので主要ステータスを組み直し、最大値を超えたHP/MPを切り詰める

function test:status/update {status:"atk"}
function test:status/update {status:"def"}
function test:status/update {status:"hp_max"}
function test:status/update {status:"mp_max"}
function test:status/update {status:"crit_rate"}
function test:status/update {status:"crit_damage"}
function test:status/update {status:"effect_damage"}
function test:status/update {status:"magic_efficiency"}
function test:status/update {status:"divergence"}
function test:status/update {status:"mp_regene"}
function test:status/update {status:"hp_regene"}

execute if score @s test.status.hp > @s test.status.hp_max run scoreboard players operation @s test.status.hp = @s test.status.hp_max
execute if score @s test.status.mp > @s test.status.mp_max run scoreboard players operation @s test.status.mp = @s test.status.mp_max
