#> test:buff/events/end
# begin と対を成さない end は 0 を返し、何も変えない

execute unless score #bq_hold test.buff.work matches 1.. run return 0
scoreboard players remove #bq_hold test.buff.work 1
execute if score #bq_hold test.buff.work matches 0 unless score #bq_draining test.buff.work matches 1 run function test:buff/events/drain
return 1
