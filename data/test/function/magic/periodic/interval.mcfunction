#> test:magic/periodic/interval
# @s = 持ち主(オーナー)。一定間隔の発生源を作る所(置く/自己持続/投射体)で1回だけ呼ぶ。
# @macro interval: つなぎに保存された間隔(秒)
#
# 持ち主の test.periodic.reduce (%。無ければ0) だけ間隔を短縮し、有効なtick数にして
# #periodic_result test.temporary へ返す。切り上げてから最低2tickに収める(0tickや負の間隔を防ぐ)。
# 呼び出し後にこの間隔を持ち主のスコアが変わっても、既に作った発生源の間隔は変わらない(ここで1回だけ計算するため)
$scoreboard players set #periodic_result test.temporary $(interval)
scoreboard players operation #periodic_result test.temporary *= #20 test.constant

scoreboard players set #periodic_reduce test.temporary 0
execute if score @s test.periodic.reduce matches -2147483648..2147483647 run scoreboard players operation #periodic_reduce test.temporary = @s test.periodic.reduce

# 100%以上の短縮は、掛け算に進む前に打ち切る(大きな間隔×大きな割合でのオーバーフローを避けるため)
execute if score #periodic_reduce test.temporary matches 100.. run return run scoreboard players set #periodic_result test.temporary 2

scoreboard players set #periodic_pct test.temporary 100
scoreboard players operation #periodic_pct test.temporary -= #periodic_reduce test.temporary

scoreboard players operation #periodic_result test.temporary *= #periodic_pct test.temporary
scoreboard players add #periodic_result test.temporary 99
scoreboard players operation #periodic_result test.temporary /= #100 test.constant

execute if score #periodic_result test.temporary matches ..1 run scoreboard players set #periodic_result test.temporary 2
