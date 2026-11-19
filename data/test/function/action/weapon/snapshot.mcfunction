#> test:action/weapon/snapshot
# @s = 武器攻撃の所持者(オーナー)。#damage と storage test: attack.player は呼び出し元が
# 既に準備済み(AoE倍率等も反映後)。magic.player.data.action をこの武器の記録で丸ごと差し替える
# だけで、手替えやターゲットループ後も元のダメージを再現できるようにする。
# crit_damage は #damage 側で既に÷100済み(150=150%)なので、ここで再度正規化しない。
# magic.player.data の他フィールドやオーナーの他スコア・所持品には触れない。

data modify storage test: magic.player.data.action set value {kind:"weapon",damage:{},combat:{resist_pene:{}},weapon:{}}

execute store result storage test: magic.player.data.action.damage.fire int 1 run scoreboard players get #damage test.fire_damage
execute store result storage test: magic.player.data.action.damage.water int 1 run scoreboard players get #damage test.water_damage
execute store result storage test: magic.player.data.action.damage.wood int 1 run scoreboard players get #damage test.wood_damage
execute store result storage test: magic.player.data.action.damage.metal int 1 run scoreboard players get #damage test.metal_damage
execute store result storage test: magic.player.data.action.damage.earth int 1 run scoreboard players get #damage test.earth_damage
execute store result storage test: magic.player.data.action.damage.physics int 1 run scoreboard players get #damage test.physics_damage

execute store result storage test: magic.player.data.action.combat.crit_rate int 1 run scoreboard players get #damage test.status.crit_rate
execute store result storage test: magic.player.data.action.combat.crit_damage int 1 run scoreboard players get #damage test.status.crit_damage
execute store result storage test: magic.player.data.action.combat.def_pene int 1 run scoreboard players get #damage test.def.pene

execute store result storage test: magic.player.data.action.combat.resist_pene.fire int 1 run scoreboard players get #damage test.fire_resist.pene
execute store result storage test: magic.player.data.action.combat.resist_pene.water int 1 run scoreboard players get #damage test.water_resist.pene
execute store result storage test: magic.player.data.action.combat.resist_pene.wood int 1 run scoreboard players get #damage test.wood_resist.pene
execute store result storage test: magic.player.data.action.combat.resist_pene.metal int 1 run scoreboard players get #damage test.metal_resist.pene
execute store result storage test: magic.player.data.action.combat.resist_pene.earth int 1 run scoreboard players get #damage test.earth_resist.pene
execute store result storage test: magic.player.data.action.combat.resist_pene.physics int 1 run scoreboard players get #damage test.physics_resist.pene

data modify storage test: magic.player.data.action.weapon set from storage test: attack.player

return 1
