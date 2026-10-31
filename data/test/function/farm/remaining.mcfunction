#> test:farm/remaining
# @s = プレイヤー。@macro next_at: 育ちきっていない魔法作物の次の段階の時刻(ほかのキーも渡ってくるが使わない)。
# 育ちきるまでの残り = (next_at − 今) + (育ちきる段階 − 今の段階 − 1) × 1段階の時間 を、「あと 1分20秒」の形で出す

$scoreboard players set #farm_left test.temporary $(next_at)
scoreboard players operation #farm_left test.temporary -= #farm_now test.temporary
scoreboard players operation #farm_k test.temporary = #farm_last test.temporary
scoreboard players operation #farm_k test.temporary -= #farm_stage test.temporary
scoreboard players remove #farm_k test.temporary 1
execute store result score #farm_step test.temporary run data get storage test: farm_work.def.step
scoreboard players operation #farm_k test.temporary *= #farm_step test.temporary
scoreboard players operation #farm_left test.temporary += #farm_k test.temporary
# tick → 秒(切り上げ) → 分と秒
scoreboard players add #farm_left test.temporary 19
scoreboard players set #farm_n test.temporary 20
scoreboard players operation #farm_left test.temporary /= #farm_n test.temporary
scoreboard players set #farm_n test.temporary 60
scoreboard players operation #farm_min test.temporary = #farm_left test.temporary
scoreboard players operation #farm_min test.temporary /= #farm_n test.temporary
scoreboard players operation #farm_left test.temporary %= #farm_n test.temporary
execute if score #farm_min test.temporary matches 1.. run return run title @s actionbar [{text:"あと ",color:"gray"},{score:{name:"#farm_min",objective:"test.temporary"},color:"aqua"},{text:"分",color:"gray"},{score:{name:"#farm_left",objective:"test.temporary"},color:"aqua"},{text:"秒",color:"gray"}]
title @s actionbar [{text:"あと ",color:"gray"},{score:{name:"#farm_left",objective:"test.temporary"},color:"aqua"},{text:"秒",color:"gray"}]
return 1
