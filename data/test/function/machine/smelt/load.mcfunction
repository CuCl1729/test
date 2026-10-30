#> test:machine/smelt/load
# @macro kind: 原石の種類(ほかのキーも渡ってくるが使わない)。主産物と副産物の行を machine_work.main / by に写す

$data modify storage test: machine_work.main set from storage test: asset.refine.$(kind).main
$data modify storage test: machine_work.by set from storage test: asset.refine.$(kind).by
