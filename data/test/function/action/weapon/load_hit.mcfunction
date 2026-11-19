#> test:action/weapon/load_hit
# @s は無関係(呼び出し元がターゲットループへ入る前に呼ぶ)。storage test: action_hit には
# ヒットさせたい武器攻撃のaction記録が凍結してコピーされている(magic.player.dataとは独立)。
# 会心率/会心ダメージ/防御貫通/属性ごとの耐性貫通とattack.player(武器のcustom_data)だけを
# #damage に復元する。これにより他の呪文が magic.player.data を上書きしていても、
# 発射済みの武器弾や多段ヒットで手替え前の毒武器などが正しく適用できる。
# #damage のダメージ6チャンネルは呼び出し元がビーム/フィールドパルス用に既に調整済みのため
# ここでは一切書き換えない。武器の記録でなければ何もせず return 0。

execute unless data storage test: action_hit{kind:"weapon"} run return 0

execute store result score #damage test.status.crit_rate run data get storage test: action_hit.combat.crit_rate
execute store result score #damage test.status.crit_damage run data get storage test: action_hit.combat.crit_damage
execute store result score #damage test.def.pene run data get storage test: action_hit.combat.def_pene

execute store result score #damage test.fire_resist.pene run data get storage test: action_hit.combat.resist_pene.fire
execute store result score #damage test.water_resist.pene run data get storage test: action_hit.combat.resist_pene.water
execute store result score #damage test.wood_resist.pene run data get storage test: action_hit.combat.resist_pene.wood
execute store result score #damage test.metal_resist.pene run data get storage test: action_hit.combat.resist_pene.metal
execute store result score #damage test.earth_resist.pene run data get storage test: action_hit.combat.resist_pene.earth
execute store result score #damage test.physics_resist.pene run data get storage test: action_hit.combat.resist_pene.physics

data modify storage test: attack.player set from storage test: action_hit.weapon

return 1
