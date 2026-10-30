#> test:machine/fuel/is_fuel
# @macro id: アイテムのid(入れ物の中の1スロット。ほかのキーも渡ってくるが使わない)。燃料なら1、そうでなければ0を返す
# (アイテムのidだけで判定し、custom_data は見ない)

$execute if data storage test: asset.fuel."$(id)" run return 1
return 0
