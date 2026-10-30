#> test:init/asset/machine/stage_set
# @macro stage/stage_prefix/stage_model: 前処理の機械の定義(ほかのキーも渡ってくるが使わない)

$data modify storage test: asset.ore_stage.s$(stage) set value {prefix:"$(stage_prefix)",model:"$(stage_model)"}
