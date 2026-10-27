#> test:station/decorate_by_id
# @s = ステーションのマーカー。@macro id: ステーションの種類。レジストリの name/color/icon で飾りを付ける
# (GUIの題名はこの後 test:station/enter_mode がモード名付きに直す)

$function test:station/decorate with storage test: asset.station.$(id)
