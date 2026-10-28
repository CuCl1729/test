#> test:battle/action/item_line
# @s = プレイヤー。@macro id/count/index: 消耗品のid・持っている数・番号。「[名前] x数」の1行を出す

$tellraw @s [{text:"[",color:green,click_event:{action:"run_command",command:"/trigger test.battle.item_select set $(index)"},extra:[{storage:"test:",nbt:"asset.consumable.$(id).name"},{text:"]"},{text:" x$(count)",color:gray}]}]
