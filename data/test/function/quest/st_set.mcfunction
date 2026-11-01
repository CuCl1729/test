#> test:quest/st_set
# @macro id: クエスト。quest_work.st を状態の場所に書き戻す

$execute if data storage test: asset.quest.$(id){main:1b} run return run data modify storage test: story.quest.$(id) set from storage test: quest_work.st
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.quest.$(id) set from storage test: quest_work.st
