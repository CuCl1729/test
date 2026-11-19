#> test:magic/beam/prepare
# 継続の魔法の「1パルスぶんの用意」。ビームだけでなく場(test:magic/field/pulse)も通る共通処理。
# @s = ダメージの持ち主 = その値を持っているもの(プレイヤーのビームなら詠唱者、
# 自動ビームならビーム本体、場なら場本体。どれも5属性のダメージを自分に持っている)。
# ダメージ・バフの振り分け・行き止まり(または場の中心)の範囲の用意をする(magic/aoe/cast と同じ要領)。
# magic.player はこのパルスのぶんに差し替えてから呼ぶこと

# action_hit は武器弾のパルスを跨いで持ち越さない。純粋な魔法のパルスならここで消したままになる
data remove storage test: action_hit

scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage
scoreboard players set #damage test.physics_damage 0

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.def.pene = @s test.def.pene

scoreboard players operation #damage test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation #damage test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation #damage test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation #damage test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation #damage test.earth_resist.pene = @s test.earth_resist.pene

# 武器弾の継続(ビーム/場)なら、凍結済みの武器actionをaction_hitへ積んで会心/貫通/武器データを復元する。
# 6チャンネルのうち物理だけは持続本体(@s)側で既に確定しているその場の値を使う。他の5属性には触れない。
# cont/scale より前に済ませる(scale側がaction_hit.kind=weaponを見て物理チャンネルを縮めるため)
execute if data storage test: magic.player.data.action{kind:"weapon"} run scoreboard players operation #damage test.physics_damage = @s test.physics_damage
execute if data storage test: magic.player.data.action{kind:"weapon"} run data modify storage test: action_hit set from storage test: magic.player.data.action
execute if data storage test: magic.player.data.action{kind:"weapon"} run function test:action/weapon/load_hit

# 1秒あたりの数値を1パルスぶんに縮める(tick の細かさで総量が増えないように)
function test:magic/cont/scale with storage test: magic.player.continuous

# 行き止まりの範囲で使う値。貫いた敵それぞれでは出さない(magic/beam/ray)
scoreboard players set #aoe_heal test.temporary 0
execute if data storage test: magic.player.heal run scoreboard players set #aoe_heal test.temporary 1
scoreboard players set #aoe_revive test.temporary 0
execute if data storage test: magic.player.revive run scoreboard players set #aoe_revive test.temporary 1
data modify storage test: magic_revive set value {radius:0,percent:0}
data modify storage test: magic_revive.radius set from storage test: magic.player.aoe.radius
data modify storage test: magic_revive.percent set from storage test: magic.player.revive.percent

data modify storage test: magic_buff.src set value []
execute if data storage test: magic.player.buff[0] run data modify storage test: magic_buff.src set from storage test: magic.player.buff
function test:magic/buff/prepare

data remove storage test: magic_blast
execute if data storage test: magic.player.blast run data modify storage test: magic_blast set from storage test: magic.player.blast
execute if data storage test: magic.player.blast run data modify storage test: magic_blast.radius set from storage test: magic.player.aoe.radius

# 行き止まり/場の円は旧剣AoEの扇形ではないため、呼び出し後のapply側が別の詠唱のconeを
# 拾わないよう常に0にしておく
scoreboard players set #aoe_weapon_cone test.temporary 0
