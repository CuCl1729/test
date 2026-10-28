#> test:battle/action/skill_cast/projectile_resolve
# @s = 詠唱者(手番)。@e[tag=battle_target] = 決定済みの対象(1体)。選んだタイプ・効果で魔法を組み立てて唱え
# (test:battle/action/skill_cast/apply_projectile)、手番を終える

function #oh_my_dat:please
function test:battle/action/skill_cast/build
function test:battle/action/skill_cast/apply_projectile

function test:battle/target/clear

function test:battle/turn_end
