#> test:machine/load_def
# @macro id: 機械の種類。asset.machine.<id> を machine_work.def に写し、id も足す(定義が無ければ {id} だけになる)

data modify storage test: machine_work.def set value {}
$data modify storage test: machine_work.def set from storage test: asset.machine.$(id)
$data modify storage test: machine_work.def.id set value "$(id)"
