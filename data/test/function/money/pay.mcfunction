#> test:money/pay
# @s = プレイヤー。@macro n: 払う金額。店の買い物と処理 money:- が使う。持っているコインと口座の合計が足りなければ何もせず0を返す。
# 足りれば、持っているコインを全部消してその合計から払い、足りない分を口座から引く。コインが多ければお釣りをコインで返す(1を返す)。
# コインを全部消してからお釣りを返すので、銅貨・銀貨・金貨の組み合わせは変わることがある(合計は正しい)

$scoreboard players set #pn test.temporary $(n)
execute store result score #pc test.temporary run function test:money/coins
scoreboard players add @s test.money 0
scoreboard players operation #pt test.temporary = #pc test.temporary
scoreboard players operation #pt test.temporary += @s test.money
execute if score #pt test.temporary < #pn test.temporary run return 0
clear @s *[minecraft:custom_data~{test:{coin:1}}]
clear @s *[minecraft:custom_data~{test:{coin:10}}]
clear @s *[minecraft:custom_data~{test:{coin:100}}]
execute if score #pc test.temporary >= #pn test.temporary run function test:money/pay_change
execute if score #pc test.temporary < #pn test.temporary run function test:money/pay_bank
return 1
