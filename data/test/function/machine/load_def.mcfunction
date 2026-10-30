#> test:machine/load_def
# @macro id: 機械の種類。asset.machine.<id> を machine_work.def に写す(定義が無ければ空のまま)

data modify storage test: machine_work.def set value {}
$data modify storage test: machine_work.def set from storage test: asset.machine.$(id)
