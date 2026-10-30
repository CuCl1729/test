#> test:machine/port/out/pick
# @macro i: 使う搬出口の番号。machine_work.outputs[i] を machine_work.out_pos にする

$data modify storage test: machine_work.out_pos set from storage test: machine_work.outputs[$(i)]
