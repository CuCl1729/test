#> test:ui/status/build_book
# @macro level,exp,skill_point,hp,hp_max,mp,mp_max,atk,def,crit_rate,crit_damage: 表示するステータス値

data remove storage test: loot.item
data modify storage test: loot.item.id set value written_book
$data modify storage test: loot.item.components.minecraft:written_book_content set value {title:"ステータス",author:"System",generation:0,resolved:1b,pages:[[{text:"==== ステータス ====\n\n",color:gold},{text:"Lv.$(level)  EXP:$(exp)  SP:$(skill_point)\n\n"},{text:"HP: $(hp)/$(hp_max)\n"},{text:"MP: $(mp)/$(mp_max)\n\n"},{text:"ATK: $(atk)  DEF: $(def)\n"},{text:"会心率: $(crit_rate)  会心ダメージ: $(crit_damage)"}]]}

function test:loot/give
