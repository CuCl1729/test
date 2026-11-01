# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/cond/c1
# 条件: story:path=0

scoreboard players set #cv test.temporary 0
execute store result score #cv test.temporary run data get storage test: story.flag.path
execute unless score #cv test.temporary matches 0 run return 0
return 1
