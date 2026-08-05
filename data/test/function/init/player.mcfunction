#> test:init/player
# @s = 初期化対象のプレイヤー。基礎ステータスを設定し、実効値(status/update)とHP/MPの初期値を反映する

function test:init/asset/status/vanilla

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

scoreboard players operation @s test.status.hp = @s test.status.hp_max
scoreboard players operation @s test.status.mp = @s test.status.mp_max
