function #oh_my_dat:please

# ダウン中は唱えられない(自分を回復して起き上がれないように)
execute if entity @s[tag=downed] run return fail
# ターン制の戦闘中は唱えられない(戦闘の魔法は手番の「スキル」から。手番の外の攻撃と、報酬の無い撃破を防ぐ)
execute if score @s test.battle.id matches 1.. run execute store success score @s test.ui.bar_shown run title @s actionbar {text:"戦闘中は使えない",color:"gray"}
execute if score @s test.battle.id matches 1.. run return fail
# つないだ魔法(通し番号 uid がある)は押し始めだけを受け付け、自分の「再使用で」の設置物があれば、
# 唱える代わりにそれを起動する(MP は払わない)
execute if data storage test: magic.player.uid unless function test:magic/chain/press run return fail
execute if data storage test: magic.player.uid if function test:magic/place/recast run return 1
# 唱えた回の通し番号。設置物は前の回のものだけを置き換える(複数発射した弾がそれぞれ置いた分は残す)
execute if data storage test: magic.player.uid run scoreboard players add #magic_cast test.time 1
execute if data storage test: magic.player.uid store result storage test: magic.player.cast int 1 run scoreboard players get #magic_cast test.time

# 消費MPを払う(足りなければ唱えない)。ターン制でも同じ処理を使う
execute unless function test:magic/pay run return fail

function test:magic/prepare_damage

# 防具のセット効果(magic_cast)。ダメージが決まった後、届け方へ渡す前に詠唱者の属性ダメージをいじれる
function test:equip/event {event:"magic_cast"}

# タイプを増やしてもここを触らずに済むよう、magic/<id>/cast へマクロで委譲する
function test:magic/dispatch with storage test: magic.player
