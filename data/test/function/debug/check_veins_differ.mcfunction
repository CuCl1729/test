#> test:debug/check_veins_differ
# @macro x/y/z/vein/other_vein: 同じ位置で鉱脈が違うアマスタの1行(vein は action、other_vein は turn)。
# [actionに合わせる] は turn を action の鉱脈に、[turnに合わせる] は action を turn の鉱脈に置き換える

scoreboard players add #vein_issues test.temporary 1
$tellraw @a[tag=debug_vein_viewer] [{text:" $(x) $(y) $(z) ",color:gray},{text:"action:",color:gray},{text:"$(vein)",color:gold},{text:" turn:",color:gray},{text:"$(other_vein)",color:gold},{text:" 違う ",color:red},{text:"[actionに合わせる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/vein_fix_place {dim:turn,x:$(x),y:$(y),z:$(z),id:$(vein)}"}},{text:" "},{text:"[turnに合わせる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/vein_fix_place {dim:action,x:$(x),y:$(y),z:$(z),id:$(other_vein)}"}}]
