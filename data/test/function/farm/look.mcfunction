#> test:farm/look
# @s = 魔法作物(interaction)。@macro stage: 今の段階(ほかのキーも渡ってくるが使わない)。farm_work.def(その魔法作物の定義)の
# ages[段階] の age で、見た目(同じブロックの角の block_display)を変える。26.3 の block_state は {id, properties} の形

data modify storage test: farm_work.look set value {block:"",age:0}
data modify storage test: farm_work.look.block set from storage test: farm_work.def.block
$data modify storage test: farm_work.look.age set from storage test: farm_work.def.ages[$(stage)]
function test:farm/look_set with storage test: farm_work.look
