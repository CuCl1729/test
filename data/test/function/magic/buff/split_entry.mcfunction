#> test:magic/buff/split_entry
# @macro id: バフid。レジストリの kind を見て敵向け/味方向けへ振り分ける
# (リスト要素の絞り込みは1つのフィルタにまとめて書くこと。
#  types[{id:"x"}]{kind:"debuff"} のように分けて書くとパスとして不正になり関数ごと動かなくなる)

$execute if data storage test: asset.buff.types[{id:"$(id)",kind:"debuff"}] run data modify storage test: magic_buff.debuff append from storage test: magic_buff.entry
$execute unless data storage test: asset.buff.types[{id:"$(id)",kind:"debuff"}] run data modify storage test: magic_buff.buff append from storage test: magic_buff.entry
