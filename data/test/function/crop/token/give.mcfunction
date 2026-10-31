#> test:crop/token/give
# @s = プレイヤー。@macro item/min/max: 1行。個数を決めて(rng のキー crop_drop)、普通のバニラのアイテムを渡す
# (custom_data は付けない。食べ物としてそのまま使える。give は入りきらない分を足元に落とすので消えない)

$execute store result score #crop_count test.temporary run function test:rng/roll {key:"crop_drop",min:$(min),max:$(max)}
execute if score #crop_count test.temporary matches ..0 run return 0
execute store result storage test: crop_work.give.count int 1 run scoreboard players get #crop_count test.temporary
$data modify storage test: crop_work.give.item set value "$(item)"
function test:crop/token/give_item with storage test: crop_work.give
