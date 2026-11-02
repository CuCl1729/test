#> test:gather/place/def
# @macro type: 採取物(ほかのキーも渡ってくるが使わない)。gather_work.p(ポイントの {type, x, y, z})に、その採取物の見た目 block を足す。
# 置いたエンティティは、この形を data.gather.def に持つ(見た目を変えたときも置き直すため。test:gather/place/check)
$data modify storage test: gather_work.p.block set from storage test: asset.gather.$(type).block
