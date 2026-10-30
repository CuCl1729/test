#> test:debug/check_veins_missing
# @macro dim/other/x/y/z/vein: 片方(dim)にしか無いアマスタの1行。[置く] はもう片方に置き、[消す] はこちらから消す

scoreboard players add #vein_issues test.temporary 1
$tellraw @a[tag=debug_vein_viewer] [{text:" $(x) $(y) $(z) ",color:gray},{text:"$(vein)",color:gold},{text:" $(other)に無い ",color:red},{text:"[置く]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/vein_fix_place {dim:$(other),x:$(x),y:$(y),z:$(z),id:$(vein)}"}},{text:" "},{text:"[消す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/vein_fix_remove {dim:$(dim),x:$(x),y:$(y),z:$(z)}"}}]
return 1
