#> test:machine/pre/product
# @macro machine/kind/rare/next: 機械・原石の種類・レア度・作る段階。加工途中の原石を1個、出すもの(machine_work.drop)に足す

$execute store result score #machine_built test.temporary run function test:item/ore/build {id:"$(kind)",rare:$(rare),stage:$(next)}
execute if score #machine_built test.temporary matches 0 run return 0
data modify storage test: loot.item.count set value 1
data modify storage test: machine_work.drop append from storage test: loot.item
$function test:debug/log {msg:"前処理 $(machine): $(kind) レア度$(rare) → 段階$(next)"}
