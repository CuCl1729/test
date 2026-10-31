#> test:farm/plant_init
# @s = 植えたばかりの魔法作物(interaction)。次の段階になる時刻(#farm_now)を入れ、見た目を最初の段階にする

tag @s remove magic_crop_new
execute store result entity @s data.crop.next_at int 1 run scoreboard players get #farm_now test.temporary
function test:farm/look with entity @s data.crop
