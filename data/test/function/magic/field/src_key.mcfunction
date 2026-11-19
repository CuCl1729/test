#> test:magic/field/src_key
# @macro fid: この場の通し番号(ほかのキーも渡ってくるが使わない)。
# 付与元のキーを "f<通し番号>" にする。場ごとに別の名前になるので、
# 同じidのバフを重ねている別の場のぶんと混ざらない
$data modify storage test: buff_work.src_arg.key set value "f$(fid)"
