#> test:magic/aoe/cast_body
# @s = 詠唱者。自分を中心とした円状に、組み合わせた効果を適用する(リアルタイム戦闘)
# ダメージ量は詠唱者に乗っている値をprojectile/move.mcfunctionと同じ要領で#damageへ移す

# action_hit は武器弾の着弾を跨いで持ち越さない。純粋な魔法ならここで消したままになる
data remove storage test: action_hit

execute unless function test:magic/root/commit run return 0

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

# 武器弾のAoEなら、凍結済みの武器actionをaction_hitへ積んで会心/貫通/武器データを復元する
# (6チャンネルのうち物理だけは詠唱者側で既に確定しているその場の値を使う。他の5属性には触れない)
execute if data storage test: magic.player.data.action{kind:"weapon"} run scoreboard players operation #damage test.physics_damage = @s test.physics_damage
execute if data storage test: magic.player.data.action{kind:"weapon"} run data modify storage test: action_hit set from storage test: magic.player.data.action
execute if data storage test: magic.player.data.action{kind:"weapon"} run function test:action/weapon/load_hit

execute store result score #aoe_radius test.temporary run data get storage test: magic.player.aoe.radius

scoreboard players set #aoe_heal test.temporary 0
execute if data storage test: magic.player.heal run scoreboard players set #aoe_heal test.temporary 1

# 蘇生(範囲内でダウンしている味方を起こす)。投射体の着弾(projectile/burst)では行わない
scoreboard players set #aoe_revive test.temporary 0
execute if data storage test: magic.player.revive run scoreboard players set #aoe_revive test.temporary 1
data modify storage test: magic_revive set value {radius:0,percent:0}
data modify storage test: magic_revive.radius set from storage test: magic.player.aoe.radius
data modify storage test: magic_revive.percent set from storage test: magic.player.revive.percent

# 詠唱者を含むプレイヤーはダメージ側の対象から外れる(apply側でtype=!playerに絞っている)ため、
# 自分を巻き込む心配はない。逆に回復効果は円内の味方として自分にも掛かる
# ダメージ表示(test:damage/display)が詠唱者を引けるよう一時タグを付けておく
tag @s add damage_attacker

# 選んだバフ/デバフを敵向け・味方向けに振り分けておく(実際の配布はmagic/aoe/apply)
data modify storage test: magic_buff.src set value []
execute if data storage test: magic.player.buff[0] run data modify storage test: magic_buff.src set from storage test: magic.player.buff
function test:magic/buff/prepare

# 爆風(効果 blast)。外向き・上向きの速さと、範囲の半径
data remove storage test: magic_blast
execute if data storage test: magic.player.blast run data modify storage test: magic_blast set from storage test: magic.player.blast
execute if data storage test: magic.player.blast run data modify storage test: magic_blast.radius set from storage test: magic.player.aoe.radius

# 中心は実行位置。ふつうは詠唱者の位置だが、つないだ魔法の次の段(test:magic/chain/start)では
# 前の段の弾や設置物の位置になる
# 明示的にaoe.shape="cone"な場合(旧剣AoEの移行先)だけ扇形(scan/aoe/collect)で拾う。それ以外は既存の円形scan
execute if data storage test: magic.player.aoe{shape:"cone"} store result score #aoe_half_angle test.temporary run data get storage test: magic.player.aoe.half_angle
execute if data storage test: magic.player.aoe{shape:"cone"} store result score #aoe_reach test.temporary run data get storage test: magic.player.aoe.radius
# eye_originは採取点(^方向のサンプリング)だけを目線に上げる。戦闘判定/action_hitの基準位置(anchored feet)は
# attack/aoeが渡した通りのまま変えない
execute if data storage test: magic.player.aoe{shape:"cone",eye_origin:1b} anchored eyes positioned ^ ^ ^ run function test:scan/aoe/collect
execute if data storage test: magic.player.aoe{shape:"cone"} unless data storage test: magic.player.aoe{eye_origin:1b} run function test:scan/aoe/collect
execute unless data storage test: magic.player.aoe{shape:"cone"} run function test:magic/aoe/scan

# 旧剣AoE(武器コンテキストの明示的cone)はscan側で既に薙ぎ払いのパーティクル/音を出している。
# このmagic.playerは今の詠唱そのものなので、ここで確定させてからapplyへ渡す
scoreboard players set #aoe_weapon_cone test.temporary 0
execute if data storage test: magic.player.aoe{shape:"cone"} if data storage test: magic.player.data.action{kind:"weapon"} run scoreboard players set #aoe_weapon_cone test.temporary 1
function test:magic/aoe/apply

tag @s remove damage_attacker
