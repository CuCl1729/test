#> test:money/give_coins
# @s = プレイヤー。@macro n: 金額。大きいコインから作って足元に落とす(すぐ拾われる。持ち物がいっぱいならそのまま落ちている)。
# クエストの報酬(処理 coin:+)・銀行の引き出し・払ったときのお釣りで使う

$scoreboard players set #gn test.temporary $(n)
scoreboard players operation #gk test.temporary = #gn test.temporary
scoreboard players operation #gk test.temporary /= #100 test.constant
function test:money/give_kind {value:100}
scoreboard players operation #gn test.temporary %= #100 test.constant
scoreboard players operation #gk test.temporary = #gn test.temporary
scoreboard players operation #gk test.temporary /= #10 test.constant
function test:money/give_kind {value:10}
scoreboard players operation #gn test.temporary %= #10 test.constant
scoreboard players operation #gk test.temporary = #gn test.temporary
function test:money/give_kind {value:1}
