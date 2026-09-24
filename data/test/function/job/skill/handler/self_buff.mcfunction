#> test:job/skill/handler/self_buff
# @s = 発動するプレイヤー(職業スキル)。@macro buff_id/stacks: このスキルのparamsがそのまま
# macro展開されている。既存のtest:buff/apply_listへそのまま渡すだけ(リアルタイム/ターン制で共通)

data modify storage test: buff_work.pending set value [{id:"",stacks:0}]
$data modify storage test: buff_work.pending[0].id set value "$(buff_id)"
$data modify storage test: buff_work.pending[0].stacks set value $(stacks)

function test:buff/apply_list
