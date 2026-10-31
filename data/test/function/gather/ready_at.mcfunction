#> test:gather/ready_at
# @macro point/dim: ポイントとマップ(ほかのキーも渡ってくるが使わない)。復活の時刻を #gather_ready に入れる(無ければ0のまま)

$execute store result score #gather_ready test.temporary run data get storage test: gather_state.$(dim).$(point).ready_at
