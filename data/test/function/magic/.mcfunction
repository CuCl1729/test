function #oh_my_dat:please

# ダウン中は唱えられない(自分を回復して起き上がれないように)
execute if entity @s[tag=downed] run return fail
# ターン制の戦闘中は唱えられない(戦闘の魔法は手番の「スキル」から。手番の外の攻撃と、報酬の無い撃破を防ぐ)
execute if score @s test.battle.id matches 1.. run execute store success score @s test.ui.bar_shown run title @s actionbar {text:"戦闘中は使えない",color:"gray"}
execute if score @s test.battle.id matches 1.. run return fail

# 消費MPを払う(足りなければ唱えない)。ターン制でも同じ処理を使う
execute unless function test:magic/pay run return fail

function test:magic/prepare_damage

# 防具のセット効果(magic_cast)。ダメージが決まった後、届け方へ渡す前に詠唱者の属性ダメージをいじれる
function test:equip/event {event:"magic_cast"}

# タイプを増やしてもここを触らずに済むよう、magic/<id>/cast へマクロで委譲する
function test:magic/dispatch with storage test: magic.player
