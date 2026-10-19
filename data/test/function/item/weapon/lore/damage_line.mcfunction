#> test:item/weapon/lore/damage_line
# @macro elem/icon/label/color: 属性1つぶんの表示定義(loot.table.element_display)。
# damage.<elem>にある係数だけを「攻撃力の200% + HPの10% + 防御力の5% + 200」の形で並べる
# (係数の意味はtest:damage/pre_attackと同じ。atk/hp_max/defは%、baseは固定値)

$execute unless data storage test: lore_work.data.damage.$(elem) run return 0

function test:item/weapon/lore/line_begin
$data modify storage test: lore_work.line append value {text:"$(icon) ",color:"$(color)"}
$data modify storage test: lore_work.line append value {text:"$(label)ダメージ ",color:"gray"}

# 2つ目以降の項の前にだけ「 + 」を入れる
scoreboard players set #lore_terms test.temporary 0

$execute if data storage test: lore_work.data.damage.$(elem).atk run function test:item/weapon/lore/damage_term {elem:"$(elem)",key:"atk",label:"攻撃力の",unit:"%"}
$execute if data storage test: lore_work.data.damage.$(elem).hp_max run function test:item/weapon/lore/damage_term {elem:"$(elem)",key:"hp_max",label:"HPの",unit:"%"}
$execute if data storage test: lore_work.data.damage.$(elem).def run function test:item/weapon/lore/damage_term {elem:"$(elem)",key:"def",label:"防御力の",unit:"%"}
$execute if data storage test: lore_work.data.damage.$(elem).base run function test:item/weapon/lore/damage_term {elem:"$(elem)",key:"base",label:"",unit:""}

function test:item/weapon/lore/commit
