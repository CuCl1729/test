#> test:battle/action/job_skill/handler/self_buff
# @s = 詠唱者(手番)。@macro buff_id/stacks: このスキルのparamsがそのままmacro展開されている。
# バフ系は文脈に依存しないため実装をリアルタイムと共有し、最後にターンを終える

$function test:job/skill/handler/self_buff {buff_id:"$(buff_id)",stacks:$(stacks)}

function test:battle/turn_end
