#> test:machine/pre/load_by
# @macro machine/kind: 機械と原石の種類(ほかのキーも渡ってくるが使わない)。その組み合わせの副産物の行を machine_work.by に写す
# (行が無ければ空のまま。副産物が出ないだけ)

$data modify storage test: machine_work.by set from storage test: asset.pre_by.$(machine).$(kind)
