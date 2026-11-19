#> test:magic/beam/root/register_entry
# @macro owner/root/dimension: ちょうど同じ持ち主+ルートの記録が無ければ magic_beam_roots に追加する。
# 既にあれば何もしない(重複発動で古い記録のdimensionを上書きしないため)
$execute unless data storage test: magic_beam_roots[{owner:$(owner),root:$(root)}] run data modify storage test: magic_beam_roots append value {owner:$(owner),root:$(root),dimension:"$(dimension)"}
return 1
