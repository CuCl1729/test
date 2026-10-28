#> test:loot/roll_substatus_type
# サブステータスの種類(loot.table.substatusの添字)を0..storage test: loot.substatus_maxで引き、戻り値で返す。
# 武器は loot.table.substatus_weapon_max、防具・アクセサリーは loot.table.substatus_armor_max(どちらも「ステータス」タブから生成)。
# 呼ぶ側が先にloot.substatus_maxを入れておくこと

data modify storage test: rng_args set value {key:"substatus_type",min:0,max:9}
execute if data storage test: loot.substatus_max run data modify storage test: rng_args.max set from storage test: loot.substatus_max
return run function test:rng/roll with storage test: rng_args
