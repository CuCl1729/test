# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/act/a6
# 処理: coin:+50; exp:+20; give:consumable:healing_potion*2

function test:money/give_coins {n:50}
scoreboard players add @s test.status.exp 20
function test:craft/custom/out/consumable {id:"healing_potion"}
data modify storage test: loot.item.count set value 2
execute at @s run function test:item/drop_at
