#> test:quest/st_get
# @macro id: クエスト。状態(メインは storage test: story.quest.<id>、サブは @s の oh_my_dat の test.quest.<id>)を quest_work.st に写す
# (無ければ {state:"none", stage:0, count:0})。サブのときは oh_my_dat が @s を指していること

data modify storage test: quest_work.st set value {state:"none",stage:0,count:0}
$execute if data storage test: asset.quest.$(id){main:1b} run return run data modify storage test: quest_work.st merge from storage test: story.quest.$(id)
$data modify storage test: quest_work.st merge from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.quest.$(id)
