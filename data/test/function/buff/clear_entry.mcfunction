#> test:buff/clear_entry
# @macro = バフインスタンス1件。理由は呼び出し元がbuff_work.clear_reasonへ入れてある

$data modify storage test: buff_work.fire append value {event:"expire",id:"$(id)",stacks:$(stacks),reason:"clear",at:0}
data modify storage test: buff_work.fire[-1].reason set from storage test: buff_work.clear_reason
