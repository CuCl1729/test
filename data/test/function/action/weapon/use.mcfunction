#> test:action/weapon/use
# @s = プレイヤー。右クリックで発動する武器アダプタの共通入口(旧 test:attack/aoe の扇状範囲攻撃を含む)。
# attack.player/#damage/test.repeat は test:attack/prepare が1回だけ整える(会心150正規化・射程込み)。
# 武器に凍結済みの magic.player.data.action.status があれば読み込み、無ければ旧コーン限定の互換値を組み立てる

function #oh_my_dat:please
function test:attack/prepare

scoreboard players set #weapon_has_status test.temporary 0
execute if data storage test: attack.player.test.weapon_action.status run scoreboard players set #weapon_has_status test.temporary 1

execute if score #weapon_has_status test.temporary matches 1 run data modify storage test: magic.player set from storage test: attack.player.test.weapon_action.status
execute if score #weapon_has_status test.temporary matches 0 run data modify storage test: magic.player set value {magic_type:"aoe",types:["aoe"],type_flags:{aoe:1b},aoe:{shape:"cone"},data:{}}

# 旧コーンのみ: MP消費量/半角/半径をここで武器の古いフィールドから組み立てる(つなぎ・持続・UIDは持ち込まない)
execute if score #weapon_has_status test.temporary matches 0 run data modify storage test: magic.player.cost set value 0
execute if score #weapon_has_status test.temporary matches 0 run execute store result storage test: magic.player.cost int 1 run data get storage test: attack.player.weapon[{type:"aoe_mp_cost"}].value

execute if score #weapon_has_status test.temporary matches 0 run execute store result score #weapon_half_angle test.temporary run data get storage test: attack.player.weapon[{type:"aoe_angle"}].value
execute if score #weapon_has_status test.temporary matches 0 run scoreboard players operation #weapon_half_angle test.temporary /= #2 test.constant
execute if score #weapon_has_status test.temporary matches 0 run execute store result storage test: magic.player.aoe.half_angle int 1 run scoreboard players get #weapon_half_angle test.temporary

execute if score #weapon_has_status test.temporary matches 0 run execute store result storage test: magic.player.aoe.radius int 1 run scoreboard players get @s test.repeat

# 旧コーン互換(root=aoe, cone, 持続でもつなぎでもない)だけ従来のバトル中可否を維持する。
# それ以外の新しい発動(弾/円/ビーム/つなぎ等)はダウン中・ターン制バトル中を弾く(magic/.と同じ灰色表示)
scoreboard players set #weapon_legacy_cone test.temporary 0
execute if data storage test: magic.player{magic_type:"aoe"} if data storage test: magic.player.aoe{shape:"cone"} unless data storage test: magic.player.type_flags{continuous:1b} unless data storage test: magic.player.chain[0] run scoreboard players set #weapon_legacy_cone test.temporary 1

execute if score #weapon_legacy_cone test.temporary matches 0 if entity @s[tag=downed] run return 0
execute if score #weapon_legacy_cone test.temporary matches 0 if score @s test.battle.id matches 1.. run execute store success score @s test.ui.bar_shown run title @s actionbar {text:"戦闘中は使えない",color:"gray"}
execute if score #weapon_legacy_cone test.temporary matches 0 if score @s test.battle.id matches 1.. run return 0

# 武器の範囲攻撃倍率(鍛冶で確定済み)を#damageの6属性に一度だけ掛ける。旧attack/aoeと同じ計算
execute store result score #weapon_aoe_multiplier test.temporary run data get storage test: attack.player.weapon[{type:"aoe_multiplier"}].value
scoreboard players operation #damage test.fire_damage *= #weapon_aoe_multiplier test.temporary
scoreboard players operation #damage test.fire_damage /= #100 test.constant
scoreboard players operation #damage test.water_damage *= #weapon_aoe_multiplier test.temporary
scoreboard players operation #damage test.water_damage /= #100 test.constant
scoreboard players operation #damage test.wood_damage *= #weapon_aoe_multiplier test.temporary
scoreboard players operation #damage test.wood_damage /= #100 test.constant
scoreboard players operation #damage test.metal_damage *= #weapon_aoe_multiplier test.temporary
scoreboard players operation #damage test.metal_damage /= #100 test.constant
scoreboard players operation #damage test.earth_damage *= #weapon_aoe_multiplier test.temporary
scoreboard players operation #damage test.earth_damage /= #100 test.constant
scoreboard players operation #damage test.physics_damage *= #weapon_aoe_multiplier test.temporary
scoreboard players operation #damage test.physics_damage /= #100 test.constant

# root段がcone(旧互換でも新規でも)なら、スキャンは目線起点にする。半径は鍛冶が「武器リーチに従う」で
# 焼いた(weapon_reach:1b)ときだけ test.repeat で上書きし、それ以外は明示半径を保つ
scoreboard players set #weapon_root_cone test.temporary 0
execute if data storage test: magic.player{magic_type:"aoe"} if data storage test: magic.player.aoe{shape:"cone"} run scoreboard players set #weapon_root_cone test.temporary 1

execute if score #weapon_root_cone test.temporary matches 1 run data modify storage test: magic.player.aoe.eye_origin set value 1b
execute if score #weapon_root_cone test.temporary matches 1 if data storage test: attack.player.test.weapon_action{weapon_reach:1b} run execute store result storage test: magic.player.aoe.radius int 1 run scoreboard players get @s test.repeat

# 読み込んだ凍結状態のuidは一旦捨て、つなぎ(chain[0])か持続(continuous)のときだけ鍛冶済みの
# ability.uid を付け直す。単発(旧/新コーン・単段弾)は押すUIDを持たず、使う毎に再発動できる
data remove storage test: magic.player.uid
scoreboard players set #weapon_press_uid test.temporary 0
execute if data storage test: magic.player.chain[0] run scoreboard players set #weapon_press_uid test.temporary 1
execute if data storage test: magic.player.type_flags{continuous:1b} run scoreboard players set #weapon_press_uid test.temporary 1
execute if score #weapon_press_uid test.temporary matches 1 run data modify storage test: magic.player.uid set from storage test: attack.player.test.weapon_action.uid

function test:action/weapon/snapshot
execute at @s anchored feet run function test:action/cast
