# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/cond/c4
# 条件: quest:village=done

execute unless data storage test: story.quest.village{state:"done"} run return 0
return 1
