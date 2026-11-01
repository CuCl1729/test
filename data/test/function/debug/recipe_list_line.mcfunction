#> test:debug/recipe_list_line
# @s = プレイヤー。@macro name/st/shape_text/mat_text: 1件ぶん(出るものは debug_work.rl.out から出す)

$tellraw @s [{text:" $(name) ",color:"gold"},{text:"[$(st)] ",color:"aqua"},{text:"$(shape_text) ",color:"white"},{text:"$(mat_text) → ",color:"gray"},{storage:"test:",nbt:"debug_work.rl.out.kind",color:"green"},{text:":",color:"green"},{storage:"test:",nbt:"debug_work.rl.out.id",color:"green"},{text:" x",color:"green"},{storage:"test:",nbt:"debug_work.rl.out.count",color:"green"}]
