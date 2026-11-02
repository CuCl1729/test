#> test:debug/menu/page/rng
# @s = メニューを開いたプレイヤー。@macro p: ページ(0から)。乱数の宣言(init/asset/debug/rng)を8個ずつ出す
# (1個に2行使うので、全部出すとチャットの1画面に収まらない)

$scoreboard players set #rng_page test.temporary $(p)
scoreboard players set #rng_left test.temporary 8
scoreboard players operation #rng_skip test.temporary = #rng_page test.temporary
scoreboard players operation #rng_skip test.temporary *= #rng_left test.temporary

scoreboard players operation #rng_shown test.temporary = #rng_page test.temporary
scoreboard players add #rng_shown test.temporary 1

tellraw @s ""
tellraw @s [{text:"― 乱数 ",color:gold},{score:{name:"#rng_shown",objective:"test.temporary"},color:gold},{text:" ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
data modify storage test: debug_work.rng_queue set from storage test: asset.debug.rng
function test:debug/menu/rng_loop

execute store result storage test: debug_work.rng_nav.prev int 1 run scoreboard players remove #rng_page test.temporary 1
execute store result storage test: debug_work.rng_nav.next int 1 run scoreboard players add #rng_page test.temporary 2
function test:debug/menu/rng_nav with storage test: debug_work.rng_nav
