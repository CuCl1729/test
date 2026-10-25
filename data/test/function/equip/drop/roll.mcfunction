#> test:equip/drop/roll
# @s = 報酬を受け取るプレイヤー。@macro id/chance: 装備idと落とす確率(%)。
# 当たればレア度3〜4で作って渡す(サブステータスは test:asset/equip/apply がレア度に応じて付ける)。
# 戦闘の報酬は配った直後にアリーナから戻されるので、足元に落とさずインベントリへ直接入れる(loot.context:"inventory")

execute store result score #equip_drop_roll test.temporary run function test:rng/roll {key:"equip_drop",min:1,max:100}
$execute unless score #equip_drop_roll test.temporary matches ..$(chance) run return 0

execute store result storage test: loot.rare int 1 run function test:rng/roll {key:"equip_drop_rare",min:3,max:4}
data modify storage test: loot.context set value "inventory"
$function test:asset/equip/apply {id:"$(id)"}
data remove storage test: loot.context
