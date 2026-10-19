#> test:item/weapon/lore/num_colored
# @macro color: 数字の色。storage test: lore_work.n の数値を小数第2位までの文字にして行(lore_work.line)に足す。
# doubleを100倍して切り捨てると0.29が28になるような誤差が出るので、1000倍してから四捨五入で100倍の整数にする。
# 小数部は0なら省き、末尾の0も省く(30 / 2.5 / 2.64 / 1.05)。
# 数字はscoreコンポーネントのままだと説明文では解決されないため、@n[tag=text](text_display)に一度読み込ませて
# 解決済みの文字にしてから足す(色を付けたcompoundにしておくと、解決後もcompoundのまま取り出せる)

execute store result score #lore_v test.temporary run data get storage test: lore_work.n 1000
scoreboard players add #lore_v test.temporary 5
scoreboard players operation #lore_v test.temporary /= #10 test.constant

scoreboard players operation #lore_int test.temporary = #lore_v test.temporary
scoreboard players operation #lore_int test.temporary /= #100 test.constant
scoreboard players operation #lore_frac test.temporary = #lore_v test.temporary
scoreboard players operation #lore_frac test.temporary %= #100 test.constant

$data modify storage test: lore_work.num set value {text:"",color:"$(color)",extra:[{score:{name:"#lore_int",objective:"test.temporary"}}]}

scoreboard players operation #lore_digit test.temporary = #lore_frac test.temporary
scoreboard players operation #lore_digit test.temporary %= #10 test.constant
execute if score #lore_frac test.temporary matches 1.. if score #lore_digit test.temporary matches 0 run scoreboard players operation #lore_frac test.temporary /= #10 test.constant
execute if score #lore_frac test.temporary matches 1.. if score #lore_digit test.temporary matches 0 run data modify storage test: lore_work.num.extra append value {text:"."}
execute if score #lore_frac test.temporary matches 1..9 unless score #lore_digit test.temporary matches 0 run data modify storage test: lore_work.num.extra append value {text:".0"}
execute if score #lore_frac test.temporary matches 10.. unless score #lore_digit test.temporary matches 0 run data modify storage test: lore_work.num.extra append value {text:"."}
execute if score #lore_frac test.temporary matches 1.. run data modify storage test: lore_work.num.extra append value {score:{name:"#lore_frac",objective:"test.temporary"}}

data modify entity @n[tag=text] text set from storage test: lore_work.num
data modify storage test: lore_work.line append from entity @n[tag=text] text
