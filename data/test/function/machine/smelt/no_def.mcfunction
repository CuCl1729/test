#> test:machine/smelt/no_def
# @macro kind: 原石の種類(ほかのキーも渡ってくるが使わない)。主産物の行が無い原石(定義が消えたものなど)。何も出さない

$function test:debug/log {msg:"精錬: 原石「$(kind)」の主産物がありません"}
