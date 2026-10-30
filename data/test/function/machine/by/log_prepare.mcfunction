#> test:machine/by/log_prepare
# 副産物の1行の抽選結果を test:debug/log に出す(#by_roll / #by_c / #by_hit と machine_work.by[0])

data modify storage test: machine_work.log set value {key:"",material:"",roll:0,chance:0,result:"出ない"}
data modify storage test: machine_work.log.key set from storage test: machine_work.by_arg.key
data modify storage test: machine_work.log.material set from storage test: machine_work.by[0].material
execute store result storage test: machine_work.log.roll int 1 run scoreboard players get #by_roll test.temporary
execute store result storage test: machine_work.log.chance int 1 run scoreboard players get #by_c test.temporary
execute if score #by_hit test.temporary matches 1 run data modify storage test: machine_work.log.result set value "出た"
function test:machine/by/log with storage test: machine_work.log
