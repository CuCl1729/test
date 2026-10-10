#> test:debug/menu/rng_line
# @macro key/label/range: 抽選1つぶんの宣言。storage test: debug_work.rng_entryにも同じものが入っている(fixableの判定用)
# 1行目に今の状態(ランダム/固定、覚えているシード)、2行目に操作ボタンを出す

# 状態の文字列を組み立てる(値・シードは無ければnbtコンポーネントが空になるので、見出しの文字だけ出し分ける)。
# 文字列タグをnbtコンポーネントでそのまま出すと引用符付きで表示されるため、見出しはテキストコンポーネントの
# compoundで持ち、interpret:trueで描画する(数値の値・シードは引用符が付かないのでそのまま出す)
data modify storage test: debug_work.rng_line set value {state:{text:"ランダム"},value_label:{text:""},seed_label:{text:""}}
$execute if data storage test: debug.rng.$(key){mode:"min"} run data modify storage test: debug_work.rng_line.state set value {text:"最小に固定"}
$execute if data storage test: debug.rng.$(key){mode:"max"} run data modify storage test: debug_work.rng_line.state set value {text:"最大に固定"}
$execute if data storage test: debug.rng.$(key){mode:"value"} run data modify storage test: debug_work.rng_line.state set value {text:"値に固定"}
$execute if data storage test: debug.rng.$(key){mode:"value"} run data modify storage test: debug_work.rng_line.value_label set value {text:" = "}
$execute if data storage test: debug.rng.$(key).seed run data modify storage test: debug_work.rng_line.seed_label set value {text:" / シード "}

$tellraw @s [{text:"・$(label) ",color:white},{text:"($(range)) ",color:dark_gray},{nbt:"debug_work.rng_line.state",storage:"test:",interpret:true,color:yellow},{nbt:"debug_work.rng_line.value_label",storage:"test:",interpret:true,color:yellow},{nbt:"debug.rng.$(key).value",storage:"test:",color:yellow},{nbt:"debug_work.rng_line.seed_label",storage:"test:",interpret:true,color:aqua},{nbt:"debug.rng.$(key).seed",storage:"test:",color:aqua}]

$execute if data storage test: debug_work.rng_entry{fixable:1b} run tellraw @s [{text:"    "},{text:"[ランダム]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/set {key:\"$(key)\",mode:\"random\"}"}},{text:" "},{text:"[最小]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/set {key:\"$(key)\",mode:\"min\"}"}},{text:" "},{text:"[最大]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/set {key:\"$(key)\",mode:\"max\"}"}},{text:" "},{text:"[値…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/rng/set_value {key:\"$(key)\",value:0}"}},{text:" "},{text:"[シード…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/rng/seed {key:\"$(key)\",seed:0}"}},{text:" "},{text:"[再現]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/replay {key:\"$(key)\"}"}}]
$execute unless data storage test: debug_work.rng_entry{fixable:1b} run tellraw @s [{text:"    "},{text:"[シード…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/rng/seed {key:\"$(key)\",seed:0}"}},{text:" "},{text:"[再現]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/rng/replay {key:\"$(key)\"}"}},{text:" (固定すると引き直しが終わらなくなるため、シードのみ)",color:dark_gray}]
