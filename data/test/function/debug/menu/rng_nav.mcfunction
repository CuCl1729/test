#> test:debug/menu/rng_nav
# @macro prev/next: 前と次のページ。前のページがあれば [◀ 前]、出し切れなかった宣言が残っていれば [次 ▶] を出す
$execute if score #rng_page test.temporary matches 2.. run tellraw @s {text:"[◀ 前]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/rng {p:$(prev)}"}}
$execute if data storage test: debug_work.rng_queue[0] run tellraw @s {text:"[次 ▶]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/rng {p:$(next)}"}}
