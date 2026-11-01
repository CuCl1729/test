#> test:craft/custom/place_out
# 実行位置 = 樽。@macro kind/id/count: 出るもの。test:craft/custom/out/<種類> で loot.item に作り、個数を入れて結果の枠(16)に置く

$function test:craft/custom/out/$(kind) {id:"$(id)"}
$data modify storage test: loot.item.count set value $(count)
data modify storage test: loot.item.Slot set value 16b
data modify block ~ ~ ~ Items append from storage test: loot.item
data remove storage test: loot.item.Slot
