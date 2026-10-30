#> test:machine/status_label
# @s = 機械のマーカー。@macro name/label/fuel: 名前・状態・燃料の回数(ほかのキーも渡ってくるが使わない)

$data modify entity @s data.machine.label set value "$(name) [$(label)] 燃料 $(fuel)"
