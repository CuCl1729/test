#> test:machine/shape/check
# @s = 機械のマーカー(実行位置は核の中心)。外側の26か所(asset.machine_shell)を1か所ずつ判定し、次のものを作る:
#   #machine_missing  何も無い(筐体でも口でもない)位置の数。その位置は machine_work.missing [{x,y,z}]
#   #machine_mixed    見つけた筐体と違う種類の筐体の数(全部同じ種類のときだけ完成)
#   #machine_inputs / machine_work.inputs [{x,y,z}]   搬入口の数と位置
#   #machine_outputs / machine_work.outputs [{x,y,z}] 外向きの搬出口の数と、成果物を出す位置(搬出口の向いている隣)
#   machine_work.casing / casing_def  見つけた筐体のidと定義(無ければ "" と {})

scoreboard players set #machine_missing test.temporary 0
scoreboard players set #machine_mixed test.temporary 0
scoreboard players set #machine_inputs test.temporary 0
scoreboard players set #machine_outputs test.temporary 0
data modify storage test: machine_work.missing set value []
data modify storage test: machine_work.inputs set value []
data modify storage test: machine_work.outputs set value []
data modify storage test: machine_work.casing set value ""
data modify storage test: machine_work.casing_def set value {}

data modify storage test: machine_work.shell set from storage test: asset.machine_shell
function test:machine/shape/loop
