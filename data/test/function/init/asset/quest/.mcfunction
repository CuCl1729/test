#> test:init/asset/quest/
# クエストのレジストリ(スプレッドシートの「クエスト」「クエストの段階」タブから生成)。asset.quest.<id> と asset.quest_ids

data modify storage test: asset.quest set value {}
data modify storage test: asset.quest_ids set value []
function test:init/asset/quest/generated/quests
