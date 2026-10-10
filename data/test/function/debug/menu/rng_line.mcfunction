#> test:debug/menu/rng_line
# @macro key/label/range: 抽選1つぶんの宣言。storage test: debug_work.rng_entryにも同じものが入っている(fixableの判定用)
# 1行目に今の状態(ランダム/固定、覚えているシード)、2行目に操作ボタンを出す

# 状態の文字列を組み立てる(値・シードは無ければnbtコンポーネントが空になるので、見出しの文字だけ出し分ける)
data modify storage test: debug_work.rng_line set value {state:"ランダム",value_label:"",seed_label:""}
$execute if data storage test: debug.rng.$(key){mode:"min"} run data modify storage test: debug_work.rng_line.state set value "最小に固定"
$execute if data storage test: debug.rng.$(key){mode:"max"} run data modify storage test: debug_work.rng_line.state set value "最大に固定"
$execute if data storage test: debug.rng.$(key){mode:"value"} run data modify storage test: debug_work.rng_line.state set value "値に固定"
$execute if data storage test: debug.rng.$(key){mode:"value"} run data modify storage test: debug_work.rng_line.value_label set value " = "
$execute if data storage test: debug.rng.$(key).seed run data modify storage test: debug_work.rng_line.seed_label set value " / シード "

$tellraw @s [{text:"・$(label) ",color:white},{text:"($(range)) ",color:dark_gray},{nbt:"debug_work.rng_line.state",storage:"test:",color:yellow},{nbt:"debug_work.rng_line.value_label",storage:"test:",color:yellow},{nbt:"debug.rng.$(key).value",storage:"test:",color:yellow},{nbt:"debug_work.rng_line.seed_label",storage:"test:",color:aqua},{nbt:"debug.rng.$(key).seed",storage:"test:",color:aqua}]

$execute if data storage test: debug_work.rng_entry{fixable:1b} run tellraw @s [{text:"    "},{text:"[ランダム]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/set {key:\"$(key)\",mode:\"random\"}"}},{text:" "},{text:"[最小]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/set {key:\"$(key)\",mode:\"min\"}"}},{text:" "},{text:"[最大]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/set {key:\"$(key)\",mode:\"max\"}"}},{text:" "},{text:"[値…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/rng/set_value {key:\"$(key)\",value:0}"}},{text:" "},{text:"[シード…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/rng/seed {key:\"$(key)\",seed:0}"}},{text:" "},{text:"[再現]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/replay {key:\"$(key)\"}"}}]
$execute unless data storage test: debug_work.rng_entry{fixable:1b} run tellraw @s [{text:"    "},{text:"[シード…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/rng/seed {key:\"$(key)\",seed:0}"}},{text:" "},{text:"[再現]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/replay {key:\"$(key)\"}"}},{text:" (固定すると引き直しが終わらなくなるため、シードのみ)",color:dark_gray}]
