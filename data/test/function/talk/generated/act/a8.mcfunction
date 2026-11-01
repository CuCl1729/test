# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/act/a8
# 処理: story:decided=1; coin:+100

data modify storage test: story.flag.decided set value 1
function test:money/give_coins {n:100}
