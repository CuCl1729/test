#> test:equip/drop/give
# @s = 報酬を受け取るプレイヤー。@macro id: 落ちた装備のid。レア度を3〜4で抽選して(rng のキー equip_drop_rare。人ごと)作って渡す
# (サブステータスなどは test:asset/equip/apply がレア度に応じて人ごとに付ける)。
# 戦闘の報酬は配った直後にアリーナから戻されるので、足元に落とさずインベントリへ直接入れる(loot.context:"inventory")

execute store result storage test: loot.rare int 1 run function test:rng/roll {key:"equip_drop_rare",min:3,max:4}
data modify storage test: loot.context set value "inventory"
$function test:asset/equip/apply {id:"$(id)"}
data remove storage test: loot.context
