#> test:equip/proc/cast_battle
# @s = ターン制の戦闘中のプレイヤー(at @s)。equip_work.proc_queue[0].magic(防具に付けた魔法)を、手番の魔法と同じ処理
# (test:battle/action/skill_cast/apply_*)で唱える。手番は使わず、対象は自動で選ぶ。MPは普通に払う(足りなければ唱えない)。
# 届け方は手番の魔法と同じ決め方にする: 自己 → 自分、範囲(投射と組み合わせた場合も)→ 敵全員・味方全員、
# 投射 → 1体(test:equip/proc/cast_battle_projectile)。自分の発動では予約しない(equip_proc_casting)

data modify storage test: magic.player set from storage test: equip_work.proc_queue[0].magic

tag @s add equip_proc_casting
tellraw @a[distance=..64] ["",{selector:"@s"},{text:" の防具の魔法！",color:light_purple}]

execute if data storage test: magic.player{magic_type:"self"} run function test:battle/action/skill_cast/apply_self
execute unless data storage test: magic.player{magic_type:"self"} if data storage test: magic.player.aoe run function test:battle/action/skill_cast/apply_aoe
execute unless data storage test: magic.player{magic_type:"self"} unless data storage test: magic.player.aoe run function test:equip/proc/cast_battle_projectile

tag @s remove equip_proc_casting
