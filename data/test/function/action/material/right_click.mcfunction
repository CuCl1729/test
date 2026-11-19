#> test:action/material/right_click
# 実行位置 = 鍛冶で生成中の武器(loot.item)。@macro id,trigger,recipe,multiplier_min,multiplier_max:
# 登録済みレシピ(asset.action.recipes.$(recipe))をコンパイルし、右クリックで発動する扇状の範囲攻撃として
# 武器に焼き込む(倍率は作成時に一定範囲でランダム決定。半径は既存のreachをそのまま流用する)

data remove storage test: magic_recipe
$data modify storage test: magic_recipe.build set from storage test: asset.action.recipes.$(recipe).build
$data modify storage test: magic_recipe.settings set from storage test: asset.action.recipes.$(recipe).settings
function test:magic/recipe/compile

execute if data storage test: magic.loot.invalid run scoreboard players set #material_invalid test.temporary 1
execute unless data storage test: magic.loot.status.magic_type run scoreboard players set #material_invalid test.temporary 1
execute if score #material_invalid test.temporary matches 1 run data remove storage test: loot.item
execute if score #material_invalid test.temporary matches 1 run return 0

# コンパイル済みの1段目の状態(つなぎ含む)をそのまま凍結して武器に積む(アダプタはまだ無く、今は参照しない)
data modify storage test: loot.item.components."minecraft:custom_data".test.weapon_action.status set from storage test: magic.loot.status
execute store result storage test: loot.item.components."minecraft:custom_data".test.weapon_action.status.cost int 1 run scoreboard players get #cost test.temporary
$data modify storage test: loot.item.components."minecraft:custom_data".test.weapon_action.recipe set value "$(recipe)"

# 武器リーチに従うか、明示半径を保つかをここで確定する。root段がコーンで、レシピが半径を
# 明示していない(settings[0].stage.aoe.radiusが無い)ときだけ1bを立てる。他は未設定=明示半径優先
data remove storage test: loot.item.components."minecraft:custom_data".test.weapon_action.weapon_reach
scoreboard players set #weapon_reach_flag test.temporary 0
execute if data storage test: magic.loot.status{magic_type:"aoe"} if data storage test: magic.loot.status.aoe{shape:"cone"} run scoreboard players set #weapon_reach_flag test.temporary 1
$execute if score #weapon_reach_flag test.temporary matches 1 unless data storage test: asset.action.recipes.$(recipe).settings[0].stage.aoe.radius run \
data modify storage test: loot.item.components."minecraft:custom_data".test.weapon_action.weapon_reach set value 1b

scoreboard players add #magic_uid test.time 1
execute store result storage test: loot.item.components."minecraft:custom_data".test.weapon_action.uid int 1 run scoreboard players get #magic_uid test.time

# consumableが無いと右クリックが「使用」として検知されない(item/magic/give.mcfunctionの実装と同じ)
data modify storage test: loot.item.components.consumable set value {consume_seconds:100000,animation:none}
data modify storage test: loot.item.components.minecraft:custom_data.test merge value {right_click:true,aoe_attack:1b}

scoreboard players set #half_angle test.temporary 45
execute if data storage test: magic.loot.status.aoe.half_angle store result score #half_angle test.temporary run data get storage test: magic.loot.status.aoe.half_angle
scoreboard players operation #half_angle test.temporary += #half_angle test.temporary

data modify storage test: loot.item.components.minecraft:custom_data.weapon append value {type:"aoe_angle",value:0}
execute store result storage test: loot.item.components.minecraft:custom_data.weapon[-1].value int 1 run scoreboard players get #half_angle test.temporary

data modify storage test: loot.item.components.minecraft:custom_data.weapon append value {type:"aoe_multiplier",value:0}
$execute store result storage test: loot.item.components.minecraft:custom_data.weapon[-1].value int 1 run function test:rng/roll {key:"aoe_multiplier",min:$(multiplier_min),max:$(multiplier_max)}

data modify storage test: loot.item.components.minecraft:custom_data.weapon append value {type:"aoe_mp_cost",value:0}
execute store result storage test: loot.item.components.minecraft:custom_data.weapon[-1].value int 1 run scoreboard players get #cost test.temporary
