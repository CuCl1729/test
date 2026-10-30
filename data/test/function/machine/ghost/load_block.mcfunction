#> test:machine/ghost/load_block
# @macro ghost_casing: ゴーストに見せる筐体の種類(machine_work。ほかのキーも渡ってくるが使わない)。そのブロックを machine_work.ghost_arg.block に入れる

$data modify storage test: machine_work.ghost_arg.block set from storage test: asset.casing.$(ghost_casing).block
