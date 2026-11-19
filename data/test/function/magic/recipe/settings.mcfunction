#> test:magic/recipe/settings
# registry_work.recipe_settings の先頭(今の段ぶん)を取り出し、段の数値と費用に適用する。無ければ何もしない

data modify storage test: registry_work.stage_setting set value {}
execute if data storage test: registry_work.recipe_settings[0] run data modify storage test: registry_work.stage_setting set from storage test: registry_work.recipe_settings[0]
data remove storage test: registry_work.recipe_settings[0]

execute if data storage test: registry_work.stage_setting.stage run data modify storage test: magic.loot.status merge from storage test: registry_work.stage_setting.stage
execute if data storage test: registry_work.stage_setting.cost store result score #cost test.temporary run data get storage test: registry_work.stage_setting.cost
