#> test:buff/resource/write
# 内部。マクロ {resource:"hp"|"mp"}。まとめた結果を @s へ一度だけ書く

$scoreboard players operation @s test.status.$(resource) = #br_new test.buff.work
