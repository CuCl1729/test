#> test:projectile/event_loop
# @s = イベントが起きた投射体。タイプレジストリを1件ずつ取り出してハンドラの有無を調べる

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

# マクロで$(id)と$(event)の両方を使えるよう、エントリにイベント名を載せてから渡す
data modify storage test: registry_work.type_entry.event set from storage test: registry_work.event
function test:projectile/event_type with storage test: registry_work.type_entry

function test:projectile/event_loop
