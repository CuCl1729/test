#> test:buff/events/begin
# 明示的なまとめの保留。この間は配達を待たせるが、状態や得点は都度そのまま積まれていく

scoreboard players add #bq_hold test.buff.work 1
return 1
