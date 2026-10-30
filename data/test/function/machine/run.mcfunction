#> test:machine/run
# @s = 形の揃った機械のマーカー(実行位置は核の中心)。machine_work.def = 機械の定義(+id)、machine_work.casing_def = 筐体の性能、
# machine_work.inputs = 搬入口の位置、machine_work.outputs = 搬出口と送り先の位置。
# 1. 搬入口の中身を整理する: 燃料は機械の中に蓄え(上限まで)、受け付ける原石は残し、それ以外は出すもの(machine_work.drop)へ
# 2. 処理中なら筐体の処理速度ぶん進め、終わったら結果を出す
# 3. 処理していなければ、搬入口から原石を1個取り出して始める(筐体の燃料の消費量ぶん燃料を使う)
# 4. 出すものを、搬出口の中に順番に入れる(test:machine/port/out/place_all)。入りきらなかった分は data.machine.pending に持ち、
#    それが残っている間は 2・3 を止める(「搬出口がいっぱい」)
# 5. 搬出口の中身を、向いている先の入れ物に送る(test:machine/port/out/push_all。入れ物が無ければ搬出口の中に残る)
# 6. 状態を表示する

scoreboard players set #machine_pending test.temporary 0
execute store result score #machine_pending test.temporary run data get entity @s data.machine.pending
data modify storage test: machine_work.drop set value []
data modify storage test: machine_work.drop append from entity @s data.machine.pending[]
data remove entity @s data.machine.pending
scoreboard players set #machine_no_fuel test.temporary 0
data modify entity @s data.machine.casing set from storage test: machine_work.casing

# 筐体の性能と燃料の上限(test.machine.fuel / progress は ×100 で持つ)
execute store result score #machine_speed test.temporary run data get storage test: machine_work.casing_def.speed
execute store result score #machine_by_bonus test.temporary run data get storage test: machine_work.casing_def.by_bonus
execute store result score #machine_fuel_use test.temporary run data get storage test: machine_work.casing_def.fuel_use
execute store result score #machine_fuel_max test.temporary run data get storage test: asset.config.machine_fuel_max
scoreboard players operation #machine_fuel_max test.temporary *= #100 test.constant

data modify storage test: machine_work.port_queue set from storage test: machine_work.inputs
function test:machine/port/sort_loop

execute if score #machine_pending test.temporary matches 0 if data entity @s data.machine.processing run function test:machine/progress
execute if score #machine_pending test.temporary matches 0 unless data entity @s data.machine.processing run function test:machine/start

function test:machine/port/out/place_all
function test:machine/port/out/push_all
function test:machine/show
