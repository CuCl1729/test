function #oh_my_dat:please

# ダウン中は唱えられない(自分を回復して起き上がれないように)
execute if entity @s[tag=downed] run return fail
# ターン制の戦闘中は唱えられない(戦闘の魔法は手番の「スキル」から。手番の外の攻撃と、報酬の無い撃破を防ぐ)
execute if score @s test.battle.id matches 1.. run execute store success score @s test.ui.bar_shown run title @s actionbar {text:"戦闘中は使えない",color:"gray"}
execute if score @s test.battle.id matches 1.. run return fail
function test:action/cast
