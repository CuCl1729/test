#> test:debug/quest_op
# @s = プレイヤー。@macro id/op: クエストと操作(start 受ける / advance 段階を進める / complete 完了にする / reset 未受注に戻す)。終えたら一覧を出し直す

function #oh_my_dat:please
$function test:debug/quest_op_$(op) {id:"$(id)"}
function #oh_my_dat:please
function test:debug/quest_list
