#> test:buff/resource/read
# 内部。マクロ {resource:"hp"|"mp"}。@s の今の資源と上限を得点へ読む。
# 得点が無い的は0として扱う(store result は走らせた命令が失敗すると0を書く)

$execute store result score #br_cur test.buff.work run scoreboard players get @s test.status.$(resource)
$execute store result score #br_max test.buff.work run scoreboard players get @s test.status.$(resource)_max
