#> test:machine/eject
# @s = 機械のマーカー(実行位置は入れ物)。@macro Slot: 入れ物の中のスロット(ほかのキーも渡ってくるが使わない)。
# そのスロットのものを丸ごと、出すもの(machine_work.drop)に移す。搬出口に入れるのは test:machine/port/out/place_all

$data modify storage test: machine_work.drop append from block ~ ~ ~ Items[{Slot:$(Slot)b}]
data remove storage test: machine_work.drop[-1].Slot
$data remove block ~ ~ ~ Items[{Slot:$(Slot)b}]
