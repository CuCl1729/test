#> test:machine/status_label
# @s = 機械のマーカー。@macro name/label: 名前と状態(ほかのキーも渡ってくるが使わない)

$data modify entity @s data.machine.label set value "$(name) [$(label)]"
