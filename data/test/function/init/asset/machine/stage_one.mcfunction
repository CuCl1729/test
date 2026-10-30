#> test:init/asset/machine/stage_one
# @macro id: 機械の種類。前処理の機械(kind:"pre")だけ、その段階の名前の頭と見た目を登録する

$execute if data storage test: asset.machine.$(id){kind:"pre"} run function test:init/asset/machine/stage_set with storage test: asset.machine.$(id)
