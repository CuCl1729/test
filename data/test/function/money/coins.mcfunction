#> test:money/coins
# @s = プレイヤー。持っているコイン(持ち物とカーソル)の合計を返す

execute store result score #mc1 test.temporary run clear @s *[minecraft:custom_data~{test:{coin:1}}] 0
execute store result score #mc10 test.temporary run clear @s *[minecraft:custom_data~{test:{coin:10}}] 0
execute store result score #mc100 test.temporary run clear @s *[minecraft:custom_data~{test:{coin:100}}] 0
scoreboard players operation #mc10 test.temporary *= #10 test.constant
scoreboard players operation #mc100 test.temporary *= #100 test.constant
scoreboard players operation #mc1 test.temporary += #mc10 test.temporary
scoreboard players operation #mc1 test.temporary += #mc100 test.temporary
return run scoreboard players get #mc1 test.temporary
