#> test:debug/research_show_scan
# @s = プレイヤー。@macro id: 観測のid

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scanned.$(id) run tellraw @s [{text:" $(id) ",color:"gold"},{storage:"test:",nbt:"asset.scan.$(id).name",color:"white"}]
