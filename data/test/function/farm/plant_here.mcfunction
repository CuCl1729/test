#> test:farm/plant_here
# @s = プレイヤー。実行位置 = 耕地の1つ上のブロックの下の面の中心。@macro id: 魔法作物のid。
# 魔法作物は、バニラの作物ブロックではなくエンティティで作る(ランダムティック・骨粉・水流で勝手に育ったり壊れたりしないように):
#   interaction(右クリックで収穫・左クリックで抜く。tag=magic_crop、data.crop = {id, stage, next_at})と、
#   block_display(見た目。tag=magic_crop_display、ブロックの角。バニラの作物の成長段階の見た目を借りる)
# 種を1個減らす(クリエイティブでは減らさない)

$data modify storage test: farm_work.def set from storage test: asset.magic_crop.$(id)
$summon interaction ~ ~ ~ {width:1.0f,height:1.0f,response:1b,Tags:["magic_crop","magic_crop_new"],data:{crop:{id:"$(id)",stage:0,next_at:0}}}
summon block_display ~-0.5 ~ ~-0.5 {Tags:["magic_crop_display"]}
execute store result score #farm_now test.temporary run time query gametime
execute store result score #farm_step test.temporary run data get storage test: farm_work.def.step
scoreboard players operation #farm_now test.temporary += #farm_step test.temporary
execute as @e[type=interaction,tag=magic_crop_new] run function test:farm/plant_init
$execute unless entity @s[gamemode=creative] run clear @s *[custom_data~{test:{magic_seed:"$(id)"}}] 1
$function test:debug/log {msg:"魔法作物を植えた: $(id)"}
