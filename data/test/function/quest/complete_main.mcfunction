#> test:quest/complete_main
# @macro id: 完了したメインクエスト。報酬をパーティの全員に行い、全員に知らせる

$execute as @a at @s run function test:quest/reward {id:"$(id)"}
$tellraw @a [{text:"クエスト完了: ",color:"gold"},{storage:"test:",nbt:"asset.quest.$(id).name",interpret:true,color:"white"}]
execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s

# 報酬を全員に行うと oh_my_dat がほかの人を指すので、@s に戻す(このあと会話などが @s の記録を使う)
function #oh_my_dat:please
