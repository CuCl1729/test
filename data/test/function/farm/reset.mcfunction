#> test:farm/reset
# @s = 収穫した魔法作物。最初の段階に戻し、次の段階の時刻を 今 + 1段階の時間(#farm_step に入れてある)にする

data modify entity @s data.crop.stage set value 0
execute store result entity @s data.crop.next_at int 1 run scoreboard players get #farm_step test.temporary
function test:farm/look with entity @s data.crop
