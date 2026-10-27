#> test:station/migrate_one
# @s = 古いステーションのマーカー。@macro old: 古いタグ / id・mode: 新しいステーションの種類とモード番号

$data modify entity @s data.station set value {id:"$(id)",mode:$(mode)}
tag @s add station
$tag @s remove $(old)
tag @s remove station_decorated
