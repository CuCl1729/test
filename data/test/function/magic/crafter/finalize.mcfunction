#> test:magic/crafter/finalize
# @s = クラフター本体。全スロットを処理し終えたあと、順序非依存に集計した数値を反映する
# (素材を置く順番で結果が変わらないよう、加算系はここでまとめて合算する)

execute if data storage test: magic.loot.status.aoe if score #radius_bonus test.temporary matches 1.. run scoreboard players operation #radius_value test.temporary = #radius_bonus test.temporary
execute if data storage test: magic.loot.status.aoe if score #radius_bonus test.temporary matches 1.. store result score #radius_base test.temporary run data get storage test: magic.loot.status.aoe.radius
execute if data storage test: magic.loot.status.aoe if score #radius_bonus test.temporary matches 1.. run scoreboard players operation #radius_value test.temporary += #radius_base test.temporary
execute if data storage test: magic.loot.status.aoe if score #radius_bonus test.temporary matches 1.. store result storage test: magic.loot.status.aoe.radius int 1 run scoreboard players get #radius_value test.temporary
