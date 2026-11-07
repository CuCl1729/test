#> test:status/level_bonus
# @s = プレイヤー。プレイヤーレベル(test.status.level)による共通の成長を test.level_bonus.<stat> にゼロから組み直す
# (1レベルごとの量 asset.level_growth.<stat> × max(レベル−1, 0)。職業によらない)。status/update の最後で test.job_bonus と
# 一緒に足される。何度呼んでも同じ値になる。test.level_bonus.level は組み直したときのレベル(test:status/regene/ が見る)

scoreboard players set #lv test.temporary 0
execute if score @s test.status.level matches 1.. run scoreboard players operation #lv test.temporary = @s test.status.level
scoreboard players operation @s test.level_bonus.level = #lv test.temporary
scoreboard players remove #lv test.temporary 1
execute if score #lv test.temporary matches ..-1 run scoreboard players set #lv test.temporary 0

execute store result score @s test.level_bonus.atk run data get storage test: asset.level_growth.atk
execute store result score @s test.level_bonus.def run data get storage test: asset.level_growth.def
execute store result score @s test.level_bonus.hp_max run data get storage test: asset.level_growth.hp_max
execute store result score @s test.level_bonus.mp_max run data get storage test: asset.level_growth.mp_max
execute store result score @s test.level_bonus.crit_rate run data get storage test: asset.level_growth.crit_rate
execute store result score @s test.level_bonus.crit_damage run data get storage test: asset.level_growth.crit_damage
execute store result score @s test.level_bonus.effect_damage run data get storage test: asset.level_growth.effect_damage
execute store result score @s test.level_bonus.magic_efficiency run data get storage test: asset.level_growth.magic_efficiency
execute store result score @s test.level_bonus.divergence run data get storage test: asset.level_growth.divergence
execute store result score @s test.level_bonus.hp_regene run data get storage test: asset.level_growth.hp_regene
execute store result score @s test.level_bonus.mp_regene run data get storage test: asset.level_growth.mp_regene

scoreboard players operation @s test.level_bonus.atk *= #lv test.temporary
scoreboard players operation @s test.level_bonus.def *= #lv test.temporary
scoreboard players operation @s test.level_bonus.hp_max *= #lv test.temporary
scoreboard players operation @s test.level_bonus.mp_max *= #lv test.temporary
scoreboard players operation @s test.level_bonus.crit_rate *= #lv test.temporary
scoreboard players operation @s test.level_bonus.crit_damage *= #lv test.temporary
scoreboard players operation @s test.level_bonus.effect_damage *= #lv test.temporary
scoreboard players operation @s test.level_bonus.magic_efficiency *= #lv test.temporary
scoreboard players operation @s test.level_bonus.divergence *= #lv test.temporary
scoreboard players operation @s test.level_bonus.hp_regene *= #lv test.temporary
scoreboard players operation @s test.level_bonus.mp_regene *= #lv test.temporary
