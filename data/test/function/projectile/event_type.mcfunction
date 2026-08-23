#> test:projectile/event_type
# @s = イベントが起きた投射体。@macro id: タイプid  @macro event: イベント名
# 投射体がそのタイプを持ち、かつレジストリでそのイベントを宣言していればハンドラを呼ぶ

$execute unless entity @s[tag=$(id)] run return 0
$execute unless data storage test: asset.magic.types[{id:"$(id)"}].projectile_events.$(event) run return 0

# 直前までの結果を退避してからハンドラを呼び、より強い(大きい)結果を残す
scoreboard players operation #event_result_prev test.temporary = #event_result test.temporary
scoreboard players set #event_result test.temporary 0

$function test:projectile/on/$(event)/$(id)

execute if score #event_result_prev test.temporary > #event_result test.temporary run scoreboard players operation #event_result test.temporary = #event_result_prev test.temporary
