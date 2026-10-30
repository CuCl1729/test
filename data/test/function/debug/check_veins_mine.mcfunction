#> test:debug/check_veins_mine
# @macro id: 鉱山のid。その鉱山の範囲の中のアマスタを、両方のマップから見て比べる

$function test:debug/mine_area {id:"$(id)"}
execute store result score #vein_ok test.temporary run function test:debug/check_veins_loaded with storage test: debug_work.mine_area
$execute if score #vein_ok test.temporary matches 0 run return run tellraw @a[tag=debug_vein_viewer] [{text:"$(id): ",color:gold},{text:"読み込まれていない ",color:red},{text:"[鉱山を読み込む]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:add}"}}]

$tellraw @a[tag=debug_vein_viewer] {text:"$(id):",color:gold}
scoreboard players set #vein_issues test.temporary 0
function test:debug/check_veins_area with storage test: debug_work.mine_area
execute if score #vein_issues test.temporary matches 0 run tellraw @a[tag=debug_vein_viewer] {text:" ずれなし",color:gray}
