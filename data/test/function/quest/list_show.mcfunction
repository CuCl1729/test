#> test:quest/list_show
# @s = プレイヤー。@macro id/stage: 受けているクエストと今の段階

data modify storage test: quest_work.lk set value ""
$execute if data storage test: asset.quest.$(id){main:1b} run data modify storage test: quest_work.lk set value "(メイン)"
$tellraw @s [{text:" ",color:"white"},{storage:"test:",nbt:"asset.quest.$(id).name",interpret:true,color:"white"},{storage:"test:",nbt:"quest_work.lk",interpret:true,color:"gold"},{text:": ",color:"gray"},{storage:"test:",nbt:"asset.quest.$(id).stages.s$(stage).desc",interpret:true,color:"white"},{text:" ",color:"gray"},{storage:"test:",nbt:"quest_work.st.count",color:"aqua"},{text:"/",color:"aqua"},{storage:"test:",nbt:"asset.quest.$(id).stages.s$(stage).count",color:"aqua"}]
